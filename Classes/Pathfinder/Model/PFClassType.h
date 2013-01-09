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
@class PFClassFeature;
@class PFSkill;
@class PFSource;

@interface PFClassType : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * descriptionShort;
@property (nonatomic) int16_t hitDieType;
@property (nonatomic) int16_t skillRanksPerLevel;
@property (nonatomic) int16_t baseAttackBonusType;
@property (nonatomic) int16_t fortitudeSaveBonusType;
@property (nonatomic) int16_t reflexSaveBonusType;
@property (nonatomic) int16_t willSaveBonusType;

@property (nonatomic, retain) PFSource *source;

@property (nonatomic, retain) NSSet *characterClasses;
@property (nonatomic, retain) NSSet *features;
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

- (void)addFeaturesObject:(PFClassFeature *)value;
- (void)removeFeaturesObject:(PFClassFeature *)value;
- (void)addFeatures:(NSSet *)values;
- (void)removeFeatures:(NSSet *)values;

@end
