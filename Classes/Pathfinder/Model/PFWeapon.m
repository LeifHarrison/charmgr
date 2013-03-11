//
//  PFWeapon.m
//  CharMgr
//
//  Created by Leif Harrison on 2/26/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import "PFWeapon.h"

#import "PFSource.h"

#import "GDataXMLNode.h"

@implementation PFWeapon

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@dynamic category;
@dynamic classification;
@dynamic cost;
@dynamic criticalDamage;
@dynamic criticalThreat;
@dynamic damageMedium;
@dynamic damageSmall;
@dynamic name;
@dynamic range;
@dynamic special;
@dynamic type;
@dynamic weight;

@dynamic characters;
@dynamic source;

//------------------------------------------------------------------------------
#pragma mark - Creation/Inserting
//------------------------------------------------------------------------------

+ (PFWeapon *)insertedInstanceWithElement:(GDataXMLElement *)anElement
				 inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFWeapon *newInstance = (PFWeapon *)[NSEntityDescription insertNewObjectForEntityForName:@"PFWeapon"
																  inManagedObjectContext:moc];
	newInstance.name = name;
	
	newInstance.type = [[anElement attributeForName:@"type"] stringValue];
	
	NSString *sourceAbbreviation = [[anElement attributeForName:@"source"] stringValue];
	if (sourceAbbreviation) {
		newInstance.source = [PFSource fetchWithAbbreviation:sourceAbbreviation inContext:moc];		
	}
	
	newInstance.classification = [[anElement attributeForName:@"class"] stringValue];
	newInstance.category = [[anElement attributeForName:@"category"] stringValue];
	//newInstance.classification = [[anElement attributeForName:@"displayName"] stringValue];
	newInstance.type = [[anElement attributeForName:@"type"] stringValue];
	newInstance.damageSmall = [[anElement attributeForName:@"dmgS"] stringValue];
	newInstance.damageMedium = [[anElement attributeForName:@"dmgM"] stringValue];
	newInstance.criticalThreat = [[anElement attributeForName:@"critThreat"] stringValue];
	newInstance.criticalDamage = [[anElement attributeForName:@"critDmg"] stringValue];
	newInstance.range = [[anElement attributeForName:@"range"] stringValue];
	newInstance.cost = [[anElement attributeForName:@"cost"] stringValue];
	newInstance.weight = [[anElement attributeForName:@"weight"] stringValue];
	newInstance.special = [[anElement attributeForName:@"special"] stringValue];

	return newInstance;
}

//------------------------------------------------------------------------------
#pragma mark - Fetching
//------------------------------------------------------------------------------

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFWeapon"
														 inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	// Set sort orderings...
	NSSortDescriptor *typeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	request.sortDescriptors = [NSArray arrayWithObject:typeSortDescriptor];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching skill!");
	}
	
	return array;
}

+ (PFFeat*)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFWeapon"
														 inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name like[cd] %@", aName];
	[request setPredicate:predicate];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching weapon with name '%@'!", aName);
	}
	
	if (array.count > 0)
		return [array objectAtIndex:0];
	
	return nil;
}

@end
