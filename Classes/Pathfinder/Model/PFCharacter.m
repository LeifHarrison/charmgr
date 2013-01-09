//
//  PFCharacter.m
//  CharMgr
//
//  Created by Leif Harrison on 9/7/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFCharacter.h"

#import "PFTypes.h"

#import "PFAbility.h"
#import "PFCharacterAbility.h"
#import "PFCharacterClass.h"
#import "PFCharacterSkill.h"
#import "PFClassType.h"
#import "PFRace.h"
#import "PFSkill.h"


@implementation PFCharacter

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

// Attributes

@dynamic name;
@dynamic player;
@dynamic campaign;

@dynamic gender;
@dynamic size;

@dynamic experiencePoints;
@dynamic hitPoints;
@dynamic wounds;
@dynamic nonLethalWounds;
@dynamic fortitudeMiscBonus;
@dynamic reflexMiscBonus;
@dynamic willMiscBonus;
@dynamic initiativeMiscBonus;

@dynamic alignment;
@dynamic race;

// Relationships

@dynamic abilities;
@dynamic classes;
@dynamic skills;


//------------------------------------------------------------------------------
#pragma mark - Physical Description
//------------------------------------------------------------------------------

- (NSString*)genderDescription;
{
	return NSStringFromPFGenderType(self.gender);
}

- (NSString*)sizeDescription;
{
	return NSStringFromPFSizeType(self.size);
}

- (NSInteger)sizeModifier
{
	switch (self.size) {
		case kPFSizeTypeFine :
			return 8;
		case kPFSizeTypeDiminutive :
			return 4;
		case kPFSizeTypeTiny :
			return 2;
		case kPFSizeTypeSmall :
			return 1;
		case kPFSizeTypeMedium :
			return 0;
		case kPFSizeTypeLarge :
			return -1;
		case kPFSizeTypeHuge :
			return -2;
		case kPFSizeTypeColossal :
			return -4;
		case kPFSizeTypeGargantuan :
			return -8;
		default :
			return 0;
	}
}

//------------------------------------------------------------------------------
#pragma mark - Abilities
//------------------------------------------------------------------------------

- (NSArray *)sortedAbilities;
{
	NSSortDescriptor *abilityTypeSort = [NSSortDescriptor sortDescriptorWithKey:@"abilityType" ascending:YES];
	return [self.abilities.allObjects sortedArrayUsingDescriptors:@[abilityTypeSort]];
}

- (PFCharacterAbility *)abilityWithName:(NSString*)aName;
{
	for (PFCharacterAbility *anAbility in self.abilities.allObjects) {
		if ([anAbility.ability.name isEqualToString:aName])
			return anAbility;
	}
	return nil;
}

- (PFCharacterAbility *)abilityWithAbbreviation:(NSString*)anAbbreviation;
{
	for (PFCharacterAbility *anAbility in self.abilities.allObjects) {
		if ([anAbility.ability.abbreviation isEqualToString:anAbbreviation])
			return anAbility;
	}
	return nil;
}
- (PFCharacterAbility *)abilityWithType:(PFAbilityType)aType;
{
	for (PFCharacterAbility *anAbility in self.abilities.allObjects) {
		if (anAbility.ability.abilityType == aType)
			return anAbility;
	}
	return nil;
}

- (NSInteger)strengthBonus;
{
	return [[[self abilityWithType:kPFAbilityTypeStrength] abilityBonus] integerValue];
}

- (NSInteger)dexterityBonus;
{
	return [[[self abilityWithType:kPFAbilityTypeDexterity] abilityBonus] integerValue];
}

- (NSInteger)constitutionBonus;
{
	return [[[self abilityWithType:kPFAbilityTypeConstitution] abilityBonus] integerValue];
}

- (NSInteger)intelligenceBonus;
{
	return [[[self abilityWithType:kPFAbilityTypeIntelligence] abilityBonus] integerValue];
}

- (NSInteger)wisdomBonus;
{
	return [[[self abilityWithType:kPFAbilityTypeWisdom] abilityBonus] integerValue];
}

- (NSInteger)charismaBonus;
{
	return [[[self abilityWithType:kPFAbilityTypeCharisma] abilityBonus] integerValue];
}

//------------------------------------------------------------------------------
#pragma mark - Experience/Level
//------------------------------------------------------------------------------

- (NSInteger)xpForLevel:(NSInteger)level
{
	if (level < 2)
		return 0;
	if (level == 2)
		return 2000;
	else if (level == 3)
		return 5000;
	else
		return [self xpForLevel:level-1] + ( 2 * ([self xpForLevel:level-2] - [self xpForLevel:level-3]) );
}

- (NSInteger)roundIntegerValue:(NSInteger)value toNearest:(NSInteger)roundToNearest
{
	NSInteger result = value;
	
	if ((result % roundToNearest) >= (roundToNearest/2))
		result = result + (roundToNearest - (result % roundToNearest));
	else
		result = result - (result % roundToNearest);
	
	return result;
}

