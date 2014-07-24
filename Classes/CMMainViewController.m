//
//  CMMainViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "CMMainViewController.h"

#import "CMAppDelegate.h"
#import "CMRootViewController.h"
#import "CMSettings.h"

#import "PFCreateCharacterViewController.h"

#import "PFCombatViewController.h"
#import "PFEquipmentViewController.h"
#import "PFNotesViewController.h"
#import "PFProfileViewController.h"

#import "PFCharacterSelectionCell.h"

#import "PFAbility.h"
#import "PFCharacter.h"
#import "PFCharacterAbility.h"
#import "PFCharacterClass.h"
#import "PFCharacterSkill.h"
#import "PFClassType.h"
#import "PFRace.h"
#import "PFSkill.h"

#import "UIImage+PDF.h"

#import <CoreData/CoreData.h>

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface CMMainViewController ()

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end


//==============================================================================
// Class Implementation
//==============================================================================

@implementation CMMainViewController

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;

@synthesize charactersTableView;
@synthesize createCharacterButton;


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
	
	self.view.layer.contents = (id)[[[CMSettings sharedSettings] pageBackgroundImage] CGImage];
	//UIImage *image = [UIImage imageWithPDFNamed:@"PathfinderRPGCharacterSheet.pdf" atSize:self.view.frame.size atPage:1];
	//self.view.layer.contents = (id)image.CGImage;
	self.view.layer.contentsGravity = kCAGravityResize;

	//self.createCharacterButton.tintColor = [UIColor brownColor];
	//[self.createCharacterButton setBackgroundImage:nil forState:UIControlStateNormal];

	self.charactersTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
	//self.charactersTableView.backgroundColor = [UIColor clearColor];
	//self.charactersContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
	self.charactersContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.charactersContainer.layer.borderWidth = 2.0f;
	self.charactersContainer.layer.cornerRadius = 6.0f;
	self.charactersContainer.clipsToBounds = YES;
	
	UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
	UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	[blurEffectView setFrame:self.charactersContainer.bounds];
	[self.charactersContainer insertSubview:blurEffectView belowSubview:self.charactersTableView];

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
    [self.charactersTableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.fetchedResultsController = nil;
}


//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	LOG_DEBUG(@"sections = %lu", (unsigned long)[[self.fetchedResultsController sections] count]);
    return [[self.fetchedResultsController sections] count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	LOG_DEBUG(@"section = %ld, rows = %lu", (long)section, [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PFCharacterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell.backgroundColor = [UIColor clearColor];
	
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // Display the authors' names as section headings.
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
	PFCharacter *selectedCharacter = [self.fetchedResultsController objectAtIndexPath:indexPath];
	//LOG_DEBUG(@"parentViewController = %@", self.parentViewController);
	//LOG_DEBUG(@"rootViewController = %@", self.view.window.rootViewController);
	UIPageViewController *pageViewController = (UIPageViewController *)self.parentViewController;
	
	CMRootViewController *rootViewController = (CMRootViewController*)self.view.window.rootViewController;

	NSArray *pages = [self createViewControllersForCharacter:selectedCharacter];
	LOG_DEBUG(@"pages = %@", pages);
	rootViewController.characterViewControllers = pages;
	
	[pageViewController setViewControllers:[NSArray arrayWithObject:[pages objectAtIndex:0]]
								 direction:UIPageViewControllerNavigationDirectionForward
								  animated:YES
								completion:nil];
	//LOG_DEBUG(@"viewControllers = %@", pageViewController.viewControllers);

	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:selectedCharacter.name forKey:kCMCurrentCharacterDefaultsKey];
	[userDefaults synchronize];

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (IBAction)showReferenceView:(id)sender;
{
	TRACE;
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Reference" bundle:[NSBundle mainBundle]];
	UIViewController *referenceViewController = [storyboard instantiateViewControllerWithIdentifier:@"ReferenceTabBarController"];
	referenceViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	referenceViewController.modalPresentationStyle = UIModalPresentationFullScreen;
	//LOG_DEBUG(@"referenceViewController = %@", referenceViewController);
	[referenceViewController setNeedsStatusBarAppearanceUpdate];
	[self presentViewController:referenceViewController animated:YES completion:^{}];
}

- (IBAction)showPreferencesView:(id)sender;
{
	
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PFCharacter" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:nameDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
																	managedObjectContext:self.managedObjectContext
																	  sectionNameKeyPath:nil
																			   cacheName:@"Characters"];
    _fetchedResultsController.delegate = self;
    
    // Memory management.
    
    return _fetchedResultsController;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell to show the book's title
    PFCharacter *character = [self.fetchedResultsController objectAtIndexPath:indexPath];
	PFCharacterSelectionCell *charCell = (PFCharacterSelectionCell*)cell;
	
    charCell.characterNameLabel.text = character.name;
	charCell.campaignLabel.text = character.campaign;
	charCell.classSummaryLabel.text = [character classSummaryDescription];
	charCell.raceLabel.text = character.race.name;
}

- (NSArray *)createViewControllersForCharacter:(PFCharacter*)aCharacter
{
	NSMutableArray *pages = [NSMutableArray arrayWithCapacity:10];
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Profile" bundle:[NSBundle mainBundle]];
	PFProfileViewController *profileViewController = [storyboard instantiateViewControllerWithIdentifier:@"PFProfileViewController"];
	LOG_DEBUG(@"profileViewController = %@", profileViewController);
	profileViewController.character = aCharacter;
	[pages addObject:profileViewController];
	
	storyboard = [UIStoryboard storyboardWithName:@"Combat" bundle:[NSBundle mainBundle]];
	PFCombatViewController *combatViewController = [storyboard instantiateViewControllerWithIdentifier:@"PFCombatViewController"];
	LOG_DEBUG(@"combatViewController = %@", combatViewController);
	combatViewController.character = aCharacter;
	[pages addObject:combatViewController];
	
	storyboard = [UIStoryboard storyboardWithName:@"Equipment" bundle:[NSBundle mainBundle]];
	PFEquipmentViewController *gearViewController = [storyboard instantiateViewControllerWithIdentifier:@"PFGearViewController"];
	LOG_DEBUG(@"gearViewController = %@", gearViewController);
	gearViewController.character = aCharacter;
	[pages addObject:gearViewController];

	storyboard = [UIStoryboard storyboardWithName:@"Notes" bundle:[NSBundle mainBundle]];
	PFNotesViewController *notesViewController = [storyboard instantiateViewControllerWithIdentifier:@"PFNotesViewController"];
	LOG_DEBUG(@"notesViewController = %@", notesViewController);
	notesViewController.character = aCharacter;
	[pages addObject:notesViewController];

	return [NSArray arrayWithArray:pages];
}

//------------------------------------------------------------------------------
#pragma mark - NSFetchedResultsController Delegate
//------------------------------------------------------------------------------

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.charactersTableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.charactersTableView;
	
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
    UITableView *tableView = self.charactersTableView;

    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;

		case NSFetchedResultsChangeMove:
		case NSFetchedResultsChangeUpdate:
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.charactersTableView endUpdates];
}

