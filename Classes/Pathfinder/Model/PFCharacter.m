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
	return [self fortitudeBaseBonus] + [self fortitudeAbilityBonus] + [self fortitudeRacialBonus] + self.fortitudeMiscBonus;
}

- (NSInteger)fortitudeBaseBonus;
{
	return 0;
}

- (NSInteger)fortitudeAbilityBonus;
{
	return [[[self abilityWithType:kPFAbilityTypeConstitution] abilityBonus] integerValue];
}

- (NSInteger)fortitudeRacialBonus;
{
	return 0;
}


- (NSInteger)reflexBonus;
{
	return [self reflexBaseBonus] + [self reflexAbilityBonus] + [self reflexRacialBonus] + self.reflexMiscBonus;
}

- (NSInteger)reflexBaseBonus;
{
	return 0;
}

- (NSInteger)reflexAbilityBonus;
{
	return [[[self abilityWithType:kPFAbilityTypeDexterity] abilityBonus] integerValue];
}

- (NSInteger)reflexRacialBonus;
{
	return 0;
}


- (NSInteger)willBonus;
{
	return [self willBaseBonus] + [self willAbilityBonus] + [self willRacialBonus] + self.willMiscBonus;
}

- (NSInteger)willBaseBonus;
{
	return 0;
}

- (NSInteger)willAbilityBonus;
{
	return [[[self abilityWithType:kPFAbilityTypeWisdom] abilityBonus] integerValue];
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
	return 0;
}

- (NSInteger)initiativeAbilityBonus;
{
	return 0;
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
#pragma mark - Armor Class
//------------------------------------------------------------------------------

- (NSInteger)armorClass;
{
	return 0;
}

- (NSInteger)armorClassAbilityModifier;
{
	return 0;
}

- (NSInteger)armorClassDodgeModifier;
{
	return 0;
}

- (NSInteger)armorClassDeflectionModifier;
{
	return 0;
}

- (NSInteger)armorClassArmorModifier;
{
	return 0;
}

- (NSInteger)armorClassShieldModifier;
{
	return 0;
}

- (NSInteger)armorClassNaturalArmorModifier;
{
	return 0;
}

- (NSInteger)armorClassSizeModifier;
{
	return 0;
}


- (NSInteger)flatFootedArmorClass;
{
	return 0;
}

- (NSInteger)touchArmorClass;
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
