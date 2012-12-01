//
//  PFRacialTrait.m
//  CharMgr
//
//  Created by Leif Harrison on 11/29/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFRacialTrait.h"

#import "PFRace.h"

#import "GDataXMLNode.h"

@implementation PFRacialTrait

@dynamic descriptionShort;
@dynamic displayName;
@dynamic name;
@dynamic sortOrder;
@dynamic race;

//------------------------------------------------------------------------------
#pragma mark - Creation/Inserting
//------------------------------------------------------------------------------

+ (PFRacialTrait *)insertedInstanceWithElement:(GDataXMLElement *)anElement
						inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFRacialTrait *newInstance = (PFRacialTrait *)[NSEntityDescription insertNewObjectForEntityForName:@"PFRacialTrait"
																	inManagedObjectContext:moc];
	newInstance.name = name;
	newInstance.displayName = [[anElement attributeForName:@"displayName"] stringValue];
	newInstance.sortOrder = [[[anElement attributeForName:@"sortOrder"] stringValue] intValue];
	
	NSArray *elements = nil;
	
	elements = [anElement elementsForName:@"ShortDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.descriptionShort = firstElement.stringValue;
	};
	
	return newInstance;
}

@end