#pragma mark - Segue management

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"CreateCharacter"]) {        
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        PFCreateCharacterViewController *createViewController = (PFCreateCharacterViewController *)[navController topViewController];
        createViewController.delegate = self;
        
        // Create a new managed object context for the new character; set its parent to the fetched results controller's context.
        NSManagedObjectContext *addingContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [addingContext setParentContext:[self.fetchedResultsController managedObjectContext]];
        
		// Create the new character
        PFCharacter *newCharacter = (PFCharacter *)[NSEntityDescription insertNewObjectForEntityForName:@"PFCharacter"
																				 inManagedObjectContext:addingContext];
        createViewController.character = newCharacter;
        createViewController.managedObjectContext = addingContext;
		
		// Add the basic set of abilities
		NSArray *abilities = [PFAbility fetchAllAbilitiesInContext:addingContext];
		for (PFAbility *anAbility in abilities) {
	        PFCharacterAbility *newAbility = (PFCharacterAbility *)[NSEntityDescription insertNewObjectForEntityForName:@"PFCharacterAbility"
																								 inManagedObjectContext:addingContext];
			newAbility.character = newCharacter;
			newAbility.ability = anAbility;
			newAbility.abilityScore = [NSNumber numberWithInt:10];
		}
    }
    
}


#pragma mark - Add controller delegate

/*
 Add controller's delegate method; informs the delegate that the add operation has completed, and indicates whether the user saved the new book.
 */
- (void)createCharacterViewController:(PFCreateCharacterViewController *)controller didFinishWithSave:(BOOL)save
{
	LOG_DEBUG(@"save = %d", save);
	NSManagedObjectContext *moc = [controller managedObjectContext];

    if (save) {
		PFCharacter *newCharacter = controller.character;
		
		// Perform post-creation setup
		
		// Add the basic set of abilities
		NSArray *skills = [PFSkill fetchAllSkillsInContext:moc];
		for (PFSkill *aSkill in skills) {
			BOOL addSkill = aSkill.untrained;
			BOOL isClassSkill = NO;
			
			for (PFCharacterClass *aClass in newCharacter.classes) {
				if ([aClass.classType.classSkills containsObject:aSkill]) {
					addSkill = YES;
					isClassSkill = YES;
				}
			}
			
			if (addSkill) {
				PFCharacterSkill *newInstance = (PFCharacterSkill *)[NSEntityDescription insertNewObjectForEntityForName:@"PFCharacterSkill"
																								  inManagedObjectContext:moc];
				newInstance.character = newCharacter;
				newInstance.skill = aSkill;
				newInstance.isClassSkill = isClassSkill;
			}
		}

		
		LOG_DEBUG(@"character = %@", controller.character);

		// Save the new character
		
        NSError *error;
        if (![moc save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        if (![[self.fetchedResultsController managedObjectContext] save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
	else {
		[moc rollback];
	}
    
    // Dismiss the modal view to return to the main list
    //[self dismissModalViewControllerAnimated:YES];
	[self dismissViewControllerAnimated:YES completion:^{}];
}


@end
