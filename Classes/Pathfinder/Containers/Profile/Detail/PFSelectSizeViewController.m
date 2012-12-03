//
//  PFSelectSizeViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 11/11/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFSelectSizeViewController.h"

#import "PFCharacter.h"

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFSelectSizeViewController ()

@property (nonatomic, strong) NSArray *sizesArray;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFSelectSizeViewController

//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.tableView.backgroundColor = [UIColor lightGrayColor];
	self.tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.tableView.layer.borderWidth = 1.5f;
	self.tableView.layer.cornerRadius = 4.0f;
	
	//self.sizesArray = @[@"Small", @"Medium", @"Large", @"Huge"];
	self.sizesArray = @[@"Fine", @"Diminutive", @"Tiny", @"Small", @"Medium", @"Large", @"Huge", @"Colossal", @"Gargantuan"];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
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

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [self.sizesArray objectAtIndex:indexPath.row];
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	LOG_DEBUG(@"sections = %d", 1);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	LOG_DEBUG(@"section = %d, rows = %d", section, self.sizesArray.count);
    return self.sizesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SizeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	LOG_DEBUG(@"indexPath = %@", indexPath);
	NSString *selectedSize = [self.sizesArray objectAtIndex:indexPath.row];
	LOG_DEBUG(@"selectedSize = %@", selectedSize);
	self.character.size = PFSizeTypeFromString(selectedSize);
	[self.delegate detailViewControllerDidFinish:self];
}

@end
