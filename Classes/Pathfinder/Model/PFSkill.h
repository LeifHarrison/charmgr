//
//  PFSkill.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class GDataXMLElement;

@class PFCharacterSkill;
@class PFClassType;

@interface PFSkill : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic) BOOL untrained;
@property (nonatomic) BOOL armorCheckPenalty;
@property (nonatomic) BOOL requiresDetail;
@property (nonatomic, retain) NSString * keyAbility;
@property (nonatomic, retain) NSString * descriptionShort;
@property (nonatomic, retain) NSString * descriptionLong;

@property (nonatomic, retain) NSSet *characterSkills;
@property (nonatomic, retain) NSSet *classTypes;

+ (PFSkill *)insertedInstanceWithElement:(GDataXMLElement *)anElement
				  inManagedObjectContext:(NSManagedObjectContext*)moc;

+ (NSArray*)fetchAllSkillsInContext:(NSManagedObjectContext*)moc;
+ (PFSkill*)fetchSkillWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;

@end

@interface PFSkill (CoreDataGeneratedAccessors)

- (void)addCharacterSkillsObject:(PFCharacterSkill *)value;
- (void)removeCharacterSkillsObject:(PFCharacterSkill *)value;
- (void)addCharacterSkills:(NSSet *)values;
- (void)removeCharacterSkills:(NSSet *)values;

- (void)addClassTypesObject:(PFClassType *)value;
- (void)removeClassTypesObject:(PFClassType *)value;
- (void)addClassTypes:(NSSet *)values;
- (void)removeClassTypes:(NSSet *)values;

@end
