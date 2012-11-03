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

@property (nonatomic, retain) PFAlignment *alignment;
@property (nonatomic, retain) PFRace *race;

@property (nonatomic, retain) NSSet *abilities;
@property (nonatomic, retain) NSSet *classes;
@property (nonatomic, retain) NSSet *skills;

- (NSString*)genderDescription;

- (NSArray *)sortedAbilities;
- (PFCharacterAbility *)abilityWithName:(NSString*)aName;
- (PFCharacterAbility *)abilityWithAbbreviation:(NSString*)anAbbreviation;
- (PFCharacterAbility *)abilityWithType:(PFAbilityType)aType;

- (NSArray *)sortedSkills;
- (PFCharacterSkill *)skillWithName:(NSString *)aName;

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
