//
//  PFAlignment.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFAlignment.h"

#import "GDataXMLNode.h"

@implementation PFAlignment

@dynamic alignmentType;
@dynamic name;
@dynamic abbreviation;
@dynamic descriptionShort;

@dynamic characters;

+ (PFAlignment *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
					inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}

	PFAlignment *instance = [self fetchWithName:name inContext:moc];
	if (!instance) {
		instance = (PFAlignment *)[NSEntityDescription insertNewObjectForEntityForName:@"PFAlignment" inManagedObjectContext:moc];
		instance.name = name;
	}

	instance.abbreviation = [[anElement attributeForName:@"abbreviation"] stringValue];
	instance.alignmentType = [[[anElement attributeForName:@"index"] stringValue] intValue];
	
	NSArray *elements = nil;
	
	elements = [anElement elementsForName:@"ShortDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.descriptionShort = firstElement.stringValue;
	};
/*
	elements = [anElement elementsForName:@"LongDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.descriptionLong = firstElement.stringValue;
	};
*/	
	return instance;
}

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFAlignment"
														 inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	// Set sort orderings...
	NSSortDescriptor *typeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"alignmentType" ascending:YES];
	request.sortDescriptors = [NSArray arrayWithObject:typeSortDescriptor];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching abilities!");
	}
	
	return array;
}

+ (PFAlignment *)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFAlignment" inManagedObjectContext:moc];
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
