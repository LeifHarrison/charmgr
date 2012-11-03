//
//  PFClassType.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GDataXMLElement;

@class PFCharacterClass;
@class PFSkill;

@interface PFClassType : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * descriptionShort;
@property (nonatomic) int16_t hitDieType;
@property (nonatomic) int16_t skillRanks;

@property (nonatomic, retain) NSSet *characterClasses;
@property (nonatomic, retain) NSSet *classSkills;

+ (PFClassType *)insertedInstanceWithElement:(GDataXMLElement *)anElement
					  inManagedObjectContext:(NSManagedObjectContext*)moc;

- (NSString*)hitDieTypeDescription;

@end

@interface PFClassType (CoreDataGeneratedAccessors)

- (void)addCharacterClassesObject:(PFCharacterClass *)value;
- (void)removeCharacterClassesObject:(PFCharacterClass *)value;
- (void)addCharacterClasses:(NSSet *)values;
- (void)removeCharacterClasses:(NSSet *)values;

- (void)addClassSkillsObject:(PFSkill *)value;
- (void)removeClassSkillsObject:(PFSkill *)value;
- (void)addClassSkills:(NSSet *)values;
- (void)removeClassSkills:(NSSet *)values;

@end
