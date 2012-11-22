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

@dynamic alignment;
@dynamic race;

// Relationships

@dynamic abilities;
@dynamic classes;
@dynamic skills;


//------------------------------------------------------------------------------
#pragma mark - General Methods
//------------------------------------------------------------------------------

- (NSString*)genderDescription;
{
	return NSStringFromPFGenderType(self.gender);
}

- (NSString*)sizeDescription;
{
	return NSStringFromPFSizeType(self.size);
}

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

- (NSInteger)currentXP;
{
	return 0;
}

- (NSInteger)nextLevelXP;
{
	return 0;
}

- (NSInteger)levelAdjustment;
{
	return 0;
}

- (NSInteger)effectiveLevel;
{
	return 0;
}

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
