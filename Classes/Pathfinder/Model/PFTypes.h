//
//  PFTypes.h
//  CharMgr
//
//  Created by Leif Harrison on 10/15/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#ifndef CharMgr_PFTypes_h
#define CharMgr_PFTypes_h

typedef enum {
	kPFGenderTypeMale,
	kPFGenderTypeFemale,
	kPFGenderTypeOther
} PFGenderType;

typedef enum {
	kPFAbilityTypeStrength,
	kPFAbilityTypeDexterity,
	kPFAbilityTypeConstitution,
	kPFAbilityTypeIntelligence,
	kPFAbilityTypeWisdom,
	kPFAbilityTypeCharisma
} PFAbilityType;

typedef enum {
	kPFAlignmentTypeLawfulGood,
	kPFAlignmentTypeNeutralGood,
	kPFAlignmentTypeChaoticGood,
	kPFAlignmentTypeLawfulNeutral,
	kPFAlignmentTypeNeutral,
	kPFAlignmentTypeChaoticNeutral,
	kPFAlignmentTypeLawfulEvil,
	kPFAlignmentTypeNeutralEvil,
	kPFAlignmentTypeChaoticEvil,
} PFAlignmentType;

typedef enum {
	kPFSizeTypeFine,
	kPFSizeTypeDiminutive,
	kPFSizeTypeTiny,
	kPFSizeTypeSmall,
	kPFSizeTypeMedium,
	kPFSizeTypeLarge,
	kPFSizeTypeHuge,
	kPFSizeTypeColossal,
	kPFSizeTypeGargantuan
} PFSizeType;

typedef enum {
	kPFSpecialAbilityTypeNone,
	kPFSpecialAbilityTypeExtraordinary,
	kPFSpecialAbilityTypeSpellLike,
	kPFSpecialAbilityTypeSupernatural
} PFSpecialAbilityType;

typedef enum {
	kPFBaseAttackBonusTypeLow,		// bonus = 1/2 level
	kPFBaseAttackBonusTypeMedium,	// bonus = 3/4 level
	kPFBaseAttackBonusTypeHigh,		// bonus = level
} PFBaseAttackBonusType;

typedef enum {
	kPFSavingThrowBonusTypeLow,	// bonus = 1/3 level
	kPFSavingThrowBonusTypeHigh,	// bonus = 2 + 1/2 level
} PFSavingThrowBonusType;


// Alignment and Ability have their own classes, so no need for mapping
// functions

extern NSString *NSStringFromPFGenderType(PFGenderType genderType);
extern PFGenderType PFGenderTypeFromString(NSString *aString);

extern NSString *NSStringFromPFSizeType(PFSizeType sizeType);
extern PFSizeType PFSizeTypeFromString(NSString *aString);

extern NSString *NSStringFromPFSpecialAbilityType(PFSpecialAbilityType specialAbilityType);
extern PFSpecialAbilityType PFSpecialAbilityTypeFromString(NSString *aString);

#endif
