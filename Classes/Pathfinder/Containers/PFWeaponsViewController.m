//
//  PFWeaponsViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/20/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFWeaponsViewController.h"

#import "PFSelectWeaponViewController.h"
#import "PFWeaponTableViewCell.h"

#import "PFCharacter.h"
#import "PFCharacterWeapon.h"
#import "PFWeapon.h"

#import "CMBannerBox.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGRect kPFWeaponsViewFramePortrait	 = { { 325, 225 }, { 428, 470 } };
static const CGRect kPFWeaponsViewFrameLandscape = { { 325, 225 }, { 428, 470 } };
static const CGRect kPFWeaponsViewBoundsEditing	 = { {   0,   0 }, { 428, 470 } };

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFWeaponsViewController ()

@property (nonatomic, strong) UIPopoverController *detailPopover;
@property (nonatomic, strong) UIView *footerView;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFWeaponsViewController

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
	
    [(CMBannerBox*)self.view setBannerTitle:@"Weapons"];
	//self.tableView.layer.borderColor = [UIColor redColor].CGColor;
	//self.tableView.layer.borderWidth = 1.0f;
	
	self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
	self.footerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.footerView.userInteractionEnabled = YES;
	//self.footerView.layer.borderColor = [UIColor redColor].CGColor;
	//self.footerView.layer.borderWidth = 1.0f;
	//[self.tableView setTableFooterView:self.footerView];
	
	UIButton *addClassButton = [UIButton buttonWithType:UIButtonTypeCustom];
	addClassButton.frame = CGRectMake(10, 10, 90, 20);
	addClassButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
	addClassButton.layer.borderWidth = 1.0f;
	addClassButton.layer.cornerRadius = 8.0f;
	addClassButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
	addClassButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
	[addClassButton setTitle:@"Add Weapon" forState:UIControlStateNormal];
	[addClassButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[addClassButton addTarget:self action:@selector(addWeaponButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
	addClassButton.enabled = YES;
	[self.footerView addSubview:addClassButton];
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

- (void)updateFields
{
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	PFWeaponTableViewCell *weaponCell = (PFWeaponTableViewCell*)cell;
	PFCharacterWeapon *weapon = [self.character.weapons.allObjects objectAtIndex:indexPath.row];
	weaponCell.weaponNameLabel.text = weapon.weapon.name;
	weaponCell.attackBonusTextField.text = [weapon attackBonusDescription];
	weaponCell.damageTextField.text = weapon.weapon.damageMedium;
	weaponCell.rangeLabel.text = weapon.weapon.range;
	weaponCell.typeLabel.text = weapon.weapon.type;
	weaponCell.specialLabel.text = weapon.weapon.special;
	weaponCell.criticalTextField.text = [NSString stringWithFormat:@"%@ ( %@ )", weapon.weapon.criticalThreat, weapon.weapon.criticalDamage];
}

//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (void)addWeaponButtonTapped:(id)sender;
{
	LOG_DEBUG(@"sender = %@", sender);
	UIButton *button = (UIButton*)sender;
	
	PFSelectWeaponViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectWeaponDetailController"];
	controller.character = self.character;
	controller.delegate = self;
	LOG_DEBUG(@"controller = %@", controller);
	
	UIPopoverController *detailPopover = [[UIPopoverController alloc] initWithContentViewController:controller];
	self.detailPopover = detailPopover;
	LOG_DEBUG(@"detailPopover = %@", self.detailPopover);
	[self.detailPopover presentPopoverFromRect:button.frame
										inView:button.superview
					  permittedArrowDirections:UIPopoverArrowDirectionAny
									  animated:YES];
}

- (IBAction)stepperValueChanged:(id)sender;
{
	LOG_DEBUG(@"sender = %@", sender);
	[self updateFields];
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	LOG_DEBUG(@"tableView = %@", tableView);
	//LOG_DEBUG(@"sections = %d", [[self.fetchedResultsController sections] count]);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	LOG_DEBUG(@"tableView = %@, section = %d, rows = %d", tableView, section, self.character.classes.count);
    return self.character.weapons.count;
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LOG_DEBUG(@"indexPath = %@", indexPath);
    static NSString *CellIdentifier = @"WeaponCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	LOG_DEBUG(@"indexPath = %@", indexPath);
	//PFWeaponTableViewCell *cell = (PFWeaponTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	PFCharacterWeapon *weapon = [self.character.weapons.allObjects objectAtIndex:indexPath.row];
	
	[self.tableView beginUpdates];
	[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	[self.character removeWeaponsObject:weapon];
	[self.tableView endUpdates];
	[self updateFields];
}


//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	UIView *header = (UIView*)[tableView dequeueReusableCellWithIdentifier:@"ClassesHeader"];
//	return header;
//}

//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	LOG_DEBUG(@"indexPath = %@", indexPath);
//	PFClassTableViewCell *cell = (PFClassTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//	cell.levelStepper.alpha = 0.0;
//	
//}

//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	LOG_DEBUG(@"indexPath = %@", indexPath);
//	PFClassTableViewCell *cell = (PFClassTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//	cell.levelStepper.alpha = 1.0;
//}

//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	return kPFWeaponsViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	return kPFWeaponsViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	return kPFWeaponsViewBoundsEditing;
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
		[self.tableView setTableFooterView:nil];
		self.tableView.sectionFooterHeight = 0.0f;
		
		for (PFWeaponTableViewCell *aCell in self.tableView.visibleCells) {
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
		[self.tableView setTableFooterView:self.footerView];
		self.tableView.sectionFooterHeight = 30.0f;
		[self.tableView setScrollEnabled:YES];
		//LOG_DEBUG(@"footerView = %@", self.tableView.tableFooterView);
		
		for (PFWeaponTableViewCell *aCell in self.tableView.visibleCells) {
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
		//self.tableView.rowHeight = kClassesViewRowHeightEditing;
		[self.tableView endUpdates];
	}
	else {
		[self.tableView beginUpdates];
		//self.tableView.rowHeight = kClassesViewRowHeightStatic;
		[self.tableView endUpdates];
	}
	
}

//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	LOG_DEBUG(@"segue = %@, sender = %@", segue.identifier, sender);
	LOG_DEBUG(@"source = %@, destination = %@", segue.sourceViewController, segue.destinationViewController);
	[super prepareForSegue:segue sender:sender];

    if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]])
    {
        UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue*)segue;
        popoverSegue.popoverController.delegate = self;
		self.detailPopover = popoverSegue.popoverController;
    }
	
    if ([segue.destinationViewController isKindOfClass:[PFDetailViewController class]])
    {
		PFDetailViewController *controller = segue.destinationViewController;
		controller.delegate = self;
	}
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController;
{
	TRACE;
	self.detailPopover = nil;
	[self updateUI];
}

//------------------------------------------------------------------------------
#pragma mark - PFDetailViewController Delegate
//------------------------------------------------------------------------------

- (void)detailViewControllerDidFinish:(PFDetailViewController*)viewController
{
	if (self.detailPopover) [self.detailPopover dismissPopoverAnimated:YES];
	self.detailPopover = nil;
	[self updateUI];
}

@end
