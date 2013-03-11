//
//  PFArmorViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFArmorViewController.h"

#import "CMBannerBox.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGRect kViewFramePortrait	 = { { 325,  15 }, { 428, 200 } };
static const CGRect kViewFrameLandscape  = { { 325,  15 }, { 428, 200 } };
static const CGRect kViewBoundsEditing	 = { {   0,   0 }, { 428, 250 } };

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFArmorViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFArmorViewController

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
		
    [(CMBannerBox*)self.view setBannerTitle:@"Armor"];
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

- (void)setEditingViewsHidden:(BOOL)hidden
{
}

//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	return kViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	return kViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	return kViewBoundsEditing;
}

//------------------------------------------------------------------------------
#pragma mark - State Transitions
//------------------------------------------------------------------------------

- (void)willTransitionToState:(PFContainerViewState)newState;
{
	//TRACE;
	[super willTransitionToState:newState];
	
	if (newState == PFContainerViewStateStatic) {
	}
}

- (void)didTransitionToState:(PFContainerViewState)newState;
{
	//TRACE;
	[super didTransitionToState:newState];
	
	if (newState == PFContainerViewStateEditing) {
	}
}

- (void)animateTransitionToState:(PFContainerViewState)newState;
{
	//TRACE;
	[super animateTransitionToState:newState];
	if (newState == PFContainerViewStateEditing) {
	}
	else {
	}
}

- (void)layoutForState:(PFContainerViewState)aState
{
	LOG_DEBUG(@"state = %d", aState);
	[super layoutForState:aState];
	if (aState == PFContainerViewStateEditing) {
	}
	else {
	}
}

@end
