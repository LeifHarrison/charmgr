//
//  PFClassFeaturesViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFClassFeaturesViewController.h"

#import "CMBannerBox.h"

#import "PFCharacter.h"
#import "PFCharacterClass.h"
#import "PFClassFeature.h"
#import "PFClassType.h"
#import "PFFeat.h"
#import "PFRace.h"
#import "PFRacialTrait.h"

#import "PFClassFeatureCell.h"
#import "PFRacialTraitTableViewCell.h"


//------------------------------------------------------------------------------
#pragma mark - Types/Constants
//------------------------------------------------------------------------------

enum {
	kPFFeaturesTableViewSectionClassFeatures,
	kPFFeaturesTableViewSectionCount
};

static const CGRect kPFFeaturesViewFramePortrait	= { {  10, 255 }, { 345, 480 } };
static const CGRect kPFFeaturesViewFrameLandscape	= { { 300,  10 }, { 311, 480 } };
static const CGRect kPFFeaturesViewBoundsEditing	= { {   0,   0 }, { 345, 480 } };

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFClassFeaturesViewController ()

@property (nonatomic, strong) NSArray *classFeatures;
@property (nonatomic, strong) NSArray *characterFeats;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFClassFeaturesViewController

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
	
    [(CMBannerBox*)self.view setBannerTitle:@"Class Features"];
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
#pragma mark - Private Methods
//------------------------------------------------------------------------------

- (void)updateUI
{
	[super updateUI];
	
	self.classFeatures = nil;
	for (PFCharacterClass *aClass in self.character.classes) {
		NSArray *classFeatures = aClass.classType.features.allObjects;
		
		classFeatures = [classFeatures filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"level <= %d", aClass.level]];
		
		if (!self.classFeatures) {
			self.classFeatures = [classFeatures copy];
		}
		else {
			self.classFeatures = [self.classFeatures arrayByAddingObjectsFromArray:classFeatures];
		}
	}
	
	if (self.classFeatures.count > 0) {
		NSSortDescriptor *levelSort = [NSSortDescriptor sortDescriptorWithKey:@"level" ascending:YES];
		NSSortDescriptor *classSort = [NSSortDescriptor sortDescriptorWithKey:@"class" ascending:YES];
		NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
		self.classFeatures = [self.classFeatures sortedArrayUsingDescriptors:@[levelSort, classSort, nameSort]];
	}

	
	[self.tableView reloadData];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == kPFFeaturesTableViewSectionClassFeatures) {
		PFClassFeatureCell *featureCell = (PFClassFeatureCell *)cell;
		PFClassFeature *aFeature = [self.classFeatures objectAtIndex:indexPath.row];
		//cell.containerState = self.state;
		featureCell.featureNameLabel.text = aFeature.nameAndTypeDescription;
		featureCell.featureLevelLabel.text = aFeature.levelDescription;
	}
}


//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//LOG_DEBUG(@"sections = %d", kPFFeaturesTableViewSectionCount);
    return kPFFeaturesTableViewSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rowCount = 0;
	if (section == kPFFeaturesTableViewSectionClassFeatures) {
		rowCount = self.classFeatures.count;
	}
	//LOG_DEBUG(@"section = %d, rows = %d", section, rowCount);
	return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
	
	if (indexPath.section == kPFFeaturesTableViewSectionClassFeatures) {
		cellIdentifier = @"ClassFeatureCell";
	}
	//LOG_DEBUG(@"indexPath = %@, cell identifier = %@", indexPath, cellIdentifier);

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat cellHeight = 0;
	
	if (indexPath.section == kPFFeaturesTableViewSectionClassFeatures) {
		cellHeight = [PFClassFeatureCell rowHeightForState:self.state];
	}

	//LOG_DEBUG(@"indexPath = %@, cellHeight = %lf", indexPath, cellHeight);
	return cellHeight;
}

//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	// Default implementation just returns our current view frame
	return kPFFeaturesViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	// Default implementation just returns our current view frame
	return kPFFeaturesViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	// Default implementation just returns our current view frame
	return kPFFeaturesViewBoundsEditing;
}

//------------------------------------------------------------------------------
#pragma mark - State Transitions
//------------------------------------------------------------------------------

- (void)willTransitionToState:(PFContainerViewState)newState;
{
	//LOG_DEBUG(@"newState = %d", newState);
	[super willTransitionToState:newState];
	
	
	if (newState == PFContainerViewStateStatic) {
		[self.tableView setScrollEnabled:NO];
		[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		for (PFContainerCell *aCell in self.tableView.visibleCells) {
			[aCell setContainerState:newState animated:YES];
		}
		
	}
}

- (void)didTransitionToState:(PFContainerViewState)newState;
{
	//LOG_DEBUG(@"newState = %d", newState);
	[super didTransitionToState:newState];
	
	if (newState == PFContainerViewStateEditing) {
		[self.tableView setScrollEnabled:YES];
		[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[self.tableView setSeparatorColor:[UIColor colorWithWhite:0.0 alpha:0.2]];
		
		for (PFContainerCell *aCell in self.tableView.visibleCells) {
			[aCell setContainerState:newState animated:YES];
		}
		
	}
}

- (void)animateTransitionToState:(PFContainerViewState)newState;
{
	//LOG_DEBUG(@"newState = %d", newState);
	[super animateTransitionToState:newState];

	if (newState == PFContainerViewStateEditing) {
		[self.tableView beginUpdates];
		for (PFContainerCell *aCell in self.tableView.visibleCells) {
			[aCell setContainerState:newState];
		}
		[self.tableView endUpdates];
	}
	else {
		for (PFContainerCell *aCell in self.tableView.visibleCells) {
			[aCell setContainerState:newState];
		}
	}
}

@end
