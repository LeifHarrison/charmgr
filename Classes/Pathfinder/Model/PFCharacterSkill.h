//
//  PFCharacterSkill.h
//  CharMgr
//
//  Created by Leif Harrison on 10/19/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PFCharacter, PFSkill;

@interface PFCharacterSkill : NSManagedObject

@property (nonatomic, assign) int16_t ranks;
@property (nonatomic, assign) int16_t miscellaneousModifier;
@property (nonatomic) BOOL isClassSkill;

@property (nonatomic, retain) PFCharacter *character;
@property (nonatomic, retain) PFSkill *skill;

@property (nonatomic, readonly) int16_t abilityBonus;
@property (nonatomic, readonly) int16_t classBonus;
@property (nonatomic, readonly) int16_t featBonus;
@property (nonatomic, readonly) int16_t traitBonus;
@property (nonatomic, readonly) int16_t armorCheckPenalty;

@property (nonatomic, readonly) int16_t totalSkillBonus;

- (NSString *)skillName;
- (NSString *)keyAbilityAbbreviation;
- (NSString *)skillBonusString;

@end
