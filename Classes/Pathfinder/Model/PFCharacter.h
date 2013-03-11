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
@class PFWeapon;

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
@property (nonatomic, retain) NSSet *weapons;

- (NSString*)classSummaryDescription;
- (NSString*)genderDescription;
- (NSString*)sizeDescription;
- (NSInteger)sizeModifier;

// Abilities

- (NSArray *)sortedAbilities;
- (PFCharacterAbility *)abilityWithName:(NSString*)aName;
- (PFCharacterAbility *)abilityWithAbbreviation:(NSString*)anAbbreviation;
- (PFCharacterAbility *)abilityWithType:(PFAbilityType)aType;

- (NSInteger)strengthBonus;
- (NSInteger)dexterityBonus;
- (NSInteger)constitutionBonus;
- (NSInteger)intelligenceBonus;
- (NSInteger)wisdomBonus;
- (NSInteger)charismaBonus;

// Classes

// Experience/Level

- (NSInteger)nextLevelXP;

- (NSInteger)levelAdjustment;
- (NSInteger)effectiveLevel;

// Saving Throws

- (NSInteger)fortitudeBonus;
- (NSInteger)fortitudeBaseBonus;
- (NSInteger)fortitudeRacialBonus;

- (NSInteger)reflexBonus;
- (NSInteger)reflexBaseBonus;
- (NSInteger)reflexRacialBonus;

- (NSInteger)willBonus;
- (NSInteger)willBaseBonus;
- (NSInteger)willRacialBonus;

// Initiative

- (NSInteger)initiativeBonus;
- (NSInteger)initiativeFeatBonus;
- (NSInteger)initiativeTrainingBonus;

// Base Attack Bonus

- (NSInteger)numberOfAttacks;

- (NSInteger)baseAttackBonus;
- (NSInteger)meleeAttackBonus;
- (NSInteger)rangedAttackBonus;

- (NSInteger)baseAttackBonusForAttackNumber:(NSInteger)attackNumber;
- (NSInteger)meleeAttackBonusForAttackNumber:(NSInteger)attackNumber;
- (NSInteger)rangedAttackBonusForAttackNumber:(NSInteger)attackNumber;

// String description of all attack bonuses (for multiple attacks)
- (NSString *)baseAttackBonusDescription;
- (NSString *)meleeAttackBonusDescription;
- (NSString *)rangedAttackBonusDescription;

// Combat Manuevers (CMB/CMD)

- (NSInteger)combatManueverBonus;
- (NSInteger)combatManueverDefence;
- (NSInteger)flatFootedCMD;

// Armor Class

- (NSInteger)armorClass;
- (NSInteger)flatFootedArmorClass;
- (NSInteger)touchArmorClass;

- (NSInteger)enhancementBonus;
- (NSInteger)dodgeBonus;
- (NSInteger)deflectionBonus;
- (NSInteger)armorBonus;
- (NSInteger)shieldBonus;
- (NSInteger)naturalArmorBonus;

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

- (void)addWeaponsObject:(PFWeapon *)value;
- (void)removeWeaponsObject:(PFWeapon *)value;
- (void)addWeapons:(NSSet *)values;
- (void)removeWeapons:(NSSet *)values;

@end
