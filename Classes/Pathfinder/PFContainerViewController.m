//
//  PFContainerViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import "PFContainerViewController.h"

#import "PFDetailViewController.h"

#define HEADER_BUTTON_ANIMATION_DURATION 0.2

@interface PFContainerViewController ()

@end

@implementation PFContainerViewController

//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.state = PFContainerViewStateStatic;
    }
    return self;
}


//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@synthesize character;
@synthesize state;


//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.2];
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255 green:240.0/255 blue:203.0/255 alpha:0.5];
	
	self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.doneButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.doneButton.layer.borderWidth = 1;
	self.doneButton.layer.cornerRadius = 9.0;
	self.doneButton.backgroundColor = [UIColor lightGrayColor];
	self.doneButton.frame = CGRectMake(8, 3, 55, 20);
	self.doneButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	self.doneButton.titleLabel.font = [UIFont systemFontOfSize:12];
	[self.doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
	self.doneButton.alpha = 0.0;
	[self.doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.doneButton];
	
	self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.cancelButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.cancelButton.layer.borderWidth = 1;
	self.cancelButton.layer.cornerRadius = 9.0;
	self.cancelButton.backgroundColor = [UIColor lightGrayColor];
	self.cancelButton.frame = CGRectMake(8, 3, 55, 20);
	self.cancelButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
	self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:12];
	[self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
	self.cancelButton.alpha = 0.0;
	[self.cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.cancelButton];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    self.cancelButton.frame = CGRectOffset(self.cancelButton.bounds, 8, 3);
	CGFloat doneX = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(self.doneButton.bounds) - 8;
    self.doneButton.frame = CGRectOffset(self.doneButton.bounds, doneX, 3);
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (void)cancel:(id)sender
{
	TRACE;
	[self.delegate containerViewController:self didFinishWithSave:NO];
}

- (void)done:(id)sender
{
	TRACE;
	[self.delegate containerViewController:self didFinishWithSave:YES];
}

- (void)updateUI;
{
	// Default implementation does nothing
}


//------------------------------------------------------------------------------
#pragma mark - State Transitions
//------------------------------------------------------------------------------

- (void)willTransitionToState:(PFContainerViewState)newState;
{
	//LOG_DEBUG(@"newState = %d", newState);
	void (^animations) (void) = ^{
		if (newState == PFContainerViewStateStatic) {
			self.doneButton.alpha = 0.0;
			self.cancelButton.alpha = 0.0;
		}
    };
    void (^completion) (BOOL) = ^(BOOL finished) {
    };
    [UIView animateWithDuration:HEADER_BUTTON_ANIMATION_DURATION
					 animations:animations
					 completion:completion];
}

- (void)didTransitionToState:(PFContainerViewState)newState;
{
	//LOG_DEBUG(@"newState = %d", newState);
	void (^animations) (void) = ^{
		if (newState == PFContainerViewStateEditing) {
			self.doneButton.alpha = 1.0;
			self.cancelButton.alpha = 1.0;
		}
		else {
		}
    };
    void (^completion) (BOOL) = ^(BOOL finished) {
		if (newState == PFContainerViewStateEditing) {
			self.doneButton.enabled = YES;
			self.cancelButton.enabled = YES;
		}
    };
    [UIView animateWithDuration:HEADER_BUTTON_ANIMATION_DURATION
					 animations:animations
					 completion:completion];
}

- (void)animateTransitionToState:(PFContainerViewState)newState;
{
	//LOG_DEBUG(@"newState = %d", newState);
	if (newState == PFContainerViewStateEditing) {
		self.view.backgroundColor = [UIColor colorWithRed:245.0/255 green:240.0/255 blue:203.0/255 alpha:1.0];
	}
	else {
		self.view.backgroundColor = [UIColor colorWithRed:245.0/255 green:240.0/255 blue:203.0/255 alpha:0.5];
	}
}

//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	LOG_DEBUG(@"segue = %@, sender = %@", segue.identifier, sender);
	LOG_DEBUG(@"source = %@, destination = %@", segue.sourceViewController, segue.destinationViewController);
	
	if ([segue.identifier hasSuffix:@"Detail"]) {
		PFDetailViewController *controller = segue.destinationViewController;
		//controller.delegate = self;
		controller.character = self.character;
	}
	
}


//------------------------------------------------------------------------------
#pragma mark - UIGestureRecognizer Delegate
//------------------------------------------------------------------------------

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	//LOG_DEBUG(@"gestureRecognizer = %@, state = %d", gestureRecognizer, self.state);
	return (self.state == PFContainerViewStateStatic);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	//LOG_DEBUG(@"gestureRecognizer = %@, otherGestureRecognizer = %@", gestureRecognizer, otherGestureRecognizer);
	return YES;
}

@end
