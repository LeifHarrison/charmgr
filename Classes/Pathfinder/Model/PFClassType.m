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

// Attributes

@dynamic name;
@dynamic source;
@dynamic descriptionShort;
@dynamic hitDieType;
@dynamic skillRanksPerLevel;
@dynamic baseAttackBonusType;
@dynamic fortitudeSaveBonusType;
@dynamic reflexSaveBonusType;
@dynamic willSaveBonusType;

// Relationships

@dynamic characterClasses;
@dynamic classSkills;
@dynamic features;

//------------------------------------------------------------------------------
#pragma mark - Creating/Updating
//------------------------------------------------------------------------------

+ (PFClassType *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
						  inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) return nil;

	PFClassType *instance = [self fetchWithName:name inContext:moc];
	if (!instance) {
		instance = (PFClassType *)[NSEntityDescription insertNewObjectForEntityForName:@"PFClassType" inManagedObjectContext:moc];
		instance.name = name;
	}

	instance.hitDieType = [[[anElement attributeForName:@"hitDieType"] stringValue] intValue];
	instance.skillRanksPerLevel = [[[anElement attributeForName:@"skillRanksPerLevel"] stringValue] intValue];
	instance.baseAttackBonusType = [[[anElement attributeForName:@"baseAttackBonusType"] stringValue] intValue];
	instance.fortitudeSaveBonusType = [[[anElement attributeForName:@"fortitudeSaveBonusType"] stringValue] intValue];
	instance.reflexSaveBonusType = [[[anElement attributeForName:@"reflexSaveBonusType"] stringValue] intValue];
	instance.willSaveBonusType = [[[anElement attributeForName:@"willSaveBonusType"] stringValue] intValue];

	NSString *sourceAbbreviation = [[anElement attributeForName:@"source"] stringValue];
	instance.source = [PFSource fetchWithAbbreviation:sourceAbbreviation inContext:moc];

	NSArray *elements = [anElement elementsForName:@"ShortDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.descriptionShort = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"ClassSkills"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		
		NSArray *skillNames = [[firstElement stringValue] componentsSeparatedByString:@","];
		for (NSString *aName in skillNames) {
			PFSkill *aSkill = [PFSkill fetchWithName:aName inContext:moc];
			[instance addClassSkillsObject:aSkill];
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
				
				PFClassFeature *aFeature = [PFClassFeature newOrUpdatedInstanceForClassType:instance withElement:featureElement inManagedObjectContext:moc];
				aFeature.classType = instance;
			}
		};
	}
	
	//LOG_DEBUG(@"instance = %@", instance);
	return instance;
}

//------------------------------------------------------------------------------
#pragma mark - Fetching
//------------------------------------------------------------------------------

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFClassType" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];

	// Set sort orderings...
	NSSortDescriptor *typeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	request.sortDescriptors = [NSArray arrayWithObject:typeSortDescriptor];

	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching classes!");
	}

	return array;
}

+ (PFClassType *)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFClassType" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];

	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name like[cd] %@", aName];
	[request setPredicate:predicate];

	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching class with name '%@'!", aName);
	}

	if (array.count > 0)
		return [array objectAtIndex:0];

	return nil;
}

//------------------------------------------------------------------------------
#pragma mark - General
//------------------------------------------------------------------------------

- (NSString*)hitDieTypeDescription;
{
	return [NSString stringWithFormat:@"d%d", self.hitDieType];
}

@end
