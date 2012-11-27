//
//  PFTrait.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class PFRace;
@class PFSource;

@class GDataXMLElement;

@interface PFTrait : NSManagedObject

// Properties

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic) int16_t type;
@property (nonatomic, retain) NSString * benefitsString;
@property (nonatomic, retain) NSString * descriptionShort;

@property (nonatomic, retain) PFSource *source;
@property (nonatomic, retain) PFRace *race;

// Creation

+ (PFTrait *)insertedInstanceWithElement:(GDataXMLElement *)anElement
				  inManagedObjectContext:(NSManagedObjectContext*)moc;

// Fetching

+ (PFTrait*)fetchTraitWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;

@end
