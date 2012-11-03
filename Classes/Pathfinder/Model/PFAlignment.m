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

+ (PFAlignment *)insertedInstanceWithElement:(GDataXMLElement *)anElement
					inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFAlignment *newInstance = (PFAlignment *)[NSEntityDescription insertNewObjectForEntityForName:@"PFAlignment" inManagedObjectContext:moc];
	newInstance.name = name;
	
	newInstance.abbreviation = [[anElement attributeForName:@"abbreviation"] stringValue];
	newInstance.alignmentType = [[[anElement attributeForName:@"index"] stringValue] intValue];
	
	NSArray *elements = nil;
	
	elements = [anElement elementsForName:@"ShortDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.descriptionShort = firstElement.stringValue;
	};
/*
	elements = [anElement elementsForName:@"LongDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.descriptionLong = firstElement.stringValue;
	};
*/	
	return newInstance;
}

+ (NSArray*)fetchAllAbilitiesInContext:(NSManagedObjectContext*)moc
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

@end
