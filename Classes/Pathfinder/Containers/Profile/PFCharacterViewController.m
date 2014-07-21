//
//  PFCharacterViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import "PFCharacterViewController.h"

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

@interface PFCharacterViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFCharacterViewController

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

	self.characterLabel.text = self.character.name;
	self.playerLabel.text = self.character.player;
	self.campaignLabel.text = self.character.campaign;
	self.raceLabel.text = self.character.race.name;
	self.genderLabel.text = self.character.genderDescription;
	self.sizeLabel.text = self.character.sizeDescription;
	self.alignmentLabel.text = self.character.alignment.name;
}

//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------


@end
