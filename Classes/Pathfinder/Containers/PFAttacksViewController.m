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
	
	self.initiativeField.text = [NSString stringWithFormat:@"%ld", (long)self.character.initiativeBonus];
	self.initiativeDexterityField.text = [NSString stringWithFormat:@"%ld", (long)[self.character dexterityBonus]];
	self.initiativeFeatsField.text = [NSString stringWithFormat:@"%ld", (long)self.character.initiativeFeatBonus];
	self.initiativeTrainingField.text = [NSString stringWithFormat:@"%ld", (long)self.character.initiativeTrainingBonus];
	self.initiativeMiscField.text = [NSString stringWithFormat:@"%d", self.character.initiativeMiscBonus];

	//self.baseAttackField.text = [self.character baseAttackBonusDescription];
	self.baseAttackField.text = [NSString stringWithFormat:@"%ld", (long)[self.character baseAttackBonusForAttackNumber:1]];
	self.numberOfAttacksField.text = [NSString stringWithFormat:@"%ld", (long)self.character.numberOfAttacks];
	
	self.meleeAttackField.text = [NSString stringWithFormat:@"%ld", (long)[self.character meleeAttackBonusForAttackNumber:1]];
	self.meleeAttackBaseField.text = [NSString stringWithFormat:@"%ld", (long)[self.character baseAttackBonusForAttackNumber:1]];
	self.meleeAttackStrengthField.text = [NSString stringWithFormat:@"%ld", (long)[self.character strengthBonus]];
	self.meleeAttackSizeField.text = [NSString stringWithFormat:@"%d", 0];
	
	self.rangedAttackField.text = [NSString stringWithFormat:@"%ld", (long)[self.character rangedAttackBonusForAttackNumber:1]];
	self.rangedAttackBaseField.text = [NSString stringWithFormat:@"%ld", (long)[self.character baseAttackBonusForAttackNumber:1]];
	self.rangedAttackDexterityField.text = [NSString stringWithFormat:@"%ld", (long)[self.character dexterityBonus]];
	self.rangedAttackSizeField.text = [NSString stringWithFormat:@"%d", 0];
	
	self.cmbField.text = [NSString stringWithFormat:@"%ld", (long)self.character.combatManueverBonus];
	self.cmbStrengthModifierField.text = [NSString stringWithFormat:@"%ld", (long)[self.character strengthBonus]];
	self.cmbBaseAttackBonusField.text = [NSString stringWithFormat:@"%ld", (long)[self.character baseAttackBonusForAttackNumber:1]];
	self.cmbSizeModifierField.text = [NSString stringWithFormat:@"%ld", (long)[self.character sizeModifier]];
}

@end
