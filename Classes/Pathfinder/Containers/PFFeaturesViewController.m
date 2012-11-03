//
//  PFFeaturesViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFFeaturesViewController.h"

#import "CMBannerBox.h"

#import "PFCharacter.h"
#import "PFCharacterClass.h"
#import "PFClassType.h"
#import "PFFeat.h"
#import "PFRace.h"
#import "PFTrait.h"

#import "PFRacialTraitTableViewCell.h"


//------------------------------------------------------------------------------
#pragma mark - Types/Constants
//------------------------------------------------------------------------------

enum {
	kPFFeaturesTableViewSectionRacialTraits,
	kPFFeaturesTableViewSectionClassFeatures,
	kPFFeaturesTableViewSectionFeats,
	kPFFeaturesTableViewSectionCount
};

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFFeaturesViewController ()

@property (nonatomic, strong) NSArray *racialTraits;
@property (nonatomic, strong) NSArray *classFeatures;
@property (nonatomic, strong) NSArray *characterFeats;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFFeaturesViewController

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
	
    [(CMBannerBox*)self.view setBannerTitle:@"Feats & Special Abilities"];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.racialTraits = [self.character.race.traits allObjects];
	[self updateUI];
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
#pragma mark - Private Methods
//------------------------------------------------------------------------------

- (void)updateUI
{
	[super updateUI];
	[self.tableView reloadData];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == kPFFeaturesTableViewSectionRacialTraits) {
		PFRacialTraitTableViewCell *traitCell = (PFRacialTraitTableViewCell *)cell;
		PFTrait *aTrait = [self.racialTraits objectAtIndex:indexPath.row];
		traitCell.traitNameLabel.text = aTrait.displayName;
		traitCell.traitDescriptionLabel.text = aTrait.descriptionShort;
	}
	else if (indexPath.section == kPFFeaturesTableViewSectionClassFeatures) {
	}
	else if (indexPath.section == kPFFeaturesTableViewSectionFeats) {
	}
}


//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	LOG_DEBUG(@"sections = %d", kPFFeaturesTableViewSectionCount);
    return kPFFeaturesTableViewSectionCount;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
	if (section == kPFFeaturesTableViewSectionRacialTraits) {
		return @"Racial Traits";
	}
	else if (section == kPFFeaturesTableViewSectionClassFeatures) {
		return @"Class Features";
	}
	else if (section == kPFFeaturesTableViewSectionFeats) {
		return @"Feats";
	}
	else {
		return nil;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rowCount = 0;
	if (section == kPFFeaturesTableViewSectionRacialTraits) {
		rowCount = self.racialTraits.count;
	}
	else if (section == kPFFeaturesTableViewSectionClassFeatures) {
		rowCount = self.classFeatures.count;
	}
	else if (section == kPFFeaturesTableViewSectionFeats) {
		rowCount = self.characterFeats.count;
	}
	LOG_DEBUG(@"section = %d, rows = %d", section, rowCount);
	return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
	
	if (indexPath.section == kPFFeaturesTableViewSectionRacialTraits) {
		cellIdentifier = @"RacialTraitCell";
	}
	else if (indexPath.section == kPFFeaturesTableViewSectionClassFeatures) {
		cellIdentifier = @"ClassFeatureCell";
	}
	else if (indexPath.section == kPFFeaturesTableViewSectionFeats) {
		cellIdentifier = @"FeatCell";
	}
	LOG_DEBUG(@"indexPath = %@, cell identifier = %@", indexPath, cellIdentifier);

    UITableViewCell *cell = nil;
	if (cellIdentifier) {
		cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

		// Configure the cell.
		[self configureCell:cell atIndexPath:indexPath];
	}
	
    return cell;
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------


@end
