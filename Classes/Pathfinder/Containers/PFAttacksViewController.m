//
//  PFAttacksViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFAttacksViewController.h"

#import "CMBannerBox.h"

#import "PFCharacter.h"
#import "PFCharacterAbility.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGRect kPFAttacksViewFramePortrait		= { {  15, 205 }, { 305, 175 } };
static const CGRect kPFAttacksViewFrameLandscape	= { {  15, 205 }, { 305, 175 } };
static const CGRect kPFAttacksViewBoundsEditing		= { {   0,   0 }, { 335, 315 } };

static const CGRect kPFInitiativeTitleRects[]		= { { {  10,  35 }, {  85,  15 } }, { {  10,  35 }, {  85,  15 } } };
static const CGRect kPFInitiativeSubtitleRects[]	= { { {  10,  49 }, {  85,  15 } }, { {  10,  49 }, {  85,  15 } } };
static const CGRect kPFInitiativeFieldRects[]		= { { {  10,  65 }, {  85,  30 } }, { {  10,  65 }, {  50,  30 } } };

static const CGRect kPFBaseAttackTitleRects[]		= { { {  110,  35 }, {  85,  15 } }, { { 110,  35 }, {  85,  15 } } };
static const CGRect kPFBaseAttackSubtitleRects[]	= { { {  110,  49 }, {  85,  15 } }, { { 110,  49 }, {  85,  15 } } };
static const CGRect kPFBaseAttackFieldRects[]		= { { {  110,  65 }, {  85,  30 } }, { { 110,  65 }, {  85,  30 } } };

static const CGRect kPFNumAttacksTitleRects[]		= { { {  210,  35 }, {  85,  30 } }, { { 210,  35 }, {  85,  30 } } };
static const CGRect kPFNumAttacksSubtitleRects[]	= { { {  210,  49 }, {  85,  15 } }, { { 210,  49 }, {  85,  15 } } };
static const CGRect kPFNumAttacksFieldRects[]		= { { {  210,  65 }, {  85,  30 } }, { { 210,  65 }, {  85,  30 } } };

static const CGRect kPFMeleeAttackTitleRects[]		= { { {  10, 105 }, {  85,  15 } }, { {  10, 105 }, {  85,  15 } } };
static const CGRect kPFMeleeAttackSubtitleRects[]	= { { {  10, 119 }, {  85,  15 } }, { {  10, 119 }, {  85,  15 } } };
static const CGRect kPFMeleeAttackFieldRects[]		= { { {  10, 135 }, {  85,  30 } }, { {  10, 135 }, {  50,  30 } } };

static const CGRect kPFRangedAttackTitleRects[]		= { { {  110, 105 }, {  85,  15 } }, { {  10, 175 }, {  85,  15 } } };
static const CGRect kPFRangedAttackSubtitleRects[]	= { { {  110, 119 }, {  85,  15 } }, { {  10, 189 }, {  85,  15 } } };
static const CGRect kPFRangedAttackFieldRects[]		= { { {  110, 135 }, {  85,  30 } }, { {  10, 205 }, {  50,  30 } } };

static const CGRect kPFCMBTitleRects[]				= { { {  210, 105 }, {  90,  15 } }, { {  10, 245 }, {  90,  15 } } };
static const CGRect kPFCMBSubtitleRects[]			= { { {  210, 119 }, {  85,  15 } }, { {  10, 259 }, {  85,  15 } } };
static const CGRect kPFCMBFieldRects[]				= { { {  210, 135 }, {  85,  30 } }, { {  10, 275 }, {  50,  30 } } };

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFAttacksViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFAttacksViewController

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
	
    [(CMBannerBox*)self.view setBannerTitle:@"Attacks"];
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
	
	self.initiativeField.text = [NSString stringWithFormat:@"%d", self.character.initiativeBonus];
	self.initiativeDexterityField.text = [NSString stringWithFormat:@"%d", [self.character dexterityBonus]];
	self.initiativeFeatsField.text = [NSString stringWithFormat:@"%d", self.character.initiativeFeatBonus];
	self.initiativeTrainingField.text = [NSString stringWithFormat:@"%d", self.character.initiativeTrainingBonus];
	self.initiativeMiscField.text = [NSString stringWithFormat:@"%d", self.character.initiativeMiscBonus];

	//self.baseAttackField.text = [self.character baseAttackBonusDescription];
	self.baseAttackField.text = [NSString stringWithFormat:@"%d", [self.character baseAttackBonusForAttackNumber:1]];
	self.numberOfAttacksField.text = [NSString stringWithFormat:@"%d", self.character.numberOfAttacks];
	
	self.meleeAttackField.text = [NSString stringWithFormat:@"%d", [self.character meleeAttackBonusForAttackNumber:1]];
	self.meleeAttackBaseField.text = [NSString stringWithFormat:@"%d", [self.character baseAttackBonusForAttackNumber:1]];
	self.meleeAttackStrengthField.text = [NSString stringWithFormat:@"%d", [self.character strengthBonus]];
	self.meleeAttackSizeField.text = [NSString stringWithFormat:@"%d", 0];
	
	self.rangedAttackField.text = [NSString stringWithFormat:@"%d", [self.character rangedAttackBonusForAttackNumber:1]];
	self.rangedAttackBaseField.text = [NSString stringWithFormat:@"%d", [self.character baseAttackBonusForAttackNumber:1]];
	self.rangedAttackDexterityField.text = [NSString stringWithFormat:@"%d", [self.character dexterityBonus]];
	self.rangedAttackSizeField.text = [NSString stringWithFormat:@"%d", 0];
	
	self.cmbField.text = [NSString stringWithFormat:@"%d", self.character.combatManueverBonus];
	self.cmbStrengthModifierField.text = [NSString stringWithFormat:@"%d", [self.character strengthBonus]];
	self.cmbBaseAttackBonusField.text = [NSString stringWithFormat:@"%d", [self.character baseAttackBonusForAttackNumber:1]];
	self.cmbSizeModifierField.text = [NSString stringWithFormat:@"%d", [self.character sizeModifier]];
}

