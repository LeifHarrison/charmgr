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

+ (PFClassFeature *)insertedInstanceWithElement:(GDataXMLElement *)anElement
						 inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFClassFeature *newInstance = (PFClassFeature *)[NSEntityDescription insertNewObjectForEntityForName:@"PFClassFeature"
																				inManagedObjectContext:moc];
	newInstance.name = name;
	newInstance.level = [[[anElement attributeForName:@"level"] stringValue] intValue];
	
	NSString *typeString = [[anElement attributeForName:@"type"] stringValue];
	newInstance.type = PFSpecialAbilityTypeFromString(typeString);
	
	NSArray *elements = nil;
	
	elements = [anElement elementsForName:@"Benefit"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.benefit = firstElement.stringValue;
	};
	
	return newInstance;
}

@end
