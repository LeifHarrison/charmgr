//
//  PFReferenceFeatsViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 11/3/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFReferenceFeatsViewController.h"

#import "CMAppDelegate.h"

#import "PFReferenceFeatCell.h"

#import "PFFeat.h"

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFReferenceFeatsViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFReferenceFeatsViewController

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

	self.tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.tableView.layer.borderWidth = 1.0f;
	self.tableView.layer.cornerRadius = 5.0f;

	self.detailContainerView.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.detailContainerView.layer.borderWidth = 1.0f;
	self.detailContainerView.layer.cornerRadius = 5.0f;
	
	self.featNameLabel.text = @"";
	self.featTypeLabel.text = @"";
	self.featSourceLabel.text = @"";
	self.prerequisitesTextView.text = @"";
	self.benefitTextView.text = @"";

	self.managedObjectContext = [(CMAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
	
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
    [self.tableView reloadData];
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
#pragma mark - Actions
//------------------------------------------------------------------------------

- (IBAction)dismissView:(id)sender;
{
	LOG_DEBUG(@"parentViewController = %@", self.parentViewController);
	LOG_DEBUG(@"presentingViewController = %@", self.presentingViewController);
	LOG_DEBUG(@"presentedViewController = %@", self.presentedViewController);
	LOG_DEBUG(@"tabBarController = %@", self.tabBarController);
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PFFeat" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:nameDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
																	managedObjectContext:self.managedObjectContext
																	  sectionNameKeyPath:@"source"
																			   cacheName:@"Feats"];
    _fetchedResultsController.delegate = self;
    
    // Memory management.
    
    return _fetchedResultsController;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	PFReferenceFeatCell *featCell = (PFReferenceFeatCell*)cell;
    PFFeat *feat = [self.fetchedResultsController objectAtIndexPath:indexPath];
    featCell.featNameLabel.text = feat.name;
    featCell.featTypeLabel.text = feat.type;
	featCell.featSourceLabel.text = feat.source;
	featCell.prerequisitesLabel.text = feat.prerequisitesString;
	featCell.benefitLabel.text = feat.benefitString;
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	LOG_DEBUG(@"sections = %d", [[self.fetchedResultsController sections] count]);
    return [[self.fetchedResultsController sections] count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	LOG_DEBUG(@"section = %d, rows = %d", section, [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReferenceFeatCell";
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
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
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

	PFFeat *selectedFeat = [self.fetchedResultsController objectAtIndexPath:indexPath];
	LOG_DEBUG(@"selectedFeat = %@", selectedFeat);
	
	self.featNameLabel.text = selectedFeat.name;
	self.featTypeLabel.text = selectedFeat.type;
	self.featSourceLabel.text = selectedFeat.source;

	self.prerequisitesTextView.text = selectedFeat.prerequisitesString;
	self.benefitTextView.text = selectedFeat.benefitString;
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
    UITableView *tableView = self.tableView;
	
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            //[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{
    UITableView *tableView = self.tableView;
	
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


@end
