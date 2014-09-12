//
//  PFSource.h
//  CharMgr
//
//  Created by Leif Harrison on 11/26/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GDataXMLElement;

@class PFClassType, PFFeat, PFRace, PFTrait;

@interface PFSource : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t index;
@property (nonatomic, retain) NSString * abbreviation;
@property (nonatomic, retain) NSSet *classTypes;
@property (nonatomic, retain) NSSet *races;
@property (nonatomic, retain) NSSet *feats;
@property (nonatomic, retain) NSSet *traits;

+ (PFSource *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
					   inManagedObjectContext:(NSManagedObjectContext*)moc;

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc;
+ (PFSource*)fetchWithAbbreviation:(NSString *)aName inContext:(NSManagedObjectContext*)moc;


@end

@interface PFSource (CoreDataGeneratedAccessors)

- (void)addClassTypesObject:(PFClassType *)value;
- (void)removeClassTypesObject:(PFClassType *)value;
- (void)addClassTypes:(NSSet *)values;
- (void)removeClassTypes:(NSSet *)values;

- (void)addRacesObject:(PFRace *)value;
- (void)removeRacesObject:(PFRace *)value;
- (void)addRaces:(NSSet *)values;
- (void)removeRaces:(NSSet *)values;

- (void)addFeatsObject:(PFFeat *)value;
- (void)removeFeatsObject:(PFFeat *)value;
- (void)addFeats:(NSSet *)values;
- (void)removeFeats:(NSSet *)values;

- (void)addTraitsObject:(PFTrait *)value;
- (void)removeTraitsObject:(PFTrait *)value;
- (void)addTraits:(NSSet *)values;
- (void)removeTraits:(NSSet *)values;

@end
