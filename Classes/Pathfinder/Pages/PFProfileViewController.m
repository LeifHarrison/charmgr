//
//  PFPRofileViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 6/30/11.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFProfileViewController.h"

#import "PFAbilitiesViewController.h"
#import "PFCharacterViewController.h"
#import "PFClassesViewController.h"
#import "PFClassFeaturesViewController.h"
#import "PFSkillsViewController.h"

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFProfileViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFProfileViewController

//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

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
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	TRACE;
    [super viewDidLoad];
	
//	BOOL isPortrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ;
//	
//	PFAbilitiesViewController *abilitiesController = [[PFAbilitiesViewController alloc] initWithNibName:@"PFAbilitiesView" bundle:nil];
//	[self.containers addObject:abilitiesController];
//	abilitiesController.view.frame = isPortrait ? [abilitiesController staticFramePortrait] : [abilitiesController staticFrameLandscape];
//	[self.view addSubview:abilitiesController.view];

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


@end
