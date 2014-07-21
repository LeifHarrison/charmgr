//
//  PFEditCharacterViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 7/16/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "PFEditCharacterViewController.h"

#import "PFSelectAlignmentViewController.h"
#import "PFSelectGenderViewController.h"
#import "PFSelectRaceViewController.h"
#import "PFSelectSizeViewController.h"

#import "PFAlignment.h"
#import "PFCharacter.h"
#import "PFCharacterClass.h"
#import "PFClassType.h"
#import "PFRace.h"

#import "CMBannerBox.h"

#import "NSArray+CMExtensions.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFEditCharacterViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@interface PFEditCharacterViewController ()

@end

@implementation PFEditCharacterViewController

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

	[(CMBannerBox*)self.view setBannerTitle:@"Character"];

	self.titleLabels = [self.titleLabels sortByUIViewOriginY];
	self.valueFields = [self.valueFields sortByUIViewOriginY];

	self.raceButton.layer.borderColor = [UIColor clearColor].CGColor;
	self.raceButton.layer.borderWidth = 1.0f;
	self.raceButton.layer.cornerRadius = 5.0f;

	self.genderButton.layer.borderColor = [UIColor clearColor].CGColor;
	self.genderButton.layer.borderWidth = 1.0f;
	self.genderButton.layer.cornerRadius = 5.0f;

	self.sizeButton.layer.borderColor = [UIColor clearColor].CGColor;
	self.sizeButton.layer.borderWidth = 1.0f;
	self.sizeButton.layer.cornerRadius = 5.0f;

	self.alignmentButton.layer.borderColor = [UIColor clearColor].CGColor;
	self.alignmentButton.layer.borderWidth = 1.0f;
	self.alignmentButton.layer.cornerRadius = 5.0f;
}

- (void)viewWillAppear:(BOOL)animated
{
	TRACE;
	[super viewWillAppear:animated];
	[self updateUI];
}


//------------------------------------------------------------------------------
#pragma mark - Private
//------------------------------------------------------------------------------

- (void)updateUI
{
	[super updateUI];

	self.characterField.text = self.character.name;
	self.playerField.text = self.character.player;
	self.campaignField.text = self.character.campaign;

	[self.raceButton setTitle:self.character.race.name forState:UIControlStateNormal];
	[self.genderButton setTitle:self.character.genderDescription forState:UIControlStateNormal];
	[self.sizeButton setTitle:self.character.sizeDescription forState:UIControlStateNormal];
	[self.alignmentButton setTitle:self.character.alignment.name forState:UIControlStateNormal];

}

@end
