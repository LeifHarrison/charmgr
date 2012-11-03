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

static const CGRect kAbilitiesViewStaticRect = { { 0, 0}, { 205, 240} };
static const CGRect kAbilitiesViewEditRect   = { { 0, 0}, { 305, 240} };

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
	if (characterAbility.temporaryScore != nil) {
		abilityCell.temporaryScoreTextField.text = characterAbility.temporaryScore.stringValue;
		abilityCell.temporaryBonusTextField.text = characterAbility.temporaryBonus.stringValue;
	}
	else {
		abilityCell.temporaryScoreTextField.text = @"";
		abilityCell.temporaryBonusTextField.text = @"";
	}
	abilityCell.abilityStepper.value = characterAbility.abilityScore.doubleValue;

	abilityCell.containerState = self.state;
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
	LOG_DEBUG(@"section = %d, rows = %d", section, self.sortedAbilities.count);
    return self.sortedAbilities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AbilityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}


//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *header = (UIView*)[tableView dequeueReusableCellWithIdentifier:@"AbilityHeader"];
	return header;
}

//------------------------------------------------------------------------------
#pragma mark - State Transitions
//------------------------------------------------------------------------------

- (void)willTransitionToState:(PFContainerViewState)newState;
{
	//TRACE;
	[super willTransitionToState:newState];
	
	if (newState == PFContainerViewStateStatic) {
		for (PFAbilityTableViewCell *aCell in self.tableView.visibleCells) {
			[aCell setContainerState:newState animated:YES];
		}
		//[self setEditableFieldsEnabled:NO];
	}
}

- (void)didTransitionToState:(PFContainerViewState)newState;
{
	//TRACE;
	//LOG_DEBUG(@"parentViewController = %@", self.parentViewController);
	[super didTransitionToState:newState];
	
	if (newState == PFContainerViewStateEditing) {
		for (PFAbilityTableViewCell *aCell in self.tableView.visibleCells) {
			[aCell setContainerState:newState animated:YES];
		}
		//[self setEditableFieldsEnabled:YES];
	}
}

- (void)animateTransitionToState:(PFContainerViewState)newState;
{
	//TRACE;
	[super animateTransitionToState:newState];
	if (newState == PFContainerViewStateEditing) {
		self.view.superview.bounds = kAbilitiesViewEditRect;
	}
	else {
		self.view.superview.bounds = kAbilitiesViewStaticRect;
	}
}


@end
