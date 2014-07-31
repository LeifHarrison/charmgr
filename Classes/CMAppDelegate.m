//
//  CMAppDelegate.m
//  CharMgr
//
//  Created by Leif Harrison on 2/22/10.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "CMAppDelegate.h"

#import "PFDataManager.h"
#import "PFSource.h"

#import <CoreData/CoreData.h>

//#define DELETE_STORE

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface CMAppDelegate ()

@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readwrite) PFDataManager *dataManager;

- (NSURL *)applicationDocumentsDirectory;

- (void)saveContext;

@end


//==============================================================================
// Class Implementation
//==============================================================================

@implementation CMAppDelegate

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@synthesize window;

@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentStoreCoordinator;


//------------------------------------------------------------------------------
#pragma mark - UIApplication Delegate
//------------------------------------------------------------------------------

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef DELETE_STORE
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Pathfinder.CDBStore"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // If the expected store doesn't exist, copy the default store.
    if ([fileManager fileExistsAtPath:[storeURL path]]) {
		LOG_DEBUG(@"Removing CoreData data store...");
		NSError *error = nil;
		[fileManager removeItemAtPath:[storeURL path] error:&error];
	}
	[self clearDefaults];
#endif

	self.dataManager = [[PFDataManager alloc] init];
	[self importReferenceData];
	
    return YES;
}


//------------------------------------------------------------------------------
#pragma mark - Private Methods
//------------------------------------------------------------------------------

- (void)importReferenceData
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

	CMAppDelegate *appDelegate = (CMAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	[moc setPersistentStoreCoordinator:[appDelegate persistentStoreCoordinator]];

	[self.dataManager importSourcesInManagedObjectContext:moc];
	NSError *error = nil;
	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}

	// General stuff from Core rules
	[self.dataManager importAbilitiesInManagedObjectContext:moc];
	[self.dataManager importAlignmentsInManagedObjectContext:moc];
	[self.dataManager importSkillsInManagedObjectContext:moc];

	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}

	NSArray *sources = [PFSource fetchAllInContext:moc];
	for (PFSource *aSource in sources) {
		[self.dataManager importClassesForSource:aSource inManagedObjectContext:moc];
		[self.dataManager importRacesForSource:aSource inManagedObjectContext:moc];
		[self.dataManager importFeatsForSource:aSource inManagedObjectContext:moc];
		[self.dataManager importWeaponsForSource:aSource inManagedObjectContext:moc];
		if (![moc save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		}
	}

	[userDefaults synchronize];
}

- (void)saveContext
{
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
			 
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)clearDefaults
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

	[userDefaults removeObjectForKey:kCMCurrentCharacterDefaultsKey];
	[userDefaults removeObjectForKey:kCMCurrentPageDefaultsKey];
	[userDefaults removeObjectForKey:kPFImportDatesDefaultsKey];

	[userDefaults synchronize];
}

//------------------------------------------------------------------------------
#pragma mark - Core Data Stack
//------------------------------------------------------------------------------

/*
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext
{
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Pathfinder" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}


/*
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Pathfinder.CDBStore"];
	
    // Set up the store.

    NSFileManager *fileManager = [NSFileManager defaultManager];
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:[storeURL path]]) {
        NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:@"Pathfinder" withExtension:@"CDBStore"];
        if (defaultStoreURL) {
            [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
        }
    }
	
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(YES), NSInferMappingModelAutomaticallyOption: @(YES)};
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	
    NSError *error;
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
#ifdef DEBUG
		// Remove the existing file and try again...
		if ([fileManager fileExistsAtPath:[storeURL path]]) {
			NSError *error = nil;
			[fileManager removeItemAtPath:[storeURL path] error:&error];

			[self clearDefaults];
		}
		if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
#else
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
#endif
    }
	
    return persistentStoreCoordinator;
}


//------------------------------------------------------------------------------
#pragma mark - Application Documents Directory
//------------------------------------------------------------------------------

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end

