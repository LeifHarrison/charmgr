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

static const CGRect kPFDefenseViewFramePortrait		= { {  15, 385 }, { 305, 175 } };
static const CGRect kPFDefenseViewFrameLandscape	= { {  15, 385 }, { 305, 175 } };
static const CGRect kPFDefenseViewBoundsEditing		= { {   0,   0 }, { 640, 340 } };

static const CGRect kPFArmorClassTitleRects[]		= { { {  10,  35 }, {  90,  30 } }, { {  10,  35 }, {  90,  30 } } };
static const CGRect kPFArmorClassFieldRects[]		= { { {  10,  65 }, {  85,  30 } }, { {  10,  65 }, {  70,  30 } } };

static const CGRect kPFFlatFootedACTitleRects[]		= { { { 110,  35 }, {  85,  15 } }, { {  10, 100 }, {  85,  15 } } };
static const CGRect kPFFlatFootedACFieldRects[]		= { { { 110,  65 }, {  85,  30 } }, { {  10, 115 }, {  70,  30 } } };

static const CGRect kPFTouchACTitleRects[]			= { { { 210,  35 }, {  85,  15 } }, { {  10, 150 }, {  85,  15 } } };
static const CGRect kPFTouchACFieldRects[]			= { { { 210,  65 }, {  85,  30 } }, { {  10, 165 }, {  70,  30 } } };

static const CGRect kPFCMDTitleRects[]				= { { {  10, 119 }, {  90,  15 } }, { {  10, 230 }, {  90,  15 } } };
static const CGRect kPFCMDFieldRects[]				= { { {  10, 135 }, {  85,  30 } }, { {  10, 245 }, {  70,  30 } } };

static const CGRect kPFFlatFootedCMDTitleRects[]	= { { { 110, 105 }, {  85,  15 } }, { {  10, 285 }, {  85,  15 } } };
static const CGRect kPFFlatFootedCMDFieldRects[]	= { { { 110, 135 }, {  85,  30 } }, { {  10, 300 }, {  70,  30 } } };

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

	self.armorClassField.text = [NSString stringWithFormat:@"%d", [self.character armorClass]];
	self.armorClassDexterityField.text = [NSString stringWithFormat:@"%d", [self.character dexterityBonus]];
	self.armorClassDodgeField.text = [NSString stringWithFormat:@"%d", [self.character dodgeBonus]];
	self.armorClassDeflectionField.text = [NSString stringWithFormat:@"%d", [self.character deflectionBonus]];
	self.armorClassArmorField.text = [NSString stringWithFormat:@"%d", [self.character armorBonus]];
	self.armorClassShieldField.text = [NSString stringWithFormat:@"%d", [self.character shieldBonus]];
	self.armorClassNaturalArmorField.text = [NSString stringWithFormat:@"%d", [self.character naturalArmorBonus]];
	self.armorClassSizeField.text = [NSString stringWithFormat:@"%d", [self.character sizeModifier]];
	//self.armorClassEnhancementField.text = [NSString stringWithFormat:@"%d", [self.character armorClass]];
	
	self.flatFootedACField.text = [NSString stringWithFormat:@"%d", [self.character flatFootedArmorClass]];
	self.flatFootedACDeflectionField.text = [NSString stringWithFormat:@"%d", [self.character deflectionBonus]];
	self.flatFootedACArmorField.text = [NSString stringWithFormat:@"%d", [self.character armorBonus]];
	self.flatFootedACShieldField.text = [NSString stringWithFormat:@"%d", [self.character shieldBonus]];
	self.flatFootedACNaturalArmorField.text = [NSString stringWithFormat:@"%d", [self.character naturalArmorBonus]];
	self.flatFootedACSizeField.text = [NSString stringWithFormat:@"%d", [self.character sizeModifier]];
	//flatFootedACEnhancementField.text = [NSString stringWithFormat:@"%d", [self.character armorClass]];
	
	self.touchACField.text = [NSString stringWithFormat:@"%d", [self.character touchArmorClass]];
	self.touchACDexterityField.text = [NSString stringWithFormat:@"%d", [self.character dexterityBonus]];
	self.touchACDodgeField.text = [NSString stringWithFormat:@"%d", [self.character dodgeBonus]];
	self.touchACDeflectionField.text = [NSString stringWithFormat:@"%d", [self.character deflectionBonus]];
	self.touchACSizeField.text = [NSString stringWithFormat:@"%d", [self.character sizeModifier]];
	//self.touchACEnhancementField.text = [NSString stringWithFormat:@"%d", [self.character armorClass]];
	
	self.cmdField.text = [NSString stringWithFormat:@"%d", [self.character combatManueverDefence]];
	self.cmdStrengthField.text = [NSString stringWithFormat:@"%d", [self.character strengthBonus]];
	self.cmdDexterityField.text = [NSString stringWithFormat:@"%d", [self.character dexterityBonus]];
	self.cmdDodgeField.text = [NSString stringWithFormat:@"%d", [self.character dodgeBonus]];
	self.cmdDeflectionField.text = [NSString stringWithFormat:@"%d", [self.character deflectionBonus]];
	self.cmdBaseAttackField.text = [NSString stringWithFormat:@"%d", [self.character baseAttackBonusForAttackNumber:1]];
	self.cmdSizeField.text = [NSString stringWithFormat:@"%d", [self.character sizeModifier]];
	//self.cmdMiscField.text = [NSString stringWithFormat:@"%d", [self.character armorClass]];
	
	self.flatFootedCMDField.text = [NSString stringWithFormat:@"%d", [self.character flatFootedCMD]];
	self.flatFootedCMDStrengthField.text = [NSString stringWithFormat:@"%d", [self.character strengthBonus]];
	self.flatFootedCMDDeflectionField.text = [NSString stringWithFormat:@"%d", [self.character deflectionBonus]];
	self.flatFootedCMDBaseAttackField.text = [NSString stringWithFormat:@"%d", [self.character baseAttackBonusForAttackNumber:1]];
	self.flatFootedCMDSizeField.text = [NSString stringWithFormat:@"%d", [self.character sizeModifier]];
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
