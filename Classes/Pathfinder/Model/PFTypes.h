//
//  PFTypes.h
//  CharMgr
//
//  Created by Leif Harrison on 10/15/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#ifndef CharMgr_PFTypes_h
#define CharMgr_PFTypes_h

typedef NS_ENUM (int16_t, PFGenderType) {
	kPFGenderTypeMale,
	kPFGenderTypeFemale,
	kPFGenderTypeOther
};

typedef NS_ENUM (int16_t, PFAbilityType) {
	kPFAbilityTypeStrength,
	kPFAbilityTypeDexterity,
	kPFAbilityTypeConstitution,
	kPFAbilityTypeIntelligence,
	kPFAbilityTypeWisdom,
	kPFAbilityTypeCharisma
};

typedef NS_ENUM (int16_t, PFAlignmentType) {
	kPFAlignmentTypeLawfulGood,
	kPFAlignmentTypeNeutralGood,
	kPFAlignmentTypeChaoticGood,
	kPFAlignmentTypeLawfulNeutral,
	kPFAlignmentTypeNeutral,
	kPFAlignmentTypeChaoticNeutral,
	kPFAlignmentTypeLawfulEvil,
	kPFAlignmentTypeNeutralEvil,
	kPFAlignmentTypeChaoticEvil,
};

typedef NS_ENUM (int16_t, PFSizeType) {
	kPFSizeTypeFine,
	kPFSizeTypeDiminutive,
	kPFSizeTypeTiny,
	kPFSizeTypeSmall,
	kPFSizeTypeMedium,
	kPFSizeTypeLarge,
	kPFSizeTypeHuge,
	kPFSizeTypeColossal,
	kPFSizeTypeGargantuan
};

typedef NS_ENUM (int16_t, PFSpecialAbilityType) {
	kPFSpecialAbilityTypeNone,
	kPFSpecialAbilityTypeExtraordinary,
	kPFSpecialAbilityTypeSpellLike,
	kPFSpecialAbilityTypeSupernatural
};

typedef NS_ENUM (int16_t, PFBaseAttackBonusType)  {
	kPFBaseAttackBonusTypeLow,		// bonus = 1/2 level
	kPFBaseAttackBonusTypeMedium,	// bonus = 3/4 level
	kPFBaseAttackBonusTypeHigh,		// bonus = level
};

typedef NS_ENUM (int16_t, PFSavingThrowBonusType) {
	kPFSavingThrowBonusTypeLow,	    // bonus = 1/3 level
	kPFSavingThrowBonusTypeHigh,	// bonus = 2 + 1/2 level
};


// Alignment and Ability have their own classes, so no need for mapping
// functions

extern NSString *NSStringFromPFGenderType(PFGenderType genderType);
extern PFGenderType PFGenderTypeFromString(NSString *aString);

extern NSString *NSStringFromPFSizeType(PFSizeType sizeType);
extern PFSizeType PFSizeTypeFromString(NSString *aString);

extern NSString *NSStringFromPFSpecialAbilityType(PFSpecialAbilityType specialAbilityType);
extern PFSpecialAbilityType PFSpecialAbilityTypeFromString(NSString *aString);

#endif
