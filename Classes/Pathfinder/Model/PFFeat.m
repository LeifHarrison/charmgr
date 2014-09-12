//
//  PFFeat.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFFeat.h"

#import "PFSource.h"

#import "GDataXMLNode.h"


@implementation PFFeat

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

// Attributes

@dynamic name;
@dynamic type;
@dynamic descriptionShort;
@dynamic prerequisitesString;
@dynamic benefitString;
@dynamic special;
@dynamic normal;

// Relationships

@dynamic source;

//------------------------------------------------------------------------------
#pragma mark - Creating/Updating
//------------------------------------------------------------------------------

+ (PFFeat *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
				  inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFFeat *instance = [self fetchWithName:name inContext:moc];
	if (!instance) {
		instance = (PFFeat *)[NSEntityDescription insertNewObjectForEntityForName:@"PFFeat" inManagedObjectContext:moc];
		instance.name = name;
	}

	instance.type = [[anElement attributeForName:@"type"] stringValue];
	
	NSString *sourceAbbreviation = [[anElement attributeForName:@"source"] stringValue];
	instance.source = [PFSource fetchWithAbbreviation:sourceAbbreviation inContext:moc];
	
	NSArray *elements = nil;
	
	elements = [anElement elementsForName:@"Prerequisites"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.prerequisitesString = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"Benefit"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.benefitString = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"Normal"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.normal = firstElement.stringValue;
	};
	
	return instance;
}

//------------------------------------------------------------------------------
#pragma mark - Fetching
//------------------------------------------------------------------------------

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFFeat" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	// Set sort orderings...
	NSSortDescriptor *typeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	request.sortDescriptors = [NSArray arrayWithObject:typeSortDescriptor];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching feats!");
	}
	
	return array;
}

+ (PFFeat*)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFFeat" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name like[cd] %@", aName];
	[request setPredicate:predicate];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching feat with name '%@'!", aName);
	}
	
	if (array.count > 0)
		return [array objectAtIndex:0];
	
	return nil;
}

@end
