//
//  PFPageContentViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import "PFPageContentViewController.h"

#import "PFCharacter.h"

#import "CMRootViewController.h"
#import "CMSettings.h"

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFPageContentViewController ()

@property (nonatomic) NSMutableArray *gestures;
@property (nonatomic) CGPoint activeContainerOriginalCenter;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFPageContentViewController

//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	TRACE;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.containers = [NSMutableArray array];
		self.gestures = [NSMutableArray array];
    }
    return self;
}

- (void)awakeFromNib
{
	TRACE;
	[super awakeFromNib];
	
	if (!self.containers) self.containers = [NSMutableArray array];
	if (!self.gestures) self.gestures = [NSMutableArray array];

}

//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
	TRACE;
    [super viewDidLoad];
	
	self.view.layer.contents = (id)[[[CMSettings sharedSettings] pageBackgroundImage] CGImage];
	//self.view.layer.contents = (id)[UIImage imageNamed:@"paper_texture"].CGImage;
	self.view.layer.contentsGravity = kCAGravityResize;
	//LOG_DEBUG(@"frame = %@", NSStringFromCGRect(self.view.frame));
	//LOG_DEBUG(@"layer frame = %@", NSStringFromCGRect(self.view.layer.frame));
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//LOG_DEBUG(@"frame = %@", NSStringFromCGRect(self.view.frame));
	//LOG_DEBUG(@"layer frame = %@", NSStringFromCGRect(self.view.layer.frame));

	for (PFContainerViewController *aContainer in self.containers) {
		[aContainer updateUI];
	}
	
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	//LOG_DEBUG(@"frame = %@", NSStringFromCGRect(self.view.frame));
	//LOG_DEBUG(@"layer frame = %@", NSStringFromCGRect(self.view.layer.frame));
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


//------------------------------------------------------------------------------
#pragma mark - Interface Orientation
//------------------------------------------------------------------------------

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	//LOG_DEBUG(@"seque = %@, sender = %@", segue.identifier, sender);
	
	if ([segue.identifier hasSuffix:@"Container"]) {
		PFContainerViewController *container = segue.destinationViewController;
		container.character = self.character;
		[self.containers addObject:container];
		
	}
}


//------------------------------------------------------------------------------
#pragma mark - Private
//------------------------------------------------------------------------------

- (void)updateContainers;
{
	for (PFContainerViewController *aContainer in self.containers) {
		[aContainer updateUI];
	}
}

@end
