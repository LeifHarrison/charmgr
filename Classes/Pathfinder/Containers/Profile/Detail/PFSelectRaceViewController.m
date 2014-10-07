//
//  PFEditClassViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 11/3/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFSelectRaceViewController.h"

#import "PFCharacter.h"
#import "PFRace.h"

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFSelectRaceViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFSelectRaceViewController

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

//	self.tableView.backgroundColor = [UIColor lightGrayColor];
//	self.tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
//	self.tableView.layer.borderWidth = 1.5f;
//	self.tableView.layer.cornerRadius = 4.0f;
	[self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	LOG_DEBUG(@"start fetching...");
	NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
		
		// abort() causes the application to generate a crash log and terminate.
		// You should not use this function in a shipping application, although
		// it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //abort();
    }
	LOG_DEBUG(@"end fetching...");
}

- (void)dealloc
{
	[self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	self.preferredContentSize = self.tableView.contentSize;
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

// Returns the fetched results controller. Creates and configures the controller
// if necessary.
- (NSFetchedResultsController *)fetchedResultsController
{
	NSManagedObjectContext *moc = self.character.managedObjectContext;
	
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
	if (moc) {
		// Create and configure a fetch request with the Book entity.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"PFRace" inManagedObjectContext:moc];
		[fetchRequest setEntity:entity];
		
		// Create the sort descriptors array.
		NSSortDescriptor *sourceDescriptor = [[NSSortDescriptor alloc] initWithKey:@"source.name" ascending:YES];
		NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sourceDescriptor, nameDescriptor, nil];
		[fetchRequest setSortDescriptors:sortDescriptors];
		
		// Create and initialize the fetch results controller.
		_fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
																		managedObjectContext:moc
																		  sectionNameKeyPath:@"source.name"
																				   cacheName:@"Races"];
		_fetchedResultsController.delegate = self;
	}
        
    return _fetchedResultsController;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    PFRace *aRace = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = aRace.name;
}

//------------------------------------------------------------------------------
#pragma mark - NSFetchedResultsController Delegate
//------------------------------------------------------------------------------

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so
	// prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell
	// the table view to process all updates.
    [self.tableView endUpdates];
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	LOG_DEBUG(@"sections = %lu", [[self.fetchedResultsController sections] count]);
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	LOG_DEBUG(@"section = %ld, rows = %lu", (long)section, [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFRace *selectedRace = [self.fetchedResultsController objectAtIndexPath:indexPath];
	LOG_DEBUG(@"indexPath = %@, selectedRace = %@", indexPath, selectedRace);
	self.character.race = selectedRace;
	self.character.size = selectedRace.size;

	[self dismissViewControllerAnimated:YES completion:^{
		[self.delegate detailViewControllerDidFinish:self];
	}];
}

@end
