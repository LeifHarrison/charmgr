//
//  PFSkill.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFSkill.h"

#import "GDataXMLNode.h"

@implementation PFSkill

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@dynamic name;
@dynamic untrained;
@dynamic armorCheckPenalty;
@dynamic requiresDetail;
@dynamic keyAbility;
@dynamic descriptionShort;
@dynamic descriptionLong;

@dynamic characterSkills;
@dynamic classTypes;


//------------------------------------------------------------------------------
#pragma mark - Creating/Updating
//------------------------------------------------------------------------------

+ (PFSkill *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
					  inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) return nil;

	PFSkill *instance = [self fetchWithName:name inContext:moc];
	if (!instance) {
		instance = (PFSkill *)[NSEntityDescription insertNewObjectForEntityForName:@"PFSkill" inManagedObjectContext:moc];
		instance.name = name;
	}
	
	instance.keyAbility = [[[anElement attributeForName:@"keyAbility"] stringValue] uppercaseString];
	
	NSString *stringValue = [[anElement attributeForName:@"untrained"] stringValue];
	instance.untrained = [[stringValue lowercaseString] isEqualToString:@"yes"] ? YES : NO;
	stringValue = [[anElement attributeForName:@"armorCheckPenalty"] stringValue];
	instance.armorCheckPenalty = [[stringValue lowercaseString] isEqualToString:@"yes"] ? YES : NO;
	stringValue = [[anElement attributeForName:@"requiresDetail"] stringValue];
	instance.requiresDetail = [[stringValue lowercaseString] isEqualToString:@"yes"] ? YES : NO;
	
	NSArray *elements = nil;
	
	elements = [anElement elementsForName:@"ShortDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.descriptionShort = firstElement.stringValue;
	};

	return instance;
}


//------------------------------------------------------------------------------
#pragma mark - Fetching
//------------------------------------------------------------------------------

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFSkill"
														 inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	// Set sort orderings...
	NSSortDescriptor *typeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	request.sortDescriptors = [NSArray arrayWithObject:typeSortDescriptor];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching skills!");
	}
	
	return array;
}

+ (PFSkill*)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFSkill"
														 inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name like[cd] %@", aName];
	[request setPredicate:predicate];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching skill with name '%@'!", aName);
	}

	if (array.count > 0)
		return [array objectAtIndex:0];
	
	return nil;
}

@end
