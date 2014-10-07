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

@property (nonatomic) NSArray *fieldArray;

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

	self.fieldArray = @[self.characterField, self.playerField, self.campaignField];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//LOG_DEBUG(@"bounds = %@, text rect = %@", NSStringFromCGRect(self.characterField.bounds), NSStringFromCGRect([self.characterField textRectForBounds:self.characterField.bounds]));
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

- (void)saveChanges
{
	self.character.name = self.characterField.text;
	self.character.player = self.playerField.text;
	self.character.campaign = self.campaignField.text;
}

//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	LOG_DEBUG(@"segue = %@, sender = %@", segue.identifier, sender);
	LOG_DEBUG(@"source = %@, destination = %@", segue.sourceViewController, segue.destinationViewController);
	[super prepareForSegue:segue sender:sender];

	if ([segue.destinationViewController isKindOfClass:[PFDetailViewController class]])
	{
		PFDetailViewController *controller = segue.destinationViewController;
		controller.character = self.character;
		controller.delegate = self;
	}
}

- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
	BOOL didResign = [textField resignFirstResponder];
	if (!didResign) return NO;

	NSUInteger index = [self.fieldArray indexOfObject:textField];
	if (index == NSNotFound || index + 1 == self.fieldArray.count) return NO;

	id nextField = [self.fieldArray objectAtIndex:index + 1];
	//activeField = nextField;
	[nextField becomeFirstResponder];

	return NO;
}

//------------------------------------------------------------------------------
#pragma mark - PFDetailViewController Delegate
//------------------------------------------------------------------------------

- (void)detailViewControllerDidFinish:(PFDetailViewController*)viewController
{
	[self updateUI];
}

@end
