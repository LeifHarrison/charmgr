//
//  PFDefenseViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFDefenseViewController.h"

#import "CMBannerBox.h"

#import "PFCharacter.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGRect kPFDefenseViewFramePortrait		= { {  10, 395 }, { 305, 155 } };
static const CGRect kPFDefenseViewFrameLandscape	= { {  10, 395 }, { 305, 155 } };
static const CGRect kPFDefenseViewBoundsEditing		= { {   0,   0 }, { 660, 340 } };

static const CGRect kPFArmorClassTitleRects[]		= { { {  10,  40 }, {  90,  15 } }, { {  10,  50 }, {  90,  15 } } };
static const CGRect kPFArmorClassFieldRects[]		= { { {  10,  55 }, {  85,  30 } }, { {  10,  65 }, {  70,  30 } } };

static const CGRect kPFFlatFootedACTitleRects[]		= { { { 110,  40 }, {  85,  15 } }, { {  10, 100 }, {  85,  15 } } };
static const CGRect kPFFlatFootedACFieldRects[]		= { { { 110,  55 }, {  85,  30 } }, { {  10, 115 }, {  70,  30 } } };

static const CGRect kPFTouchACTitleRects[]			= { { { 210,  40 }, {  85,  15 } }, { {  10, 150 }, {  85,  15 } } };
static const CGRect kPFTouchACFieldRects[]			= { { { 210,  55 }, {  85,  30 } }, { {  10, 165 }, {  70,  30 } } };

static const CGRect kPFCMDTitleRects[]				= { { {  10,  95 }, {  90,  15 } }, { {  10, 230 }, {  90,  15 } } };
static const CGRect kPFCMDFieldRects[]				= { { {  10, 110 }, {  85,  30 } }, { {  10, 245 }, {  70,  30 } } };

