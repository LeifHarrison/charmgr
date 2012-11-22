//
//  PFTypes.m
//  CharMgr
//
//  Created by Leif Harrison on 11/21/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFTypes.h"

static NSString const * kPFGenderTypeMaleString = @"Male";
static NSString const * kPFGenderTypeFemaleString = @"Female";
static NSString const * kPFGenderTypeOtherString = @"Other";

NSString *NSStringFromPFGenderType(PFGenderType genderType)
{
	switch (genderType) {
		case kPFGenderTypeMale :
			return (NSString *)kPFGenderTypeMaleString;
		case kPFGenderTypeFemale :
			return (NSString *)kPFGenderTypeFemaleString;
		default :
			return (NSString *)kPFGenderTypeOtherString;
	}
}

PFGenderType PFGenderTypeFromString(NSString *aString)
{
	if ([kPFGenderTypeMaleString isEqual:aString])
		return kPFGenderTypeMale;
	else if ([kPFGenderTypeFemaleString isEqual:aString])
		return kPFGenderTypeFemale;
	else
		return kPFGenderTypeOther;
}

static NSString const * kPFSizeTypeFineString = @"Fine";
static NSString const * kPFSizeTypeDiminutiveString = @"Diminutive";
static NSString const * kPFSizeTypeTinyString = @"Tiny";
static NSString const * kPFSizeTypeSmallString = @"Small";
static NSString const * kPFSizeTypeMediumString = @"Medium";
static NSString const * kPFSizeTypeLargeString = @"Large";
static NSString const * kPFSizeTypeHugeString = @"Huge";
static NSString const * kPFSizeTypeColossalString = @"Colossal";
static NSString const * kPFSizeTypeGargantuanString = @"Gargantuan";

NSString *NSStringFromPFSizeType(PFSizeType sizeType)
{
	switch (sizeType) {
		case kPFSizeTypeFine :
			return (NSString *)kPFSizeTypeFineString;
		case kPFSizeTypeDiminutive :
			return (NSString *)kPFSizeTypeDiminutiveString;
		case kPFSizeTypeTiny :
			return (NSString *)kPFSizeTypeTinyString;
		case kPFSizeTypeSmall :
			return (NSString *)kPFSizeTypeSmallString;
		case kPFSizeTypeMedium :
			return (NSString *)kPFSizeTypeMediumString;
		case kPFSizeTypeLarge :
			return (NSString *)kPFSizeTypeLargeString;
		case kPFSizeTypeHuge :
			return (NSString *)kPFSizeTypeHugeString;
		case kPFSizeTypeColossal :
			return (NSString *)kPFSizeTypeColossalString;
		case kPFSizeTypeGargantuan :
			return (NSString *)kPFSizeTypeGargantuanString;
		default :
			return (NSString *)kPFSizeTypeMediumString;
	}
}

PFSizeType PFSizeTypeFromString(NSString *aString)
{
	if ([kPFSizeTypeFineString isEqual:aString])
		return kPFSizeTypeFine;
	else if ([kPFSizeTypeDiminutiveString isEqual:aString])
		return kPFSizeTypeDiminutive;
	else if ([kPFSizeTypeTinyString isEqual:aString])
		return kPFSizeTypeTiny;
	else if ([kPFSizeTypeSmallString isEqual:aString])
		return kPFSizeTypeSmall;
	else if ([kPFSizeTypeMediumString isEqual:aString])
		return kPFSizeTypeMedium;
	else if ([kPFSizeTypeLargeString isEqual:aString])
		return kPFSizeTypeLarge;
	else if ([kPFSizeTypeHugeString isEqual:aString])
		return kPFSizeTypeHuge;
	else if ([kPFSizeTypeColossalString isEqual:aString])
		return kPFSizeTypeColossal;
	else if ([kPFSizeTypeGargantuanString isEqual:aString])
		return kPFSizeTypeGargantuan;
	else
		return kPFSizeTypeMedium;
}
