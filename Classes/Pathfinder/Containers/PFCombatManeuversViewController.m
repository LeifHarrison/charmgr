//
//  PFCombatManeuversViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFCombatManeuversViewController.h"

#import "CMBannerBox.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGRect kPFCombatManeuversViewFramePortrait	 = { {  15, 493 }, { 305,  85 } };
static const CGRect kPFCombatManeuversViewFrameLandscape = { {  15, 493 }, { 305,  85 } };
static const CGRect kPFCombatManeuversViewBoundsEditing	 = { {   0,   0 }, { 575, 200 } };

static const CGRect kPFCMBLabelStatic				= { {  10,  34 }, {  85,  15 } };
static const CGRect kPFCMBLabelEditing				= { {  10,  30 }, { 135,  15 } };
static const CGRect kPFCMBFieldStatic				= { {  10,  50 }, {  85,  25 } };
static const CGRect kPFCMBFieldEditing				= { {  10,  60 }, {  50,  25 } };
static const CGRect kPFCMDLabelStatic				= { { 110,  34 }, {  85,  15 } };
static const CGRect kPFCMDLabelEditing				= { {  10,  90 }, { 135,  15 } };
static const CGRect kPFCMDFieldStatic				= { { 110,  50 }, {  85,  25 } };
static const CGRect kPFCMDFieldEditing				= { {  10, 120 }, {  50,  25 } };
static const CGRect kPFFlatFootedCMDLabelStatic		= { { 210,  34 }, {  85,  15 } };
static const CGRect kPFFlatFootedCMDLabelEditing	= { {  10, 150 }, { 125,  15 } };
static const CGRect kPFFlatFootedCMDFieldStatic		= { { 210,  50 }, {  85,  25 } };
static const CGRect kPFFlatFootedCMDFieldEditing	= { {  10, 165 }, {  50,  25 } };

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFCombatManeuversViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFCombatManeuversViewController

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
	
	self.editingContainer.alpha = 0.0f;
	
    [(CMBannerBox*)self.view setBannerTitle:@"Combat Maneuvers"];
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
	return kPFCombatManeuversViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	return kPFCombatManeuversViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	return kPFCombatManeuversViewBoundsEditing;
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
		self.editingContainer.alpha = 1.0f;
	}
	else {
		self.editingContainer.alpha = 0.0f;
	}
}

- (void)layoutForState:(PFContainerViewState)aState
{
	LOG_DEBUG(@"state = %d", aState);
	[super layoutForState:aState];
	if (aState == PFContainerViewStateEditing) {
		self.cmbTitleLabel.frame = kPFCMBLabelEditing;
		self.cmbField.frame = kPFCMBFieldEditing;
		self.cmdTitleLabel.frame = kPFCMDLabelEditing;
		self.cmdField.frame = kPFCMDFieldEditing;
		self.flatFootedCMDTitleLabel.frame = kPFFlatFootedCMDLabelEditing;
		self.flatFootedCMDField.frame = kPFFlatFootedCMDFieldEditing;

		self.cmbTitleLabel.text = @"COMBAT MANUEVER";
		self.cmdTitleLabel.text = @"COMBAT MANUEVER";
		
		self.cmbSubtitleLabel.alpha = 1.0f;
		self.cmdSubtitleLabel.alpha = 1.0f;
		self.flatFootedCMDSubtitleLabel.alpha = 1.0f;
	}
	else {
		self.cmbTitleLabel.frame = kPFCMBLabelStatic;
		self.cmbField.frame = kPFCMBFieldStatic;
		self.cmdTitleLabel.frame = kPFCMDLabelStatic;
		self.cmdField.frame = kPFCMDFieldStatic;
		self.flatFootedCMDTitleLabel.frame = kPFFlatFootedCMDLabelStatic;
		self.flatFootedCMDField.frame = kPFFlatFootedCMDFieldStatic;
		
		self.cmbTitleLabel.text = @"CMB";
		self.cmdTitleLabel.text = @"CMD";
		
		self.cmbSubtitleLabel.alpha = 0.0f;
		self.cmdSubtitleLabel.alpha = 0.0f;
		self.flatFootedCMDSubtitleLabel.alpha = 0.0f;
	}
}

@end