//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	return kPFAttacksViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	return kPFAttacksViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	return kPFAttacksViewBoundsEditing;
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
/*
	self.initiativeTitleLabel.alpha = 0.0f;
	self.initiativeSubtitleLabel.alpha = 0.0f;
	self.initiativeField.alpha = 0.0f;
	self.baseAttackTitleLabel.alpha = 0.0f;
	self.baseAttackSubtitleLabel.alpha = 0.0f;
	self.baseAttackField.alpha = 0.0f;
	self.numberOfAttacksTitleLabel.alpha = 0.0f;
	//self.baseAttackSubtitleLabel.alpha = 0.0f;
	self.numberOfAttacksField.alpha = 0.0f;
	self.meleeAttackTitleLabel.alpha = 0.0f;
	self.meleeAttackSubtitleLabel.alpha = 0.0f;
	self.meleeAttackField.alpha = 0.0f;
	self.rangedAttackTitleLabel.alpha = 0.0f;
	self.rangedAttackSubtitleLabel.alpha = 0.0f;
	self.rangedAttackField.alpha = 0.0f;
	self.cmbTitleLabel.alpha = 0.0f;
	self.cmbSubtitleLabel.alpha = 0.0f;
	self.cmbField.alpha = 0.0f;
*/
	self.initiativeTitleLabel.frame = kPFInitiativeTitleRects[aState];
	self.initiativeSubtitleLabel.frame = kPFInitiativeSubtitleRects[aState];
	self.initiativeField.frame = kPFInitiativeFieldRects[aState];

	self.baseAttackTitleLabel.frame = kPFBaseAttackTitleRects[aState];
	self.baseAttackSubtitleLabel.frame = kPFBaseAttackSubtitleRects[aState];
	self.baseAttackField.frame = kPFBaseAttackFieldRects[aState];

	self.numberOfAttacksTitleLabel.frame = kPFNumAttacksTitleRects[aState];
	//self.numberOfAttacksSubtitleLabel.frame = kPFNumAttacksSubtitleRects[aState];
	self.numberOfAttacksField.frame = kPFNumAttacksFieldRects[aState];

	self.meleeAttackTitleLabel.frame = kPFMeleeAttackTitleRects[aState];
	self.meleeAttackSubtitleLabel.frame = kPFMeleeAttackSubtitleRects[aState];
	self.meleeAttackField.frame = kPFMeleeAttackFieldRects[aState];

	self.rangedAttackTitleLabel.frame = kPFRangedAttackTitleRects[aState];
	self.rangedAttackSubtitleLabel.frame = kPFRangedAttackSubtitleRects[aState];
	self.rangedAttackField.frame = kPFRangedAttackFieldRects[aState];

	self.cmbTitleLabel.frame = kPFCMBTitleRects[aState];
	self.cmbSubtitleLabel.frame = kPFCMBSubtitleRects[aState];
	self.cmbField.frame = kPFCMBFieldRects[aState];
/*
	self.initiativeTitleLabel.alpha = 1.0f;
	self.initiativeSubtitleLabel.alpha = 1.0f;
	self.initiativeField.alpha = 1.0f;
	//self.baseAttackTitleLabel.alpha = 1.0f;
	//self.baseAttackSubtitleLabel.alpha = 1.0f;
	//self.baseAttackField.alpha = 1.0f;
	//self.numberOfAttacksTitleLabel.alpha = 1.0f;
	//self.baseAttackSubtitleLabel.alpha = 1.0f;
	//self.numberOfAttacksField.alpha = 1.0f;
	self.meleeAttackTitleLabel.alpha = 1.0f;
	self.meleeAttackSubtitleLabel.alpha = 1.0f;
	self.meleeAttackField.alpha = 1.0f;
	self.rangedAttackTitleLabel.alpha = 1.0f;
	self.rangedAttackSubtitleLabel.alpha = 1.0f;
	self.rangedAttackField.alpha = 1.0f;
	self.cmbTitleLabel.alpha = 1.0f;
	self.cmbSubtitleLabel.alpha = 1.0f;
	self.cmbField.alpha = 1.0f;
*/
	if (aState == PFContainerViewStateEditing) {
		self.editingContainer.alpha = 1.0f;

		self.baseAttackTitleLabel.alpha = 0.0f;
		self.baseAttackSubtitleLabel.alpha = 0.0f;
		self.baseAttackField.alpha = 0.0f;
		self.numberOfAttacksTitleLabel.alpha = 0.0f;
		//self.numberOfAttacksSubtitleLabel.alpha = 0.0f;
		self.numberOfAttacksField.alpha = 0.0f;
	}
	else {
		self.editingContainer.alpha = 0.0f;
		
		self.baseAttackTitleLabel.alpha = 1.0f;
		self.baseAttackSubtitleLabel.alpha = 1.0f;
		self.baseAttackField.alpha = 1.0f;
		self.numberOfAttacksTitleLabel.alpha = 1.0f;
		//self.numberOfAttacksSubtitleLabel.alpha = 1.0f;
		self.numberOfAttacksField.alpha = 1.0f;
	}
}

@end