- (NSInteger)nextLevelXP;
{
	NSInteger nextLevel = self.effectiveLevel+1;
	NSInteger xpForLevel = [self xpForLevel:nextLevel];
	LOG_DEBUG(@"xpForLevel = %d", xpForLevel);
	
	if (nextLevel > 16) {
		xpForLevel = [self roundIntegerValue:xpForLevel toNearest:50000];
	}
	else if (nextLevel > 9) {
		xpForLevel = [self roundIntegerValue:xpForLevel toNearest:5000];
	}

	return xpForLevel;
}

- (NSInteger)levelAdjustment;
{
	return 0;
}

- (NSInteger)effectiveLevel;
{
	NSInteger level = self.levelAdjustment;
	for (PFCharacterClass *aClass in self.classes) {
		level += aClass.level;
	}
	return level;
}

//------------------------------------------------------------------------------
#pragma mark - Saving Throws
//------------------------------------------------------------------------------

- (NSInteger)fortitudeBonus;
{
	return [self fortitudeBaseBonus] + [self constitutionBonus] + [self fortitudeRacialBonus] + self.fortitudeMiscBonus;
}

- (NSInteger)fortitudeBaseBonus;
{
	NSInteger bonus = 0;
	for (PFCharacterClass *aClass in self.classes) {
		switch (aClass.classType.fortitudeSaveBonusType) {
			case kPFSavingThrowBonusTypeLow :
				bonus += (NSInteger)((double)aClass.level * 0.5);
				break;
			case kPFSavingThrowBonusTypeHigh:
				bonus += 2 + (NSInteger)((double)aClass.level * 0.75);
				break;
			default:
				break;
		}
	}
	return bonus;
}

- (NSInteger)fortitudeRacialBonus;
{
	return 0;
}


- (NSInteger)reflexBonus;
{
	return [self reflexBaseBonus] + [self dexterityBonus] + [self reflexRacialBonus] + self.reflexMiscBonus;
}

- (NSInteger)reflexBaseBonus;
{
	NSInteger bonus = 0;
	for (PFCharacterClass *aClass in self.classes) {
		switch (aClass.classType.reflexSaveBonusType) {
			case kPFSavingThrowBonusTypeLow :
				bonus += (NSInteger)((double)aClass.level * 0.5);
				break;
			case kPFSavingThrowBonusTypeHigh:
				bonus += 2 + (NSInteger)((double)aClass.level * 0.75);
				break;
			default:
				break;
		}
	}
	return bonus;
}

- (NSInteger)reflexRacialBonus;
{
	return 0;
}


- (NSInteger)willBonus;
{
	return [self willBaseBonus] + [self wisdomBonus] + [self willRacialBonus] + self.willMiscBonus;
}

- (NSInteger)willBaseBonus;
{
	NSInteger bonus = 0;
	for (PFCharacterClass *aClass in self.classes) {
		switch (aClass.classType.willSaveBonusType) {
			case kPFSavingThrowBonusTypeLow :
				bonus += (NSInteger)((double)aClass.level * 0.5);
				break;
			case kPFSavingThrowBonusTypeHigh:
				bonus += 2 + (NSInteger)((double)aClass.level * 0.75);
				break;
			default:
				break;
		}
	}
	return bonus;
}

- (NSInteger)willRacialBonus;
{
	return 0;
}


//------------------------------------------------------------------------------
#pragma mark - Initiative
//------------------------------------------------------------------------------

- (NSInteger)initiativeBonus;
{
	return [self dexterityBonus] + [self initiativeFeatBonus] + [self initiativeTrainingBonus] + self.initiativeMiscBonus;
}

- (NSInteger)initiativeFeatBonus;
{
	return 0;
}

- (NSInteger)initiativeTrainingBonus;
{
	return 0;
}

//------------------------------------------------------------------------------
#pragma mark - Base Attack Bonus
//------------------------------------------------------------------------------

- (NSInteger)numberOfAttacks
{
	return 1 + (([self baseAttackBonusForAttackNumber:1] - 1) / 5);
}

- (NSInteger)baseAttackBonus;
{
	return [self baseAttackBonusForAttackNumber:1];
}

- (NSInteger)meleeAttackBonus;
{
	return [self meleeAttackBonusForAttackNumber:1];
}

- (NSInteger)rangedAttackBonus;
{
	return [self rangedAttackBonusForAttackNumber:1];
}

- (NSInteger)baseAttackBonusForAttackNumber:(NSInteger)attackNumber
{
	NSInteger baseAttack = 0;
	for (PFCharacterClass *aClass in self.classes) {
		NSInteger classBonus = 0;
		NSInteger attackModifier = 5 * (attackNumber - 1);
		switch (aClass.classType.baseAttackBonusType) {
			case kPFBaseAttackBonusTypeLow :
				classBonus = ((NSInteger)((double)aClass.level * 0.5)) - attackModifier;
				break;
			case kPFBaseAttackBonusTypeMedium :
				classBonus = ((NSInteger)((double)aClass.level * 0.75)) - attackModifier;
				break;
			case kPFBaseAttackBonusTypeHigh :
				classBonus = aClass.level - attackModifier;
				break;
			default:
				break;
		}
		if (classBonus > 0) baseAttack += classBonus;
	}
	
	return baseAttack;
}

