//
//  PFAbility.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFAbility.h"

#import "GDataXMLNode.h"

@implementation PFAbility

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

// Attributes

@dynamic abilityType;
@dynamic name;
@dynamic abbreviation;
@dynamic descriptionShort;
@dynamic descriptionLong;

// Relationships

@dynamic characterAbilities;

//------------------------------------------------------------------------------
#pragma mark - Creating/Updating
//------------------------------------------------------------------------------

+ (PFAbility *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
						inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) return nil;
	
	PFAbility *instance = [self fetchWithName:name inContext:moc];
	if (!instance) {
		instance = (PFAbility *)[NSEntityDescription insertNewObjectForEntityForName:@"PFAbility" inManagedObjectContext:moc];
		instance.name = name;
	}

	instance.abbreviation = [[anElement attributeForName:@"abbreviation"] stringValue];
	instance.abilityType = [[[anElement attributeForName:@"index"] stringValue] intValue];

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
	
	return instance;
}

//------------------------------------------------------------------------------
#pragma mark - Fetching
//------------------------------------------------------------------------------

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFAbility" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	// Set sort orderings...
	NSSortDescriptor *typeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"abilityType" ascending:YES];
	request.sortDescriptors = [NSArray arrayWithObject:typeSortDescriptor];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching abilities!");
	}
	
	return array;
}

+ (PFAbility *)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFAbility" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];

	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name like[cd] %@", aName];
	[request setPredicate:predicate];

	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching ability with name '%@'!", aName);
	}

	if (array.count > 0)
		return [array objectAtIndex:0];

	return nil;
}

+ (PFAbility *)fetchWithAbbreviation:(NSString *)anAbbreviation inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFAbility" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];

	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"abbreviation like[cd] %@", anAbbreviation];
	[request setPredicate:predicate];

	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching ability with abbreviation '%@'!", anAbbreviation);
	}

	if (array.count > 0)
		return [array objectAtIndex:0];

	return nil;
}

@end
