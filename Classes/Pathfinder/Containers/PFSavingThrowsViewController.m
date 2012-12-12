//
//  PFSavingThrowsViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFSavingThrowsViewController.h"

#import "CMBannerBox.h"

#import "PFCharacter.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGRect kPFSavingThrowsViewFramePortrait	= { {  15, 105 }, { 305,  85 } };
static const CGRect kPFSavingThrowsViewFrameLandscape	= { {  15, 105 }, { 305,  85 } };
static const CGRect kPFSavingThrowsViewBoundsEditing	= { {   0,   0 }, { 400, 180 } };

static const CGRect kPFFortitudeLabelStatic		= { {  10,  34 }, {  85,  15 } };
static const CGRect kPFFortitudeLabelEditing	= { {  10,  34 }, {  70,  15 } };
static const CGRect kPFFortitudeFieldStatic		= { {  10,  50 }, {  85,  25 } };
static const CGRect kPFFortitudeFieldEditing	= { {  10,  50 }, {  50,  25 } };
static const CGRect kPFReflexLabelStatic		= { { 110,  34 }, {  85,  15 } };
static const CGRect kPFReflexLabelEditing		= { {  10,  79 }, {  70,  15 } };
static const CGRect kPFReflexFieldStatic		= { { 110,  50 }, {  85,  25 } };
static const CGRect kPFReflexFieldEditing		= { {  10,  95 }, {  50,  25 } };
static const CGRect kPFWillLabelStatic			= { { 210,  34 }, {  85,  15 } };
static const CGRect kPFWillLabelEditing			= { {  10, 124 }, {  70,  15 } };
static const CGRect kPFWillFieldStatic			= { { 210,  50 }, {  85,  25 } };
static const CGRect kPFWillFieldEditing			= { {  10, 140 }, {  50,  25 } };

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFSavingThrowsViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFSavingThrowsViewController

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
	TRACE;
    [super viewDidLoad];
	
    [(CMBannerBox*)self.view setBannerTitle:@"Saving Throws"];
	self.editingContainer.alpha = 0.0f;
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
	
	self.fortitudeSaveField.text = [NSString stringWithFormat:@"%d", self.character.fortitudeBonus];
	self.fortitudeBaseField.text = [NSString stringWithFormat:@"%d", self.character.fortitudeBaseBonus];
	self.fortitudeAbilityField.text = [NSString stringWithFormat:@"%d", self.character.fortitudeAbilityBonus];
	self.fortitudeRacialField.text = [NSString stringWithFormat:@"%d", self.character.fortitudeRacialBonus];
	self.fortitudeMiscField.text = [NSString stringWithFormat:@"%d", self.character.fortitudeMiscBonus];
	//self.fortitudeTempField.text = [NSString stringWithFormat:@"%d", self.character.fortitudeTempBonus];
	
	self.reflexSaveField.text = [NSString stringWithFormat:@"%d", self.character.reflexBonus];
	self.reflexBaseField.text = [NSString stringWithFormat:@"%d", self.character.reflexBaseBonus];
	self.reflexAbilityField.text = [NSString stringWithFormat:@"%d", self.character.reflexAbilityBonus];
	self.reflexRacialField.text = [NSString stringWithFormat:@"%d", self.character.reflexRacialBonus];
	self.reflexMiscField.text = [NSString stringWithFormat:@"%d", self.character.reflexMiscBonus];
	//self.reflexTempField.text = [NSString stringWithFormat:@"%d", self.character.reflexTempBonus];
	
	self.willSaveField.text = [NSString stringWithFormat:@"%d", self.character.willBonus];
	self.willBaseField.text = [NSString stringWithFormat:@"%d", self.character.willBaseBonus];
	self.willAbilityField.text = [NSString stringWithFormat:@"%d", self.character.willAbilityBonus];
	self.willRacialField.text = [NSString stringWithFormat:@"%d", self.character.willRacialBonus];
	self.willMiscField.text = [NSString stringWithFormat:@"%d", self.character.willMiscBonus];
	//self.willTempField.text = [NSString stringWithFormat:@"%d", self.character.willTempBonus];
}

- (void)saveChanges
{
	self.character.fortitudeMiscBonus = [self.fortitudeMiscField.text intValue];
	self.character.reflexMiscBonus = [self.reflexMiscField.text intValue];
	self.character.willMiscBonus = [self.willMiscField.text intValue];
}

//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	return kPFSavingThrowsViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	return kPFSavingThrowsViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	return kPFSavingThrowsViewBoundsEditing;
}

//------------------------------------------------------------------------------
#pragma mark - State Transitions
//------------------------------------------------------------------------------

- (void)willTransitionToState:(PFContainerViewState)newState;
{
	//TRACE;
	[super willTransitionToState:newState];
	
	if (newState == PFContainerViewStateStatic) {
		[self.fortitudeMiscField setEnabled:NO];
		[self.fortitudeTempField setEnabled:NO];
		[self.reflexMiscField setEnabled:NO];
		[self.reflexTempField setEnabled:NO];
		[self.willMiscField setEnabled:NO];
		[self.willTempField setEnabled:NO];
	}
}

- (void)didTransitionToState:(PFContainerViewState)newState;
{
	//TRACE;
	[super didTransitionToState:newState];
	
	if (newState == PFContainerViewStateEditing) {
		[self.fortitudeMiscField setEnabled:YES];
		[self.fortitudeTempField setEnabled:YES];
		[self.reflexMiscField setEnabled:YES];
		[self.reflexTempField setEnabled:YES];
		[self.willMiscField setEnabled:YES];
		[self.willTempField setEnabled:YES];
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
		self.fortitudeSaveLabel.frame = kPFFortitudeLabelEditing;
		self.fortitudeSaveField.frame = kPFFortitudeFieldEditing;
		self.reflexSaveLabel.frame = kPFReflexLabelEditing;
		self.reflexSaveField.frame = kPFReflexFieldEditing;
		self.willSaveLabel.frame = kPFWillLabelEditing;
		self.willSaveField.frame = kPFWillFieldEditing;
	}
	else {
		self.fortitudeSaveLabel.frame = kPFFortitudeLabelStatic;
		self.fortitudeSaveField.frame = kPFFortitudeFieldStatic;
		self.reflexSaveLabel.frame = kPFReflexLabelStatic;
		self.reflexSaveField.frame = kPFReflexFieldStatic;
		self.willSaveLabel.frame = kPFWillLabelStatic;
		self.willSaveField.frame = kPFWillFieldStatic;
	}
}

@end
