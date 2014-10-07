//
//  PFContainerViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import "PFContainerViewController.h"

#import "PFDetailViewController.h"

#import "PFCharacter.h"

#import "CMBannerBox.h"

#import <CoreData/CoreData.h>

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFContainerViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFContainerViewController

//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.2];
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255 green:240.0/255 blue:203.0/255 alpha:0.5];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(updateUI)
												 name:NSManagedObjectContextDidSaveNotification
											   object:self.character.managedObjectContext];

//	UIView *containerView = [self.view superview];
//	//LOG_DEBUG(@"view = %@, containerView = %@", self.view, containerView);
//	containerView.layer.cornerRadius = self.view.layer.cornerRadius;
//	//LOG_DEBUG(@"corner radius = %lf", containerView.layer.cornerRadius);
//	containerView.layer.masksToBounds = NO;
//	containerView.layer.shadowColor = [UIColor blackColor].CGColor;
//	containerView.layer.shadowOffset = CGSizeMake(0,8);
//	containerView.layer.shadowOpacity = 0.5;
//	containerView.layer.shadowRadius = 10.0;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.character.managedObjectContext];
	[super viewWillDisappear:animated];
}

//------------------------------------------------------------------------------
#pragma mark - Interface Orientation
//------------------------------------------------------------------------------

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//------------------------------------------------------------------------------
#pragma mark - Updating/Saving
//------------------------------------------------------------------------------

- (void)updateUI;
{
	// Default implementation does nothing
}

//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	//LOG_DEBUG(@"segue = %@, sender = %@", segue.identifier, sender);
	//LOG_DEBUG(@"source = %@, destination = %@", segue.sourceViewController, segue.destinationViewController);
}

@end
