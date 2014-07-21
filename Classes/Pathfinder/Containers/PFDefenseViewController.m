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

@end
