//
//  PFSelectGenderViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 11/11/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFSelectGenderViewController.h"

#import "PFCharacter.h"

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFSelectGenderViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFSelectGenderViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.segmentedControl.selectedSegmentIndex = self.character.gender;
}

//------------------------------------------------------------------------------
#pragma mark - Memory Management
//------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------------------
#pragma mark - Memory Management
//------------------------------------------------------------------------------

- (IBAction)genderChanged:(id)sender;
{
	UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
	self.character.gender = [segmentedControl selectedSegmentIndex];
	[self.delegate detailViewControllerDidFinish:self];
}

@end
