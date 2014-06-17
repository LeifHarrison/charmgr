//
//  PFClassesViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 10/12/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFClassesViewController.h"

#import "CMBannerBox.h"

#import "PFCharacter.h"
#import "PFCharacterClass.h"
#import "PFClassType.h"

#import "PFClassTableViewCell.h"

#import "PFSelectClassViewController.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGRect kPFClassesViewFramePortrait		= { { 473,  10 }, { 285, 240 } };
static const CGRect kPFClassesViewFrameLandscape	= { {  10, 498 }, { 285, 240 } };
static const CGRect kPFClassesViewBoundsEditing		= { {   0,   0 }, { 385, 270 } };

static const CGFloat kClassesViewRowHeightEditing = 31.0f;
static const CGFloat kClassesViewRowHeightStatic = 25.0f;

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFClassesViewController ()

@property (nonatomic, strong) UIPopoverController *detailPopover;
@property (nonatomic, strong) UIView *footerView;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFClassesViewController

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

    [(CMBannerBox*)self.view setBannerTitle:@"Classes"];
	
	//self.tableView.layer.borderColor = [UIColor redColor].CGColor;
	//self.tableView.layer.borderWidth = 1.0f;
	
	self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
	self.footerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.footerView.userInteractionEnabled = YES;
	//self.footerView.layer.borderColor = [UIColor redColor].CGColor;
	//self.footerView.layer.borderWidth = 1.0f;
	//[self.tableView setTableFooterView:self.footerView];
	
	UIButton *addClassButton = [UIButton buttonWithType:UIButtonTypeCustom];
	addClassButton.frame = CGRectMake(10, 5, 90, 20);
	addClassButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
	addClassButton.layer.borderWidth = 1.0f;
	addClassButton.layer.cornerRadius = 8.0f;
	addClassButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
	addClassButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
	[addClassButton setTitle:@"Add Class" forState:UIControlStateNormal];
	[addClassButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[addClassButton addTarget:self action:@selector(addClassButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
	addClassButton.enabled = YES;
	[self.footerView addSubview:addClassButton];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
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
	
	[self updateFields];
	[self.tableView reloadData];
}

- (void)updateFields
{
	self.levelAdjustmentTextField.text = [NSString stringWithFormat:@"%ld", (long)self.character.levelAdjustment];
	self.effectiveLevelTextField.text = [NSString stringWithFormat:@"%ld", (long)self.character.effectiveLevel];
	
	self.currentXPLabel.text = [NSString stringWithFormat:@"%d", self.character.experiencePoints];
	self.nextLevelXPLabel.text = [NSString stringWithFormat:@"%ld", (long)self.character.nextLevelXP];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	PFCharacterClass *characterClass = (PFCharacterClass *)[self.character.classes.allObjects objectAtIndex:indexPath.row];
	PFClassTableViewCell *classCell = (PFClassTableViewCell*)cell;
	classCell.characterClass = characterClass;
	classCell.containerState = self.state;
	classCell.classNameLabel.text = characterClass.classType.name;
	classCell.hitDieTypeLabel.text = characterClass.classType.hitDieTypeDescription;
	classCell.skillRanksLabel.text = [NSString stringWithFormat:@"%d", characterClass.classType.skillRanksPerLevel];
	classCell.levelTextField.text = [NSString stringWithFormat:@"%d", characterClass.level];
	classCell.levelStepper.value = characterClass.level;
	
	[classCell.levelStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
}

//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (void)addClassButtonTapped:(id)sender;
{
	LOG_DEBUG(@"sender = %@", sender);
	UIButton *button = (UIButton*)sender;
	
	PFSelectClassViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectClassDetailController"];
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
	//LOG_DEBUG(@"sections = %d", [[self.fetchedResultsController sections] count]);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	LOG_DEBUG(@"section = %ld, rows = %lu", (long)section, (unsigned long)self.character.classes.count);
    return self.character.classes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LOG_DEBUG(@"indexPath = %@", indexPath);
    static NSString *CellIdentifier = @"ClassesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	LOG_DEBUG(@"indexPath = %@", indexPath);
	PFClassTableViewCell *cell = (PFClassTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	
	[self.tableView beginUpdates];
	[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	[self.character removeClassesObject:cell.characterClass];
	[self.tableView endUpdates];
	[self updateFields];
}


//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *header = (UIView*)[tableView dequeueReusableCellWithIdentifier:@"ClassesHeader"];
	return header;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	LOG_DEBUG(@"indexPath = %@", indexPath);
	PFClassTableViewCell *cell = (PFClassTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	cell.levelStepper.alpha = 0.0;

}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	LOG_DEBUG(@"indexPath = %@", indexPath);
	PFClassTableViewCell *cell = (PFClassTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	cell.levelStepper.alpha = 1.0;
}

//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	// Default implementation just returns our current view frame
	return kPFClassesViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	// Default implementation just returns our current view frame
	return kPFClassesViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	// Default implementation just returns our current view frame
	return kPFClassesViewBoundsEditing;
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

		for (PFClassTableViewCell *aCell in self.tableView.visibleCells) {
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

		for (PFClassTableViewCell *aCell in self.tableView.visibleCells) {
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
		self.tableView.rowHeight = kClassesViewRowHeightEditing;
		[self.tableView endUpdates];
	}
	else {
		[self.tableView beginUpdates];
		self.tableView.rowHeight = kClassesViewRowHeightStatic;
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
	//if ([segue.identifier hasSuffix:@"Container"]) {
	//}
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
