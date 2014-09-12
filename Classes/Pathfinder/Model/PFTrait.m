//
//  PFTrait.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFTrait.h"

#import "PFSource.h"

#import "GDataXMLNode.h"

@implementation PFTrait

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@dynamic name;
@dynamic displayName;
@dynamic type;
@dynamic benefitsString;
@dynamic descriptionShort;
@dynamic source;

@dynamic race;

//------------------------------------------------------------------------------
#pragma mark - Creating/Updating
//------------------------------------------------------------------------------

+ (PFTrait *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
					  inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) return nil;

	PFTrait *instance = [self fetchWithName:name inContext:moc];
	if (!instance) {
		instance = (PFTrait *)[NSEntityDescription insertNewObjectForEntityForName:@"PFTrait" inManagedObjectContext:moc];
		instance.name = name;
	}

	instance.displayName = [[anElement attributeForName:@"displayName"] stringValue];
	//instance.source = [[anElement attributeForName:@"source"] stringValue];
	
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

+ (PFTrait*)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFTrait"
														 inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name like[cd] %@", aName];
	[request setPredicate:predicate];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching trait with name '%@'!", aName);
	}
	
	if (array.count > 0)
		return [array objectAtIndex:0];
	
	return nil;
}


@end