- (NSInteger)meleeAttackBonusForAttackNumber:(NSInteger)attackNumber
{
	return [self baseAttackBonusForAttackNumber:attackNumber] + [self strengthBonus];
}

- (NSInteger)rangedAttackBonusForAttackNumber:(NSInteger)attackNumber
{
	return [self baseAttackBonusForAttackNumber:attackNumber] + [self dexterityBonus];
}

- (NSString *)baseAttackBonusDescription
{
	NSString *descriptionString = [NSString stringWithFormat:@"+%d", [self baseAttackBonusForAttackNumber:1]];
	for (NSInteger attackNumber=2; attackNumber <= [self numberOfAttacks]; attackNumber++)
	{
		descriptionString = [descriptionString stringByAppendingFormat:@"/+%d", [self baseAttackBonusForAttackNumber:attackNumber]];
	}
	return descriptionString;
}

- (NSString *)meleeAttackBonusDescription
{
	NSString *descriptionString = [NSString stringWithFormat:@"+%d", [self meleeAttackBonusForAttackNumber:1]];
	for (NSInteger attackNumber=2; attackNumber <= [self numberOfAttacks]; attackNumber++)
	{
		descriptionString = [descriptionString stringByAppendingFormat:@"/+%d", [self meleeAttackBonusForAttackNumber:attackNumber]];
	}
	return descriptionString;
}

- (NSString *)rangedAttackBonusDescription
{
	NSString *descriptionString = [NSString stringWithFormat:@"+%d", [self rangedAttackBonusForAttackNumber:1]];
	for (NSInteger attackNumber=2; attackNumber <= [self numberOfAttacks]; attackNumber++)
	{
		descriptionString = [descriptionString stringByAppendingFormat:@"/+%d", [self rangedAttackBonusForAttackNumber:attackNumber]];
	}
	return descriptionString;
}

//------------------------------------------------------------------------------
#pragma mark - Combat Manuevers (CMB/CMD)
//------------------------------------------------------------------------------

- (NSInteger)combatManueverBonus;
{
	return [self strengthBonus] + [self baseAttackBonusForAttackNumber:1] - [self sizeModifier]; // + self.cmbMiscModifier
}

- (NSInteger)combatManueverDefence;
{
	return 10 + [self strengthBonus] + [self dexterityBonus] + [self dodgeBonus] + [self deflectionBonus] + [self baseAttackBonusForAttackNumber:1] - [self sizeModifier]; // + self.cmdMiscModifier
}

- (NSInteger)flatFootedCMD;
{
	return 10 + [self strengthBonus] + [self deflectionBonus] + [self baseAttackBonusForAttackNumber:1] - [self sizeModifier]; // + self.cmdMiscModifier
}

//------------------------------------------------------------------------------
#pragma mark - Armor Class
//------------------------------------------------------------------------------

- (NSInteger)armorClass;
{
	return 10 + [self armorBonus] + [self shieldBonus] + [self dexterityBonus] + [self enhancementBonus] + [self deflectionBonus] + [self naturalArmorBonus] + [self dodgeBonus] + [self sizeModifier];
}

- (NSInteger)flatFootedArmorClass;
{
	return 10 + [self armorBonus] + [self shieldBonus] + [self enhancementBonus] + [self deflectionBonus] + [self naturalArmorBonus] + [self sizeModifier];
}

- (NSInteger)touchArmorClass;
{
	return 10 + [self dexterityBonus] + [self dodgeBonus] + [self deflectionBonus] + [self sizeModifier];
}

- (NSInteger)armorBonus;
{
	return 0;
}

- (NSInteger)shieldBonus;
{
	return 0;
}

- (NSInteger)enhancementBonus;
{
	return 0;
}

- (NSInteger)dodgeBonus;
{
	return 0;
}

- (NSInteger)deflectionBonus;
{
	return 0;
}

- (NSInteger)naturalArmorBonus;
{
	return 0;
}

//------------------------------------------------------------------------------
#pragma mark - Skills
//------------------------------------------------------------------------------

- (NSArray *)sortedSkills;
{
	NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"skillName" ascending:YES];
	return [self.skills.allObjects sortedArrayUsingDescriptors:@[nameSort]];
}

- (PFCharacterSkill *)skillWithName:(NSString *)aName;
{
	for (PFCharacterSkill *aSkill in self.skills) {
		if ([aSkill.skill.name isEqualToString:aName])
			return aSkill;
	}
	return nil;
}

//------------------------------------------------------------------------------
#pragma mark - Fetching
//------------------------------------------------------------------------------

+ (PFCharacter*)fetchCharacterWithName:(NSString *)aName context:(NSManagedObjectContext*)moc
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFCharacter"
														 inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name = %@", aName];
	[request setPredicate:predicate];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (array == nil)
	{
		// Deal with error...
	}
	else if (array.count > 0) {
		return [array objectAtIndex:0];
	}
	
	return nil;
}

@end
