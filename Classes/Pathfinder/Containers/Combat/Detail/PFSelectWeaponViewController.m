//
//  PFSelectWeaponViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 3/17/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import "PFSelectWeaponViewController.h"

#import "PFCharacter.h"
#import "PFCharacterWeapon.h"
#import "PFWeapon.h"

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFSelectWeaponViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFSelectWeaponViewController

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
	
	self.tableView.backgroundColor = [UIColor lightGrayColor];
	//self.tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
	//self.tableView.layer.borderWidth = 1.5f;
	//self.tableView.layer.cornerRadius = 4.0f;
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PFWeapon" inManagedObjectContext:self.character.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *categoryDescriptor = [[NSSortDescriptor alloc] initWithKey:@"category" ascending:YES];
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:categoryDescriptor, nameDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
																	managedObjectContext:self.character.managedObjectContext
																	  sectionNameKeyPath:@"category"
																			   cacheName:@"Weapons"];
    _fetchedResultsController.delegate = self;
    
    // Memory management.
    
    return _fetchedResultsController;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    PFWeapon *aWeapon = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = aWeapon.name;
}


//------------------------------------------------------------------------------
#pragma mark - NSFetchedResultsController Delegate
//------------------------------------------------------------------------------

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
								  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
								  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            //[self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
								  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
								  withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						  withRowAnimation:UITableViewRowAnimationFade];
            break;
			
		case NSFetchedResultsChangeMove:
		case NSFetchedResultsChangeUpdate:
			break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	LOG_DEBUG(@"sections = %lu", [[self.fetchedResultsController sections] count]);
    return [[self.fetchedResultsController sections] count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	LOG_DEBUG(@"section = %ld, rows = %lu", (long)section, [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WeaponCell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}


- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	LOG_DEBUG(@"indexPath = %@", indexPath);
    PFWeapon *selectedWeapon = [self.fetchedResultsController objectAtIndexPath:indexPath];
	LOG_DEBUG(@"selectedWeapon = %@", selectedWeapon);

	PFCharacterWeapon *newCharWeapon = (PFCharacterWeapon *)[NSEntityDescription insertNewObjectForEntityForName:@"PFCharacterWeapon"
																					   inManagedObjectContext:self.character.managedObjectContext];
	newCharWeapon.character = self.character;
	newCharWeapon.weapon = selectedWeapon;
	
	[self.delegate detailViewControllerDidFinish:self];
}


//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

@end
