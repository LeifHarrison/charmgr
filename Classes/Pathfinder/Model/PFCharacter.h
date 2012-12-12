//
//  PFCharacter.h
//  CharMgr
//
//  Created by Leif Harrison on 9/7/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PFAlignment;
@class PFCharacterAbility;
@class PFCharacterClass;
@class PFCharacterSkill;
@class PFRace;

@interface PFCharacter : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * player;
@property (nonatomic, retain) NSString * campaign;

@property (nonatomic) int16_t gender;
@property (nonatomic) int16_t size;

@property (nonatomic) int32_t experiencePoints;
@property (nonatomic) int16_t hitPoints;
@property (nonatomic) int16_t wounds;
@property (nonatomic) int16_t nonLethalWounds;

@property (nonatomic) int16_t fortitudeMiscBonus;
@property (nonatomic) int16_t reflexMiscBonus;
@property (nonatomic) int16_t willMiscBonus;

@property (nonatomic) int16_t initiativeMiscBonus;

@property (nonatomic, retain) PFAlignment *alignment;
@property (nonatomic, retain) PFRace *race;

@property (nonatomic, retain) NSSet *abilities;
@property (nonatomic, retain) NSSet *classes;
@property (nonatomic, retain) NSSet *skills;

- (NSString*)genderDescription;
- (NSString*)sizeDescription;

// Abilities

- (NSArray *)sortedAbilities;
- (PFCharacterAbility *)abilityWithName:(NSString*)aName;
- (PFCharacterAbility *)abilityWithAbbreviation:(NSString*)anAbbreviation;
- (PFCharacterAbility *)abilityWithType:(PFAbilityType)aType;

// Classes

// Experience/Level

- (NSInteger)nextLevelXP;

- (NSInteger)levelAdjustment;
- (NSInteger)effectiveLevel;

// Saving Throws

- (NSInteger)fortitudeBonus;
- (NSInteger)fortitudeBaseBonus;
- (NSInteger)fortitudeAbilityBonus;
- (NSInteger)fortitudeRacialBonus;

- (NSInteger)reflexBonus;
- (NSInteger)reflexBaseBonus;
- (NSInteger)reflexAbilityBonus;
- (NSInteger)reflexRacialBonus;

- (NSInteger)willBonus;
- (NSInteger)willBaseBonus;
- (NSInteger)willAbilityBonus;
- (NSInteger)willRacialBonus;

// Initiative

- (NSInteger)initiativeBonus;
- (NSInteger)initiativeAbilityBonus;
- (NSInteger)initiativeFeatBonus;
- (NSInteger)initiativeTrainingBonus;

// Armor Class

- (NSInteger)armorClass;
- (NSInteger)armorClassAbilityModifier;
- (NSInteger)armorClassDodgeModifier;
- (NSInteger)armorClassDeflectionModifier;
- (NSInteger)armorClassArmorModifier;
- (NSInteger)armorClassShieldModifier;
- (NSInteger)armorClassNaturalArmorModifier;
- (NSInteger)armorClassSizeModifier;

- (NSInteger)flatFootedArmorClass;
- (NSInteger)touchArmorClass;

// Skills

- (NSArray *)sortedSkills;
- (PFCharacterSkill *)skillWithName:(NSString *)aName;

// Fetching

+ (PFCharacter*)fetchCharacterWithName:(NSString *)aName context:(NSManagedObjectContext*)moc;

@end

@interface PFCharacter (CoreDataGeneratedAccessors)

- (void)addAbilitiesObject:(PFCharacterAbility *)value;
- (void)removeAbilitiesObject:(PFCharacterAbility *)value;
- (void)addAbilities:(NSSet *)values;
- (void)removeAbilities:(NSSet *)values;

- (void)addClassesObject:(PFCharacterClass *)value;
- (void)removeClassesObject:(PFCharacterClass *)value;
- (void)addClasses:(NSSet *)values;
- (void)removeClasses:(NSSet *)values;

- (void)addSkillsObject:(PFCharacterSkill *)value;
- (void)removeSkillsObject:(PFCharacterSkill *)value;
- (void)addSkills:(NSSet *)values;
- (void)removeSkills:(NSSet *)values;

@end
