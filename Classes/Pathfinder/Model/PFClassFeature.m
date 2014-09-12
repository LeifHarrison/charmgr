//
//  PFClassFeature.m
//  CharMgr
//
//  Created by Leif Harrison on 12/1/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFClassFeature.h"

#import "PFClassType.h"

#import "GDataXMLNode.h"

@implementation PFClassFeature

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@dynamic name;
@dynamic type;
@dynamic benefit;
@dynamic level;

@dynamic classType;

//------------------------------------------------------------------------------
#pragma mark - General
//------------------------------------------------------------------------------

- (NSString *)nameAndTypeDescription;
{
	if (self.type != kPFSpecialAbilityTypeNone)
		return [NSString stringWithFormat:@"%@ (%@)", self.name, NSStringFromPFSpecialAbilityType(self.type)];
	else
		return self.name;
}

- (NSString *)levelDescription;
{
	if (self.level > 0)
		return [NSString stringWithFormat:@"Level %d", self.level];
	else
		return @"";
}

//------------------------------------------------------------------------------
#pragma mark - Creation/Inserting
//------------------------------------------------------------------------------

+ (PFClassFeature *)newOrUpdatedInstanceForClassType:(PFClassType*)classType
										 withElement:(GDataXMLElement *)anElement
							 inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFClassFeature *instance = [self fetchWithClassType:classType name:name inContext:moc];
	if (!instance) {
		instance = (PFClassFeature *)[NSEntityDescription insertNewObjectForEntityForName:@"PFClassFeature" inManagedObjectContext:moc];
		instance.name = name;
	}

	instance.level = [[[anElement attributeForName:@"level"] stringValue] intValue];
	
	NSString *typeString = [[anElement attributeForName:@"type"] stringValue];
	instance.type = PFSpecialAbilityTypeFromString(typeString);
	
	NSArray *elements = nil;
	
	elements = [anElement elementsForName:@"Benefit"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		instance.benefit = firstElement.stringValue;
	};
	
	return instance;
}

//------------------------------------------------------------------------------
#pragma mark - Fetching
//------------------------------------------------------------------------------

+ (PFClassFeature *)fetchWithClassType:(PFClassType*)classType name:(NSString *)aName inContext:(NSManagedObjectContext*)moc;
{
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PFClassFeature" inManagedObjectContext:moc];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];

	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(classType == %@) AND (name like[cd] %@)", classType, aName];
	[request setPredicate:predicate];

	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	if (!array) {
		LOG_DEBUG(@"Error fetching class feature with class type %@ and name '%@'!", classType.name, aName);
	}

	if (array.count > 0)
		return [array objectAtIndex:0];

	return nil;
}

@end
