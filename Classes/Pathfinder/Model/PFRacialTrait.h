//
//  PFRacialTrait.h
//  CharMgr
//
//  Created by Leif Harrison on 11/29/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class GDataXMLElement;

@class PFRace;

@interface PFRacialTrait : NSManagedObject

// Properties

@property (nonatomic, retain) NSString * descriptionShort;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t sortOrder;
@property (nonatomic, retain) PFRace *race;

// Creation

+ (PFRacialTrait *)insertedInstanceWithElement:(GDataXMLElement *)anElement
						inManagedObjectContext:(NSManagedObjectContext*)moc;

@end
