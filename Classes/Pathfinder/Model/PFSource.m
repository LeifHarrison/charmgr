//
//  PFSource.m
//  CharMgr
//
//  Created by Leif Harrison on 11/26/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFSource.h"
#import "PFClassType.h"
#import "PFFeat.h"
#import "PFRace.h"
#import "PFTrait.h"

#import "GDataXMLNode.h"

@implementation PFSource

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@dynamic name;
@dynamic index;
@dynamic abbreviation;
@dynamic classTypes;
@dynamic races;
@dynamic feats;
@dynamic traits;

//------------------------------------------------------------------------------
#pragma mark - Creation/Inserting
//------------------------------------------------------------------------------

+ (PFSource *)insertedInstanceWithElement:(GDataXMLElement *)anElement
				  inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFSource *newInstance = (PFSource *)[NSEntityDescription insertNewObjectForEntityForName:@"PFSource"
																	  inManagedObjectContext:moc];
	newInstance.name = name;
	
	newInstance.abbreviation = [[anElement attributeForName:@"abbreviation"] stringValue];
	newInstance.index = [[[anElement attributeForName:@"index"] stringValue] intValue];
	
	return newInstance;
}


//------------------------------------------------------------------------------
#pragma mark - Fetching
//------------------------------------------------------------------------------

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFSource"
														 inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	// Set sort orderings...
	NSSortDescriptor *indexSort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
	request.sortDescriptors = [NSArray arrayWithObject:indexSort];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching skill!");
	}
	
	return array;
}

+ (PFSource*)fetchWithAbbreviation:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFSource"
														 inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"abbreviation like[cd] %@", aName];
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
