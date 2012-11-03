//
//  PFAbility.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

#import "PFTypes.h"

@class GDataXMLElement;

@class PFCharacterAbility;

@interface PFAbility : NSManagedObject

@property (nonatomic) int16_t abilityType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * abbreviation;
@property (nonatomic, retain) NSString * descriptionShort;
@property (nonatomic, retain) NSString * descriptionLong;

@property (nonatomic, retain) NSSet *characterAbilities;

+ (PFAbility *)insertedInstanceWithElement:(GDataXMLElement *)anElement
					inManagedObjectContext:(NSManagedObjectContext*)moc;

+ (NSArray*)fetchAllAbilitiesInContext:(NSManagedObjectContext*)moc;

@end

@interface PFAbility (CoreDataGeneratedAccessors)

- (void)addCharacterAbilitiesObject:(PFCharacterAbility *)value;
- (void)removeCharacterAbilitiesObject:(PFCharacterAbility *)value;
- (void)addCharacterAbilities:(NSSet *)values;
- (void)removeCharacterAbilities:(NSSet *)values;

@end
