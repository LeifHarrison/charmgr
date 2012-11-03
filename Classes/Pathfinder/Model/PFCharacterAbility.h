//
//  PFCharacterAbility.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class PFAbility;
@class PFCharacter;

@interface PFCharacterAbility : NSManagedObject

@property (nonatomic) NSNumber* abilityScore;
@property (nonatomic) NSNumber* temporaryScore;

@property (nonatomic, retain) PFCharacter *character;
@property (nonatomic, retain) PFAbility *ability;

@property (nonatomic, readonly) NSNumber* abilityBonus;
@property (nonatomic, readonly) NSNumber* temporaryBonus;

- (PFAbilityType)abilityType;

@end
