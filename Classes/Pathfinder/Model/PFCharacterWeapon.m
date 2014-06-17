//
//  PFCharacterWeapon.m
//  CharMgr
//
//  Created by Leif Harrison on 3/17/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import "PFCharacterWeapon.h"
#import "PFCharacter.h"
#import "PFWeapon.h"


@implementation PFCharacterWeapon

@dynamic additionalDescription;
@dynamic properties;
@dynamic character;
@dynamic weapon;

- (NSString *)attackBonusDescription
{
	if ([self.weapon.category isEqualToString:@"Ranged"]) {
		NSString *descriptionString = [NSString stringWithFormat:@"+%ld", (long)[self.character rangedAttackBonusForAttackNumber:1]];
		for (NSInteger attackNumber=2; attackNumber <= [self.character numberOfAttacks]; attackNumber++)
		{
			descriptionString = [descriptionString stringByAppendingFormat:@"/+%ld", (long)[self.character rangedAttackBonusForAttackNumber:attackNumber]];
		}
		return descriptionString;
	}
	else {
		NSString *descriptionString = [NSString stringWithFormat:@"+%ld", (long)[self.character meleeAttackBonusForAttackNumber:1]];
		for (NSInteger attackNumber=2; attackNumber <= [self.character numberOfAttacks]; attackNumber++)
		{
			descriptionString = [descriptionString stringByAppendingFormat:@"/+%ld", (long)[self.character meleeAttackBonusForAttackNumber:attackNumber]];
		}
		return descriptionString;
	}
}


@end
