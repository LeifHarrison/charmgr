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
@class PFTrait;

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
@property (nonatomic, retain) NSString * source;
@property (nonatomic) int16_t speed;
@property (nonatomic, retain) NSString * subtype;
@property (nonatomic, retain) NSString * type;

@property (nonatomic, retain) NSSet *characters;
@property (nonatomic, retain) NSSet *traits;

+ (PFRace *)insertedInstanceWithElement:(GDataXMLElement *)anElement
				 inManagedObjectContext:(NSManagedObjectContext*)moc;

@end

@interface PFRace (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(PFCharacter *)value;
- (void)removeCharactersObject:(PFCharacter *)value;
- (void)addCharacters:(NSSet *)values;
- (void)removeCharacters:(NSSet *)values;

- (void)addTraitsObject:(PFTrait *)value;
- (void)removeTraitsObject:(PFTrait *)value;
- (void)addTraits:(NSSet *)values;
- (void)removeTraits:(NSSet *)values;

@end
