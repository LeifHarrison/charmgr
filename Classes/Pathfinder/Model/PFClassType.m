//
//  PFClassType.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFClassType.h"

#import "PFCharacterClass.h"
#import "PFClassFeature.h"
#import "PFSkill.h"
#import "PFSource.h"

#import "GDataXMLNode.h"

@implementation PFClassType

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@dynamic name;
@dynamic source;
@dynamic descriptionShort;
@dynamic hitDieType;
@dynamic skillRanksPerLevel;
@dynamic baseAttackBonusType;
@dynamic fortitudeSaveBonusType;
@dynamic reflexSaveBonusType;
@dynamic willSaveBonusType;

@dynamic characterClasses;
@dynamic classSkills;
@dynamic features;

//------------------------------------------------------------------------------
#pragma mark - General
//------------------------------------------------------------------------------

- (NSString*)hitDieTypeDescription;
{
	return [NSString stringWithFormat:@"d%d", self.hitDieType];
}

//------------------------------------------------------------------------------
#pragma mark - Creation
//------------------------------------------------------------------------------

+ (PFClassType *)insertedInstanceWithElement:(GDataXMLElement *)anElement
					  inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFClassType *newInstance = (PFClassType *)[NSEntityDescription insertNewObjectForEntityForName:@"PFClassType" inManagedObjectContext:moc];
	newInstance.name = name;
	
	newInstance.hitDieType = [[[anElement attributeForName:@"hitDieType"] stringValue] intValue];
	newInstance.skillRanksPerLevel = [[[anElement attributeForName:@"skillRanksPerLevel"] stringValue] intValue];
	newInstance.baseAttackBonusType = [[[anElement attributeForName:@"baseAttackBonusType"] stringValue] intValue];
	newInstance.fortitudeSaveBonusType = [[[anElement attributeForName:@"fortitudeSaveBonusType"] stringValue] intValue];
	newInstance.reflexSaveBonusType = [[[anElement attributeForName:@"reflexSaveBonusType"] stringValue] intValue];
	newInstance.willSaveBonusType = [[[anElement attributeForName:@"willSaveBonusType"] stringValue] intValue];

	NSString *sourceAbbreviation = [[anElement attributeForName:@"source"] stringValue];
	newInstance.source = [PFSource fetchWithAbbreviation:sourceAbbreviation inContext:moc];

	NSArray *elements = [anElement elementsForName:@"ShortDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.descriptionShort = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"ClassSkills"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		
		NSArray *skillNames = [[firstElement stringValue] componentsSeparatedByString:@","];
		for (NSString *aName in skillNames) {
			PFSkill *aSkill = [PFSkill fetchSkillWithName:aName inContext:moc];
			[newInstance addClassSkillsObject:aSkill];
		}
	};
	
	GDataXMLElement *featuresArrayElement = nil;
	elements = [anElement elementsForName:@"Features"];
	if (elements.count > 0) {
		featuresArrayElement = [elements objectAtIndex:0];
		
		elements = [featuresArrayElement elementsForName:@"Feature"];
		if (elements.count > 0) {
			for (GDataXMLElement *featureElement in elements) {
				// Fetch existing feature, if there is one
				//NSString *featureName = [[anElement attributeForName:@"name"] stringValue];
				
				PFClassFeature *aFeature = [PFClassFeature insertedInstanceWithElement:featureElement inManagedObjectContext:moc];
				aFeature.classType = newInstance;
			}
		};
	}
	
	//LOG_DEBUG(@"newInstance = %@", newInstance);
	return newInstance;
}

@end
