//
//  PFBaseViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import "PFBaseViewController.h"


@interface PFBaseViewController ()

@end

@implementation PFBaseViewController

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@synthesize character;


//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.layer.contents = (id)[UIImage imageNamed:@"paper_texture"].CGImage;
	self.view.layer.contentsGravity = kCAGravityResize;
	//LOG_DEBUG(@"frame = %@", NSStringFromCGRect(self.view.frame));
	//LOG_DEBUG(@"layer frame = %@", NSStringFromCGRect(self.view.layer.frame));
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//LOG_DEBUG(@"frame = %@", NSStringFromCGRect(self.view.frame));
	//LOG_DEBUG(@"layer frame = %@", NSStringFromCGRect(self.view.layer.frame));
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
