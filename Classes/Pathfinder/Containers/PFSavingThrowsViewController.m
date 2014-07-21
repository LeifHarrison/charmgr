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
	
	self.fortitudeSaveField.text = [NSString stringWithFormat:@"%ld", (long)self.character.fortitudeBonus];
	self.fortitudeBaseField.text = [NSString stringWithFormat:@"%ld", (long)self.character.fortitudeBaseBonus];
	self.fortitudeAbilityField.text = [NSString stringWithFormat:@"%ld", (long)[self.character constitutionBonus]];
	self.fortitudeRacialField.text = [NSString stringWithFormat:@"%ld", (long)self.character.fortitudeRacialBonus];
	self.fortitudeMiscField.text = [NSString stringWithFormat:@"%d", self.character.fortitudeMiscBonus];
	//self.fortitudeTempField.text = [NSString stringWithFormat:@"%d", self.character.fortitudeTempBonus];
	
	self.reflexSaveField.text = [NSString stringWithFormat:@"%ld", (long)self.character.reflexBonus];
	self.reflexBaseField.text = [NSString stringWithFormat:@"%ld", (long)self.character.reflexBaseBonus];
	self.reflexAbilityField.text = [NSString stringWithFormat:@"%ld", (long)[self.character dexterityBonus]];
	self.reflexRacialField.text = [NSString stringWithFormat:@"%ld", (long)self.character.reflexRacialBonus];
	self.reflexMiscField.text = [NSString stringWithFormat:@"%d", self.character.reflexMiscBonus];
	//self.reflexTempField.text = [NSString stringWithFormat:@"%d", self.character.reflexTempBonus];
	
	self.willSaveField.text = [NSString stringWithFormat:@"%ld", (long)self.character.willBonus];
	self.willBaseField.text = [NSString stringWithFormat:@"%ld", (long)self.character.willBaseBonus];
	self.willAbilityField.text = [NSString stringWithFormat:@"%ld", (long)[self.character wisdomBonus]];
	self.willRacialField.text = [NSString stringWithFormat:@"%ld", (long)self.character.willRacialBonus];
	self.willMiscField.text = [NSString stringWithFormat:@"%d", self.character.willMiscBonus];
	//self.willTempField.text = [NSString stringWithFormat:@"%d", self.character.willTempBonus];
}

- (void)saveChanges
{
	self.character.fortitudeMiscBonus = [self.fortitudeMiscField.text intValue];
	self.character.reflexMiscBonus = [self.reflexMiscField.text intValue];
	self.character.willMiscBonus = [self.willMiscField.text intValue];
}

@end
