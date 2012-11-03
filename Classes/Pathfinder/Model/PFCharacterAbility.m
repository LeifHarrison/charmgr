//
//  PFCharacterAbility.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFCharacterAbility.h"

#import "PFAbility.h"

@implementation PFCharacterAbility

@dynamic abilityScore;
@dynamic temporaryScore;

@dynamic character;
@dynamic ability;

- (PFAbilityType)abilityType;
{
	return (PFAbilityType)self.ability.abilityType;
}

- (NSNumber*)abilityBonus;
{
	return [NSNumber numberWithInt:((self.abilityScore.intValue - 10) / 2)];
}

- (NSNumber*)temporaryBonus;
{
	return [NSNumber numberWithInt:((self.temporaryScore.intValue - 10) / 2)];
}

@end
