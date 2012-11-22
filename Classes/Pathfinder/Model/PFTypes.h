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

// Alignment and Ability have their own classes, so no need for mapping
// functions

extern NSString *NSStringFromPFGenderType(PFGenderType genderType);
extern PFGenderType PFGenderTypeFromString(NSString *aString);

extern NSString *NSStringFromPFSizeType(PFSizeType sizeType);
extern PFSizeType PFSizeTypeFromString(NSString *aString);

#endif
