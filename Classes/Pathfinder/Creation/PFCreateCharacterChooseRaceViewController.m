//
//  PFChooseRaceViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 10/9/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFCreateCharacterChooseRaceViewController.h"

#import "PFChooseRaceTableViewCell.h"

#import "PFCharacter.h"
#import "PFRace.h"


//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFCreateCharacterChooseRaceViewController ()

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) PFChooseRaceTableViewCell *prototypeCell;

@end


//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFCreateCharacterChooseRaceViewController

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------


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
	
	self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.tableView.layer.borderWidth = 1.5f;
	self.tableView.layer.cornerRadius = 4.0f;

	NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
		
		// abort() causes the application to generate a crash log and terminate.
		// You should not use this function in a shipping application, although
		// it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"RaceCell"];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	//self.prototypeCell.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.estimatedRowHeight);
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

// Returns the fetched results controller. Creates and configures the controller if necessary.
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    // Create and configure a fetch request with the Book entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PFRace" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *sourceDescriptor = [[NSSortDescriptor alloc] initWithKey:@"source.index" ascending:YES];
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sourceDescriptor, nameDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
																	managedObjectContext:self.managedObjectContext
																	  sectionNameKeyPath:@"source.name"
																			   cacheName:@"Races"];
    _fetchedResultsController.delegate = self;
    
    // Memory management.
    
    return _fetchedResultsController;
}

- (PFChooseRaceTableViewCell *)prototypeCell
{
	if (!_prototypeCell)
	{
		_prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"RaceCell"];
	}
	return _prototypeCell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	PFChooseRaceTableViewCell *raceCell = (PFChooseRaceTableViewCell*)cell;

    PFRace *aRace = [self.fetchedResultsController objectAtIndexPath:indexPath];
    raceCell.raceNameLabel.text = aRace.name;
	raceCell.raceDescriptionLabel.text = aRace.descriptionShort;
	//LOG_DEBUG(@"  descriptionShort = %@", aRace.descriptionShort);
}


//------------------------------------------------------------------------------
#pragma mark - NSFetchedResultsController Delegate
//------------------------------------------------------------------------------

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//LOG_DEBUG(@"sections = %lu", [[self.fetchedResultsController sections] count]);
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	//LOG_DEBUG(@"section = %ld, rows = %lu", (long)section, (unsigned long)[sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//LOG_DEBUG(@"indexPath = %@", indexPath);
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


//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	LOG_DEBUG(@"indexPath = %@", indexPath);
	PFRace *aRace = [self.fetchedResultsController objectAtIndexPath:indexPath];
	LOG_DEBUG(@"aRace = %@", aRace);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self configureCell:self.prototypeCell atIndexPath:indexPath];
	CGSize contentSize = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
	//LOG_DEBUG(@"contentSize = %@", NSStringFromCGSize(contentSize));
	return contentSize.height + 1.0f;
}

//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (IBAction)save:(id)sender
{
	TRACE;
	
	PFRace *aRace = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
	self.character.race = aRace;
	self.character.size = aRace.size;
	
    [super save:sender];
}


//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	//LOG_DEBUG(@"seque = %@, sender = %@", segue.identifier, sender);
	
	if ([segue.identifier hasSuffix:@"NextController"]) {
		//LOG_DEBUG(@"selected index path = %@", self.tableView.indexPathForSelectedRow);
		PFRace *aRace = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
		//LOG_DEBUG(@"selected race = %@", aRace);
		self.character.race = aRace;
		//LOG_DEBUG(@"character = %@", self.character);
	}
	
	[super prepareForSegue:segue sender:sender];
}

@end
