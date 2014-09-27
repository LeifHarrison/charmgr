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
#import "CMSettings.h"

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

	self.view.layer.contents = (id)[[[CMSettings sharedSettings] pageBackgroundImage] CGImage];
	self.view.layer.contentsGravity = kCAGravityCenter;
	self.view.backgroundColor = [UIColor blackColor];

	//self.titleLabels = [self.titleLabels sortByUIViewOriginY];
	//self.valueFields = [self.valueFields sortByUIViewOriginY];

	self.raceButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.raceButton.layer.borderWidth = 1.0f;
	self.raceButton.layer.cornerRadius = 5.0f;

	self.genderButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.genderButton.layer.borderWidth = 1.0f;
	self.genderButton.layer.cornerRadius = 5.0f;

	self.sizeButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.sizeButton.layer.borderWidth = 1.0f;
	self.sizeButton.layer.cornerRadius = 5.0f;

	self.alignmentButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.alignmentButton.layer.borderWidth = 1.0f;
	self.alignmentButton.layer.cornerRadius = 5.0f;

	[self createDoneButton];
}

- (void)viewWillAppear:(BOOL)animated
{
	TRACE;
	[super viewWillAppear:animated];
	[self updateUI];
}

- (void)doneEditing:(id)sender
{
	[[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
}

- (void)createDoneButton
{
	UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	doneButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
	doneButton.layer.borderWidth = 1;
	doneButton.layer.cornerRadius = 9.0;
	doneButton.backgroundColor = [UIColor lightGrayColor];
	//doneButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	doneButton.translatesAutoresizingMaskIntoConstraints = NO;
	doneButton.titleLabel.font = [UIFont systemFontOfSize:12];
	[doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
	[doneButton setTitle:@"Done" forState:UIControlStateNormal];
	//doneButton.hidden = YES;
	[doneButton sizeToFit];
	[doneButton addTarget:self action:@selector(doneEditing:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:doneButton];

	NSDictionary* views = @{ @"doneButton" : doneButton };
//	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[doneButton]-5-|"
//																				  options:0
//																				  metrics:nil
//																					views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[doneButton]-10-|"
																	  options:0
																	  metrics:nil
																		views:views]];

	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:doneButton
														  attribute:NSLayoutAttributeCenterX
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeCenterX
														 multiplier:1.0
														   constant:0]];
//	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:doneButton
//														  attribute:NSLayoutAttributeCenterY
//														  relatedBy:NSLayoutRelationEqual
//															 toItem:self.view
//														  attribute:NSLayoutAttributeCenterY
//														 multiplier:1.0
//														   constant:0]];

	[doneButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[doneButton(25)]"
																	   options:0
																	   metrics:nil
																		 views:views]];
	[doneButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[doneButton(60)]"
																	   options:0
																	   metrics:nil
																		 views:views]];
	[self.view setNeedsLayout];
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
