//
//  PFSkillsViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFSkillsViewController.h"

#import "CMBannerBox.h"
#import "PFSkillTableViewCell.h"

#import "PFCharacter.h"
#import "PFCharacterSkill.h"
#import "PFSkill.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFSkillsViewController ()

@property (nonatomic, strong) NSArray *sortedSkills;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFSkillsViewController

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
	
    [(CMBannerBox*)self.view setBannerTitle:@"Skills"];
	
	//self.tableView.layer.borderColor = [UIColor redColor].CGColor;
	//self.tableView.layer.borderWidth = 1.0f;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.sortedSkills = self.character.sortedSkills;
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
	PFCharacterSkill *characterSkill = (PFCharacterSkill *)[self.sortedSkills objectAtIndex:indexPath.row];
	PFSkillTableViewCell *skillCell = (PFSkillTableViewCell*)cell;
	skillCell.characterSkill = characterSkill;
	skillCell.skillNameLabel.text = [characterSkill skillName];
	skillCell.classSkillLabel.text = characterSkill.isClassSkill ? @"x" : @"";
	skillCell.abilityModifierLabel.text = [characterSkill keyAbilityAbbreviation];
	skillCell.skillBonusLabel.text = [characterSkill skillBonusString];
	skillCell.skillRanksTextField.text = [NSString stringWithFormat:@"%d", characterSkill.ranks];
	skillCell.skillRanksStepper.value = characterSkill.ranks;
	
	if (characterSkill.skill.untrained) {
		skillCell.skillNameLabel.font = [UIFont italicSystemFontOfSize:14.0];
	}
	else {
		skillCell.skillNameLabel.font = [UIFont systemFontOfSize:14.0];
	}
}


//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//LOG_DEBUG(@"sections = %d", [[self.fetchedResultsController sections] count]);
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//LOG_DEBUG(@"section = %ld, rows = %lu", section, self.sortedSkills.count);
    return self.sortedSkills.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SkillsCell";
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
	UIView *header = (UIView*)[tableView dequeueReusableCellWithIdentifier:@"SkillsHeaderCell"];
	header.backgroundColor = [UIColor clearColor];
	return header;
}

@end
