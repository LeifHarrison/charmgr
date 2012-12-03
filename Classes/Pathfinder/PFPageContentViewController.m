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

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFPageContentViewController ()

@property (nonatomic, strong) NSMutableArray *containers;
@property (nonatomic, strong) NSMutableArray *gestures;
@property (nonatomic, assign) CGPoint activeContainerOriginalCenter;

- (void)setContainerTapGesturesEnabled:(BOOL)enabled excludingGesture:(UIGestureRecognizer*)aGesture;

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
	
	self.containers = [NSMutableArray array];
	self.gestures = [NSMutableArray array];
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

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	LOG_DEBUG(@"frame = %@", NSStringFromCGRect(self.view.frame));
	if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
		for (PFContainerViewController *controller in self.containers) {
			controller.view.superview.frame = controller.staticFramePortrait;
		}
	}
	else {
		for (PFContainerViewController *controller in self.containers) {
			controller.view.superview.frame = controller.staticFrameLandscape;
		}
	}
}

//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	//LOG_DEBUG(@"seque = %@, sender = %@", segue.identifier, sender);
	
	if ([segue.identifier hasSuffix:@"Container"]) {
		PFContainerViewController *controller = segue.destinationViewController;
		controller.delegate = self;
		controller.character = self.character;
		[self.containers addObject:controller];
		/*
		 UIGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(containerViewLongPress:)];
		 gesture.delegate = controller;
		 [controller.view addGestureRecognizer:gesture];
		 [self.gestures addObject:gesture];
		 */
	    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(containerViewTapped:)];
		gesture.delegate = controller;
		gesture.cancelsTouchesInView = YES;
		gesture.delaysTouchesEnded = YES;
		[controller.view addGestureRecognizer:gesture];
		[self.gestures addObject:gesture];
		
	}
}


//------------------------------------------------------------------------------
#pragma mark - Gestures
//------------------------------------------------------------------------------

- (void)containerViewTapped:(UIGestureRecognizer*)gesture
{
	LOG_DEBUG(@"gesture.state = %d", gesture.state);
	if (gesture.state == UIGestureRecognizerStateEnded) {
		PFContainerViewController *controller = (PFContainerViewController*)gesture.delegate;
		//[controller.view removeGestureRecognizer:gesture];
		[self setContainerTapGesturesEnabled:NO excludingGesture:nil];
		[self transitionContainer:controller
						  toState:PFContainerViewStateEditing];
	}
}

- (void)containerViewLongPress:(UIGestureRecognizer*)gesture
{
	LOG_DEBUG(@"gesture.state = %d", gesture.state);
	if (gesture.state == UIGestureRecognizerStateEnded) {
		PFContainerViewController *controller = (PFContainerViewController*)gesture.delegate;
		//[controller.view removeGestureRecognizer:gesture];
		[self setContainerTapGesturesEnabled:NO excludingGesture:nil];
		[self transitionContainer:controller
						  toState:PFContainerViewStateEditing];
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

- (void)setContainerTapGesturesEnabled:(BOOL)enabled excludingGesture:(UIGestureRecognizer*)aGesture
{
	for (UIGestureRecognizer *recognizer in self.gestures) {
		if (recognizer != aGesture) recognizer.enabled = enabled;
	}
}

- (void)transitionContainer:(PFContainerViewController*)container
					toState:(PFContainerViewState)newState
{
	LOG_DEBUG(@"newState = %d, container = %@", newState, container);
	
	UIView *containerView = container.view.superview;
	
	CMRootViewController *rootController = (CMRootViewController *)[[self.view window] rootViewController];
	LOG_DEBUG(@"rootController = %@", rootController);
	if (newState == PFContainerViewStateEditing) {
		[rootController setPageTurningEnabled:NO];
	}
	
	[container willTransitionToState:newState];
	[self.view bringSubviewToFront:containerView];
	
	void (^animations) (void) = ^{
		//CGAffineTransform transform = CGAffineTransformIdentity;
		
		if (newState == PFContainerViewStateEditing) {
			CGPoint viewCenter = self.view.center;
			LOG_DEBUG(@"viewCenter = %@", NSStringFromCGPoint(viewCenter));
			CGPoint containerCenter = containerView.center;
			self.activeContainerOriginalCenter = containerCenter;
			LOG_DEBUG(@"activeContainerOriginalCenter = %@", NSStringFromCGPoint(self.activeContainerOriginalCenter));
			
			containerView.center = viewCenter;
			containerView.bounds = container.editingBounds;
			//containerView.layer.shadowOpacity = 0.7;
		}
		else {
			LOG_DEBUG(@"activeContainerOriginalCenter = %@", NSStringFromCGPoint(self.activeContainerOriginalCenter));
			if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
				containerView.frame = [container staticFramePortrait];
			else
				containerView.frame = [container staticFrameLandscape];
			//containerView.layer.shadowOpacity = 0.0;
		}
		
		container.state = newState;
		[container animateTransitionToState:newState];
    };
    
    void (^completion) (BOOL) = ^(BOOL finished) {
		//[self.view bringSubviewToFront:containerView];
		
		container.state = newState;
		[container didTransitionToState:newState];
		if (newState == PFContainerViewStateStatic) {
			[self setContainerTapGesturesEnabled:YES excludingGesture:nil];
			[rootController setPageTurningEnabled:YES];
		}
		else {
			//containerView.layer.shadowOpacity = 0.7;
		}
    };
	
    [UIView animateWithDuration:0.5
						  delay:0.0
						options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionCurveEaseInOut
					 animations:animations
					 completion:completion];
}

- (void)containerViewController:(PFContainerViewController*)containerViewController
			  didFinishWithSave:(BOOL)save;
{
	TRACE;
	[self transitionContainer:containerViewController
					  toState:PFContainerViewStateStatic];
	
	if (save) {
        NSError *error;
        if (![[self.character managedObjectContext] save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			[[self.character managedObjectContext] rollback];
        }
		
		[self updateContainers];
	}
	else {
		[[self.character managedObjectContext] rollback];
		[containerViewController updateUI];
	}
}


@end
