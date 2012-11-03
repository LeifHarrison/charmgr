//
//  PFClassType.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFClassType.h"
#import "PFCharacterClass.h"
#import "PFSkill.h"

#import "GDataXMLNode.h"

@implementation PFClassType

@dynamic name;
@dynamic source;
@dynamic descriptionShort;
@dynamic hitDieType;
@dynamic skillRanks;

@dynamic characterClasses;
@dynamic classSkills;

- (NSString*)hitDieTypeDescription;
{
	return [NSString stringWithFormat:@"d%d", self.hitDieType];
}

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
	newInstance.skillRanks = [[[anElement attributeForName:@"skillRanksPerLevel"] stringValue] intValue];
	newInstance.source = [[anElement attributeForName:@"source"] stringValue];
	
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
	
	//LOG_DEBUG(@"newInstance = %@", newInstance);
	return newInstance;
}


@end
