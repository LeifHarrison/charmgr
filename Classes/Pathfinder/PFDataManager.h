//
//  PFDataManager.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFSource;

@interface PFDataManager : NSObject

- (void)importAbilitiesInManagedObjectContext:(NSManagedObjectContext *)moc;
- (void)importAlignmentsInManagedObjectContext:(NSManagedObjectContext *)moc;
- (void)importSkillsInManagedObjectContext:(NSManagedObjectContext *)moc;
- (void)importSourcesInManagedObjectContext:(NSManagedObjectContext *)moc;

- (void)importClassesForSource:(PFSource*)source inManagedObjectContext:(NSManagedObjectContext *)moc;
- (void)importFeatsForSource:(PFSource*)source   inManagedObjectContext:(NSManagedObjectContext *)moc;
- (void)importRacesForSource:(PFSource*)source   inManagedObjectContext:(NSManagedObjectContext *)moc;
- (void)importWeaponsForSource:(PFSource*)source inManagedObjectContext:(NSManagedObjectContext *)moc;

@end
