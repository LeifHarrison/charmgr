//
//  CMAppDelegate.m
//  CharMgr
//
//  Created by Leif Harrison on 2/22/10.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "CMAppDelegate.h"

#import "PFDataManager.h"

#import <CoreData/CoreData.h>


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
    TRACE;
/*
#ifdef DEBUG
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Pathfinder.CDBStore"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // If the expected store doesn't exist, copy the default store.
    if ([fileManager fileExistsAtPath:[storeURL path]]) {
		NSError *error = nil;
		[fileManager removeItemAtPath:[storeURL path] error:&error];
	}
#endif
*/
	self.dataManager = [[PFDataManager alloc] init];
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

	NSDate *abilitiesLastUpdated = [userDefaults objectForKey:kCMAbilitiesUpdatedDateDefaultsKey];
	LOG_DEBUG(@"abilitiesLastUpdated = %@", abilitiesLastUpdated);
	if (!abilitiesLastUpdated) {
		[self.dataManager importAbilitiesAsXML];
		[userDefaults setObject:[NSDate date] forKey:kCMAbilitiesUpdatedDateDefaultsKey];
	}
	
	NSDate *alignmentsLastUpdated = [userDefaults objectForKey:kCMAlignmentsUpdatedDateDefaultsKey];
	LOG_DEBUG(@"alignmentsLastUpdated = %@", alignmentsLastUpdated);
	if (!alignmentsLastUpdated) {
		[self.dataManager importAlignmentsAsXML];
		[userDefaults setObject:[NSDate date] forKey:kCMAlignmentsUpdatedDateDefaultsKey];
	}
	
	NSDate *skillsLastUpdated = [userDefaults objectForKey:kCMSkillsUpdatedDateDefaultsKey];
	LOG_DEBUG(@"skillsLastUpdated = %@", skillsLastUpdated);
	if (!skillsLastUpdated) {
		[self.dataManager importSkillsAsXML];
		[userDefaults setObject:[NSDate date] forKey:kCMSkillsUpdatedDateDefaultsKey];
	}
	
	NSDate *racesLastUpdated = [userDefaults objectForKey:kCMRacesUpdatedDateDefaultsKey];
	LOG_DEBUG(@"racesLastUpdated = %@", racesLastUpdated);
	if (!racesLastUpdated) {
		[self.dataManager importRacesAsXML];
		[userDefaults setObject:[NSDate date] forKey:kCMRacesUpdatedDateDefaultsKey];
	}
	
	NSDate *classesLastUpdated = [userDefaults objectForKey:kCMClassesUpdatedDateDefaultsKey];
	LOG_DEBUG(@"classesLastUpdated = %@", classesLastUpdated);
	if (!classesLastUpdated) {
		[self.dataManager importClassTypesAsXML];
		[userDefaults setObject:[NSDate date] forKey:kCMClassesUpdatedDateDefaultsKey];
	}
	
	[userDefaults synchronize];

    return YES;
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


#pragma mark - Core Data stack

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
	
    /*
     Set up the store.
     For the sake of illustration, provide a pre-populated default store.
     */
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:[storeURL path]]) {
        NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:@"Pathfinder" withExtension:@"CDBStore"];
        if (defaultStoreURL) {
            [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
        }
    }
	
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(YES), NSInferMappingModelAutomaticallyOption: @(YES)};
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
	
    NSError *error;
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
	
    return persistentStoreCoordinator;
}


#pragma mark - Application's documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end

