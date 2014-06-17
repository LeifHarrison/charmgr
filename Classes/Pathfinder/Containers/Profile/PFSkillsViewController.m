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

static const CGRect kPFSkillsViewFramePortrait		= { { 360, 255 }, { 398, 739 } };
static const CGRect kPFSkillsViewFrameLandscape		= { { 616,  10 }, { 398, 728 } };
static const CGRect kPFSkillsViewBoundsEditing		= { {   0,   0 }, { 498, 739 } };

static const CGFloat kSkillsViewRowHeightEditing = 29.0f;
static const CGFloat kSkillsViewRowHeightStatic = 20.0f;

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
	skillCell.containerState = self.state;
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
	LOG_DEBUG(@"section = %ld, rows = %lu", section, self.sortedSkills.count);
    return self.sortedSkills.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SkillsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the managed object.
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
*/

//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	// Default implementation just returns our current view frame
	return kPFSkillsViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	// Default implementation just returns our current view frame
	return kPFSkillsViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	// Default implementation just returns our current view frame
	return kPFSkillsViewBoundsEditing;
}

//------------------------------------------------------------------------------
#pragma mark - State Transitions
//------------------------------------------------------------------------------

- (void)willTransitionToState:(PFContainerViewState)newState;
{
	LOG_DEBUG(@"newState = %d", newState);
	[super willTransitionToState:newState];
	
	
	if (newState == PFContainerViewStateStatic) {
		[self.tableView setScrollEnabled:NO];
		//[self.tableView setTableFooterView:nil];
		//self.tableView.sectionFooterHeight = 0.0f;
		
		for (PFSkillTableViewCell *aCell in self.tableView.visibleCells) {
			[aCell setContainerState:newState animated:YES];
		}
		
	}
}

- (void)didTransitionToState:(PFContainerViewState)newState;
{
	LOG_DEBUG(@"newState = %d", newState);
	//LOG_DEBUG(@"parentViewController = %@", self.parentViewController);
	[super didTransitionToState:newState];
	
	if (newState == PFContainerViewStateEditing) {
		//[self.tableView setTableFooterView:self.footerView];
		//self.tableView.sectionFooterHeight = 30.0f;
		[self.tableView setScrollEnabled:YES];
		LOG_DEBUG(@"footerView = %@", self.tableView.tableFooterView);
		
		for (PFSkillTableViewCell *aCell in self.tableView.visibleCells) {
			[aCell setContainerState:newState animated:YES];
		}
		
	}
}

- (void)animateTransitionToState:(PFContainerViewState)newState;
{
	LOG_DEBUG(@"newState = %d", newState);
	[super animateTransitionToState:newState];
	
	if (newState == PFContainerViewStateEditing) {
		[self.tableView beginUpdates];
		self.tableView.rowHeight = kSkillsViewRowHeightEditing;
		[self.tableView endUpdates];
	}
	else {
		[self.tableView beginUpdates];
		self.tableView.rowHeight = kSkillsViewRowHeightStatic;
		[self.tableView endUpdates];
	}
	
}

@end
