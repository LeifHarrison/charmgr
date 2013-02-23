//
//  PFCharacterClass.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFCharacterClass.h"

#import "PFCharacter.h"
#import "PFClassType.h"

@implementation PFCharacterClass

@dynamic level;
@dynamic character;
@dynamic classType;

- (NSString *)classSummaryDescription;
{
	return [NSString stringWithFormat:@"%@ %d", self.classType.name, self.level];
}

@end
