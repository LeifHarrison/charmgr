//
//  PFRace.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFRace.h"

#import "PFCharacter.h"
#import "PFSource.h"
#import "PFRacialTrait.h"

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
#pragma mark - Creating/Updating
//------------------------------------------------------------------------------

+ (PFRace *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
					 inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) return nil;

	PFRace *instance = [self fetchWithName:name inContext:moc];
	if (!instance) {
		instance = (PFRace *)[NSEntityDescription insertNewObjectForEntityForName:@"PFRace" inManagedObjectContext:moc];
		instance.name = name;
	}

	NSString *sourceAbbreviation = [[anElement attributeForName:@"source"] stringValue];
	instance.source = [PFSource fetchWithAbbreviation:sourceAbbreviation inContext:moc];

	instance.size = PFSizeTypeFromString([[anElement attributeForName:@"size"] stringValue]);
	instance.type = [[anElement attributeForName:@"type"] stringValue];
	instance.subtype = [[anElement attributeForName:@"subtype"] stringValue];
	instance.speed = [[[anElement attributeForName:@"speed"] stringValue] intValue];

	NSArray *elements = nil;
	
	elements = [anElement elementsForName:@"ShortDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.descriptionShort = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"LongDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.descriptionLong = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"PhysicalDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.physicalDescription = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"Society"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.society = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"Relations"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.relations = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"AlignmentAndReligion"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.alignmentAndReligion = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"Adventurers"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.adventurers = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"FemaleNames"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.namesFemale = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"MaleNames"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.namesMale = firstElement.stringValue;
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
				
				PFRacialTrait *aTrait = [PFRacialTrait insertedInstanceWithElement:traitElement inManagedObjectContext:moc];
				aTrait.race = instance;
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
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFRace" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];

	// Set sort orderings...
	NSSortDescriptor *typeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	request.sortDescriptors = [NSArray arrayWithObject:typeSortDescriptor];

	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching races!");
	}

	return array;
}

+ (PFRace*)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFRace" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];

	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name like[cd] %@", aName];
	[request setPredicate:predicate];

	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching race with name '%@'!", aName);
	}

	if (array.count > 0)
		return [array objectAtIndex:0];

	return nil;
}

//------------------------------------------------------------------------------
#pragma mark - General
//------------------------------------------------------------------------------

- (NSArray *)sortedTraits;
{
	NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortOrder" ascending:YES];
	return [self.traits.allObjects sortedArrayUsingDescriptors:@[sort]];
}


@end
