//
//  PFRace.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class PFCharacter;
@class PFSource;
@class PFRacialTrait;

@class GDataXMLElement;

@interface PFRace : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * descriptionShort;
@property (nonatomic, retain) NSString * descriptionLong;
@property (nonatomic, retain) NSString * physicalDescription;
@property (nonatomic, retain) NSString * society;
@property (nonatomic, retain) NSString * relations;
@property (nonatomic, retain) NSString * alignmentAndReligion;
@property (nonatomic, retain) NSString * adventurers;
@property (nonatomic, retain) NSString * namesFemale;
@property (nonatomic, retain) NSString * namesMale;
@property (nonatomic) int16_t size;
@property (nonatomic) int16_t speed;
@property (nonatomic, retain) NSString * subtype;
@property (nonatomic, retain) NSString * type;

@property (nonatomic, retain) PFSource *source;

@property (nonatomic, retain) NSSet *characters;
@property (nonatomic, retain) NSSet *traits;

+ (PFRace *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
					 inManagedObjectContext:(NSManagedObjectContext*)moc;

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc;
+ (PFRace*)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;

- (NSArray *)sortedTraits;

@end

@interface PFRace (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(PFCharacter *)value;
- (void)removeCharactersObject:(PFCharacter *)value;
- (void)addCharacters:(NSSet *)values;
- (void)removeCharacters:(NSSet *)values;

- (void)addTraitsObject:(PFRacialTrait *)value;
- (void)removeTraitsObject:(PFRacialTrait *)value;
- (void)addTraits:(NSSet *)values;
- (void)removeTraits:(NSSet *)values;

@end
