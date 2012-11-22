//
//  PFRace.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFRace.h"

#import "PFCharacter.h"
#import "PFTrait.h"

#import "GDataXMLNode.h"

@implementation PFRace

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

// Attributes

@dynamic name;
@dynamic descriptionShort;
@dynamic descriptionLong;
@dynamic physicalDescription;
@dynamic society;
@dynamic relations;
@dynamic alignmentAndReligion;
@dynamic adventurers;
@dynamic namesFemale;
@dynamic namesMale;
@dynamic size;
@dynamic source;
@dynamic speed;
@dynamic subtype;
@dynamic type;

// Relationships

@dynamic characters;
@dynamic traits;

//------------------------------------------------------------------------------
#pragma mark - Creation
//------------------------------------------------------------------------------

+ (PFRace *)insertedInstanceWithElement:(GDataXMLElement *)anElement
				 inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFRace *newInstance = (PFRace *)[NSEntityDescription insertNewObjectForEntityForName:@"PFRace" inManagedObjectContext:moc];
	newInstance.name = name;
	
	newInstance.source = [[anElement attributeForName:@"source"] stringValue];
	newInstance.size = PFSizeTypeFromString([[anElement attributeForName:@"size"] stringValue]);
	newInstance.type = [[anElement attributeForName:@"type"] stringValue];
	newInstance.subtype = [[anElement attributeForName:@"subtype"] stringValue];
	newInstance.speed = [[[anElement attributeForName:@"speed"] stringValue] intValue];

	NSArray *elements = nil;
	
	elements = [anElement elementsForName:@"ShortDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.descriptionShort = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"LongDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.descriptionLong = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"PhysicalDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.physicalDescription = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"Society"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.society = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"Relations"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.relations = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"AlignmentAndReligion"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.alignmentAndReligion = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"Adventurers"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.adventurers = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"FemaleNames"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.namesFemale = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"MaleNames"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.namesMale = firstElement.stringValue;
	};
	
	GDataXMLElement *traitsArrayElement = nil;
	elements = [anElement elementsForName:@"Traits"];
	if (elements.count > 0) {
		traitsArrayElement = [elements objectAtIndex:0];

		elements = [traitsArrayElement elementsForName:@"Trait"];
		if (elements.count > 0) {
			for (GDataXMLElement *traitElement in elements) {
				// Fetch existing trait, if there is one
				//NSString *traitName = [[anElement attributeForName:@"name"] stringValue];
				
				PFTrait *aTrait = [PFTrait insertedInstanceWithElement:traitElement inManagedObjectContext:moc];
				aTrait.source = newInstance.source;
				aTrait.race = newInstance;
			}
		};
	}
		
	//LOG_DEBUG(@"newInstance = %@", newInstance);
	return newInstance;
}

@end
