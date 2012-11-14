//
//  PFPRofileViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 6/30/11.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFProfileViewController.h"

#import "CMBannerBox.h"

#import "PFContainerViewController.h"

#import "PFAbilitiesViewController.h"
#import "PFCharacterViewController.h"
#import "PFSkillsViewController.h"

#import "PFCharacter.h"

static const CGRect PFCharacterViewFrame = { { 10, 10 }, { 400, 235 } };

@interface PFProfileViewController ()

@property (nonatomic, strong) NSMutableArray *containers;
@property (nonatomic, strong) NSMutableArray *gestures;
@property (nonatomic, assign) CGPoint activeContainerOriginalCenter;

- (void)setContainerTapGesturesEnabled:(BOOL)enabled excludingGesture:(UIGestureRecognizer*)aGesture;

@end

@implementation PFProfileViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	TRACE;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}


//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

- (NSMutableArray*)containers
{
	if (!_containers) {
		_containers = [NSMutableArray arrayWithCapacity:10];
	}
	return _containers;
}

- (NSMutableArray*)gestures
{
	if (!_gestures) {
		_gestures = [NSMutableArray arrayWithCapacity:10];
	}
	return _gestures;
}


//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	TRACE;
    [super viewDidLoad];
}

- (void)viewDidUnload
{
	TRACE;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


//------------------------------------------------------------------------------
#pragma mark - Interface Orientation
//------------------------------------------------------------------------------

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	TRACE;
    // Overriden to allow any orientation.
    return YES;
}


//------------------------------------------------------------------------------
#pragma mark - Memory Management
//------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
	TRACE;
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	LOG_DEBUG(@"seque = %@, sender = %@", segue.identifier, sender);
	
	if ([segue.identifier hasSuffix:@"Container"]) {
		PFContainerViewController *controller = segue.destinationViewController;
		controller.delegate = self;
		controller.character = self.character;
		[self.containers addObject:controller];

	    UIGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(containerViewLongPress:)];
		gesture.delegate = controller;
		[controller.view addGestureRecognizer:gesture];
		[self.gestures addObject:gesture];

	}
}


//------------------------------------------------------------------------------
#pragma mark - Gestures
//------------------------------------------------------------------------------

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
		}
		else {
			LOG_DEBUG(@"activeContainerOriginalCenter = %@", NSStringFromCGPoint(self.activeContainerOriginalCenter));
			containerView.center = self.activeContainerOriginalCenter;
		}
				
		[container animateTransitionToState:newState];
    };
    
    void (^completion) (BOOL) = ^(BOOL finished) {
		//[self.view bringSubviewToFront:containerView];
		
		container.state = newState;
		[container didTransitionToState:newState];
		if (newState == PFContainerViewStateStatic) {
			[self setContainerTapGesturesEnabled:YES excludingGesture:nil];
		}
    };
	
    [UIView animateWithDuration:0.5 animations:animations completion:completion];
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
