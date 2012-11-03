//
//  PFCharacterSkill.m
//  CharMgr
//
//  Created by Leif Harrison on 10/19/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFCharacterSkill.h"

#import "PFAbility.h"
#import "PFCharacter.h"
#import "PFCharacterAbility.h"
#import "PFSkill.h"


@implementation PFCharacterSkill

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

// Attributes

@dynamic ranks;
@dynamic miscellaneousModifier;
@dynamic isClassSkill;

// Relationships

@dynamic character;
@dynamic skill;

//------------------------------------------------------------------------------
#pragma mark - General
//------------------------------------------------------------------------------

- (NSString *)skillName;
{
	return self.skill.name;
}

- (int16_t)abilityBonus;
{
	return [[[self.character abilityWithAbbreviation:self.skill.keyAbility] abilityBonus] intValue];
}

- (int16_t)classBonus;
{
	return self.isClassSkill ? 3 : 0;
}

- (int16_t)featBonus;
{
	// Calculate bonus from applicable feats
	return 0;
}

- (int16_t)traitBonus;
{
	// Calculate bonus from applicable traits
	return 0;
}

- (int16_t)equipmentBonus;
{
	// Calculate bonus from magic items
	return 0;
}

- (int16_t)armorCheckPenalty;
{
	if (self.skill.armorCheckPenalty) {
		// Calculate armor check penalty
		return 0;
	}
	else {
		return 0;
	}
}

- (int16_t)totalSkillBonus;
{
	return self.ranks + self.abilityBonus + self.classBonus + self.featBonus + self.traitBonus + self.armorCheckPenalty + self.miscellaneousModifier;
}

- (NSString *)keyAbilityAbbreviation
{
	return self.skill.keyAbility;
}

- (NSString *)skillBonusString
{
	if (!self.skill.untrained && (self.ranks < 1))
		return @"-";
	else
		return [NSString stringWithFormat:@"%d", self.totalSkillBonus];
}

@end
