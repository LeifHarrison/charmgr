//
//  PFEffectsViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/20/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFEffectsViewController.h"

#import "CMBannerBox.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGRect kPFEffectsViewFramePortrait	 = { {  10, 725 }, { 305, 270 } };
static const CGRect kPFEffectsViewFrameLandscape = { { 758, 200 }, { 305, 270 } };
static const CGRect kPFEffectsViewBoundsEditing	 = { {   0,   0 }, { 205, 303 } };

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFEffectsViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFEffectsViewController

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
	
    [(CMBannerBox*)self.view setBannerTitle:@"Effects"];
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
#pragma mark - Private
//------------------------------------------------------------------------------

- (void)updateUI
{
	[super updateUI];
}

//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	return kPFEffectsViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	return kPFEffectsViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	return kPFEffectsViewBoundsEditing;
}

@end
