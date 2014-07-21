//
//  PFAbilitiesViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFAbilitiesViewController.h"

#import "CMBannerBox.h"
#import "PFAbilityTableViewCell.h"

#import "PFAbility.h"
#import "PFCharacter.h"
#import "PFCharacterAbility.h"


//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFAbilitiesViewController ()

@property (nonatomic, strong) NSArray *sortedAbilities;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFAbilitiesViewController

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

    [(CMBannerBox*)self.view setBannerTitle:@"Abilities"];
	
	//self.tableView.layer.borderColor = [UIColor redColor].CGColor;
	//self.tableView.layer.borderWidth = 1.0f;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.tableView.backgroundColor = [UIColor clearColor];
	self.sortedAbilities = self.character.sortedAbilities;
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
#pragma mark - Private
//------------------------------------------------------------------------------

- (void)updateUI
{
	[super updateUI];
	[self.tableView reloadData];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	PFCharacterAbility *characterAbility = (PFCharacterAbility *)[self.sortedAbilities objectAtIndex:indexPath.row];
	PFAbilityTableViewCell *abilityCell = (PFAbilityTableViewCell*)cell;
	
	abilityCell.characterAbility = characterAbility;
	abilityCell.abilityNameLabel.text = characterAbility.ability.name;
	abilityCell.abilityScoreTextField.text = characterAbility.abilityScore.stringValue;
	abilityCell.abilityBonusTextField.text = characterAbility.abilityBonus.stringValue;
	//LOG_DEBUG(@"borderWidth = %lf", abilityCell.abilityScoreTextField.layer.borderWidth);
	//abilityCell.abilityScoreTextField.layer.borderWidth = 1.0f;
	//abilityCell.abilityScoreTextField.layer.cornerRadius = 6.0f;
	//abilityCell.abilityScoreTextField.layer.masksToBounds = YES;
}


//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//LOG_DEBUG(@"sections = %d", [[self.fetchedResultsController sections] count]);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	LOG_DEBUG(@"section = %ld, rows = %lu", (long)section, (unsigned long)self.sortedAbilities.count);
    return self.sortedAbilities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AbilityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell.backgroundColor = [UIColor clearColor];

    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *header = (UIView*)[tableView dequeueReusableCellWithIdentifier:@"AbilityHeader"];
	header.backgroundColor = [UIColor clearColor];
	return header;
}

@end
