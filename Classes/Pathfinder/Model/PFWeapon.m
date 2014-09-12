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
#pragma mark - Creating/Updating
//------------------------------------------------------------------------------

+ (PFWeapon *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
					   inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFWeapon *instance = [self fetchWithName:name inContext:moc];
	if (!instance) {
		instance = (PFWeapon *)[NSEntityDescription insertNewObjectForEntityForName:@"PFWeapon" inManagedObjectContext:moc];
		instance.name = name;
	}

	instance.type = [[anElement attributeForName:@"type"] stringValue];
	
	NSString *sourceAbbreviation = [[anElement attributeForName:@"source"] stringValue];
	if (sourceAbbreviation) {
		instance.source = [PFSource fetchWithAbbreviation:sourceAbbreviation inContext:moc];
	}
	
	instance.classification = [[anElement attributeForName:@"class"] stringValue];
	instance.category = [[anElement attributeForName:@"category"] stringValue];
	//instance.classification = [[anElement attributeForName:@"displayName"] stringValue];
	instance.type = [[anElement attributeForName:@"type"] stringValue];
	instance.damageSmall = [[anElement attributeForName:@"dmgS"] stringValue];
	instance.damageMedium = [[anElement attributeForName:@"dmgM"] stringValue];
	instance.criticalThreat = [[anElement attributeForName:@"critThreat"] stringValue];
	instance.criticalDamage = [[anElement attributeForName:@"critDmg"] stringValue];
	instance.range = [[anElement attributeForName:@"range"] stringValue];
	instance.cost = [[anElement attributeForName:@"cost"] stringValue];
	instance.weight = [[anElement attributeForName:@"weight"] stringValue];
	instance.special = [[anElement attributeForName:@"special"] stringValue];

	return instance;
}

//------------------------------------------------------------------------------
#pragma mark - Fetching
//------------------------------------------------------------------------------

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFWeapon" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	
	// Set sort orderings...
	NSSortDescriptor *typeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	request.sortDescriptors = [NSArray arrayWithObject:typeSortDescriptor];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching weapons!");
	}
	
	return array;
}

+ (PFFeat*)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFWeapon" inManagedObjectContext:moc];
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