static const CGRect kPFFlatFootedCMDTitleRects[]	= { { { 110,  95 }, {  85,  15 } }, { {  10, 285 }, {  85,  15 } } };
static const CGRect kPFFlatFootedCMDFieldRects[]	= { { { 110, 110 }, {  85,  30 } }, { {  10, 300 }, {  70,  30 } } };

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFDefenseViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFDefenseViewController

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
	
    [(CMBannerBox*)self.view setBannerTitle:@"Defense"];
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

	self.armorClassField.text = [NSString stringWithFormat:@"%ld", (long)[self.character armorClass]];
	self.armorClassDexterityField.text = [NSString stringWithFormat:@"%ld", (long)[self.character dexterityBonus]];
	self.armorClassDodgeField.text = [NSString stringWithFormat:@"%ld", (long)[self.character dodgeBonus]];
	self.armorClassDeflectionField.text = [NSString stringWithFormat:@"%ld", (long)[self.character deflectionBonus]];
	self.armorClassArmorField.text = [NSString stringWithFormat:@"%ld", (long)[self.character armorBonus]];
	self.armorClassShieldField.text = [NSString stringWithFormat:@"%ld", (long)[self.character shieldBonus]];
	self.armorClassNaturalArmorField.text = [NSString stringWithFormat:@"%ld", (long)[self.character naturalArmorBonus]];
	self.armorClassSizeField.text = [NSString stringWithFormat:@"%ld", (long)[self.character sizeModifier]];
	//self.armorClassEnhancementField.text = [NSString stringWithFormat:@"%d", [self.character armorClass]];
	
	self.flatFootedACField.text = [NSString stringWithFormat:@"%ld", (long)[self.character flatFootedArmorClass]];
	self.flatFootedACDeflectionField.text = [NSString stringWithFormat:@"%ld", (long)[self.character deflectionBonus]];
	self.flatFootedACArmorField.text = [NSString stringWithFormat:@"%ld", (long)[self.character armorBonus]];
	self.flatFootedACShieldField.text = [NSString stringWithFormat:@"%ld", (long)[self.character shieldBonus]];
	self.flatFootedACNaturalArmorField.text = [NSString stringWithFormat:@"%ld", (long)[self.character naturalArmorBonus]];
	self.flatFootedACSizeField.text = [NSString stringWithFormat:@"%ld", (long)[self.character sizeModifier]];
	//flatFootedACEnhancementField.text = [NSString stringWithFormat:@"%d", [self.character armorClass]];
	
	self.touchACField.text = [NSString stringWithFormat:@"%ld", (long)[self.character touchArmorClass]];
	self.touchACDexterityField.text = [NSString stringWithFormat:@"%ld", (long)[self.character dexterityBonus]];
	self.touchACDodgeField.text = [NSString stringWithFormat:@"%ld", (long)[self.character dodgeBonus]];
	self.touchACDeflectionField.text = [NSString stringWithFormat:@"%ld", (long)[self.character deflectionBonus]];
	self.touchACSizeField.text = [NSString stringWithFormat:@"%ld", (long)[self.character sizeModifier]];
	//self.touchACEnhancementField.text = [NSString stringWithFormat:@"%d", [self.character armorClass]];
	
	self.cmdField.text = [NSString stringWithFormat:@"%ld", (long)[self.character combatManueverDefence]];
	self.cmdStrengthField.text = [NSString stringWithFormat:@"%ld", (long)[self.character strengthBonus]];
	self.cmdDexterityField.text = [NSString stringWithFormat:@"%ld", (long)[self.character dexterityBonus]];
	self.cmdDodgeField.text = [NSString stringWithFormat:@"%ld", (long)[self.character dodgeBonus]];
	self.cmdDeflectionField.text = [NSString stringWithFormat:@"%ld", (long)[self.character deflectionBonus]];
	self.cmdBaseAttackField.text = [NSString stringWithFormat:@"%ld", (long)[self.character baseAttackBonusForAttackNumber:1]];
	self.cmdSizeField.text = [NSString stringWithFormat:@"%ld", (long)[self.character sizeModifier]];
	//self.cmdMiscField.text = [NSString stringWithFormat:@"%d", [self.character armorClass]];
	
	self.flatFootedCMDField.text = [NSString stringWithFormat:@"%ld", (long)[self.character flatFootedCMD]];
	self.flatFootedCMDStrengthField.text = [NSString stringWithFormat:@"%ld", (long)[self.character strengthBonus]];
	self.flatFootedCMDDeflectionField.text = [NSString stringWithFormat:@"%ld", (long)[self.character deflectionBonus]];
	self.flatFootedCMDBaseAttackField.text = [NSString stringWithFormat:@"%ld", (long)[self.character baseAttackBonusForAttackNumber:1]];
	self.flatFootedCMDSizeField.text = [NSString stringWithFormat:@"%ld", (long)[self.character sizeModifier]];
	//self.flatFootedCMDMiscField.text = [NSString stringWithFormat:@"%d", [self.character armorClass]];
}

//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	return kPFDefenseViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	return kPFDefenseViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	return kPFDefenseViewBoundsEditing;
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
	
	//self.armorClassTitleLabel.alpha = 0.0f;
	
	self.armorClassTitleLabel.frame = kPFArmorClassTitleRects[aState];
	self.armorClassField.frame = kPFArmorClassFieldRects[aState];
	
	self.flatFootedACTitleLabel.frame = kPFFlatFootedACTitleRects[aState];
	self.flatFootedACField.frame = kPFFlatFootedACFieldRects[aState];
	
	self.touchACTitleLabel.frame = kPFTouchACTitleRects[aState];
	self.touchACField.frame = kPFTouchACFieldRects[aState];
	
	self.cmdTitleLabel.frame = kPFCMDTitleRects[aState];
	self.cmdField.frame = kPFCMDFieldRects[aState];
	
	self.flatFootedCMDTitleLabel.frame = kPFFlatFootedCMDTitleRects[aState];
	self.flatFootedCMDField.frame = kPFFlatFootedCMDFieldRects[aState];
	
	//self.armorClassTitleLabel.alpha = 1.0f;
	
	if (aState == PFContainerViewStateEditing) {
		self.editingContainer.alpha = 1.0f;
	}
	else {
		self.editingContainer.alpha = 0.0f;
	}
}

@end
