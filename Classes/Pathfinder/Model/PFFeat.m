//
//  PFFeat.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFFeat.h"

#import "GDataXMLNode.h"


@implementation PFFeat

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

@dynamic name;
@dynamic type;
@dynamic descriptionShort;
@dynamic prerequisitesString;
@dynamic benefitString;
@dynamic special;
@dynamic normal;
@dynamic source;

//------------------------------------------------------------------------------
#pragma mark - Creation/Inserting
//------------------------------------------------------------------------------

+ (PFFeat *)insertedInstanceWithElement:(GDataXMLElement *)anElement
				  inManagedObjectContext:(NSManagedObjectContext*)moc;
{
	NSString *name = [[anElement attributeForName:@"name"] stringValue];
	//LOG_DEBUG(@"name = %@", name);
	if (!name) {
		return nil;
	}
	
	PFFeat *newInstance = (PFFeat *)[NSEntityDescription insertNewObjectForEntityForName:@"PFFeat"
																	inManagedObjectContext:moc];
	newInstance.name = name;
	
	newInstance.type = [[anElement attributeForName:@"type"] stringValue];
	newInstance.source = [[anElement attributeForName:@"source"] stringValue];
	
	NSArray *elements = nil;
	
	elements = [anElement elementsForName:@"Prerequisites"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.prerequisitesString = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"Benefit"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.benefitString = firstElement.stringValue;
	};
	
	elements = [anElement elementsForName:@"ShortDescription"];
	if (elements.count > 0) {
		GDataXMLElement *firstElement = (GDataXMLElement *) [elements objectAtIndex:0];
		newInstance.descriptionShort = firstElement.stringValue;
	};
	
	return newInstance;
}


@end
