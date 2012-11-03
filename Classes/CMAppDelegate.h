//
//  CMAppDelegate.h
//  CharMgr
//
//  Created by Leif Harrison on 2/22/10.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFDataManager;

@interface CMAppDelegate : NSObject <UIApplicationDelegate>
{
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong, readonly) PFDataManager *dataManager;

@end
