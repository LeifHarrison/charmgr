//
//  PFClassFeature.h
//  CharMgr
//
//  Created by Leif Harrison on 12/1/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class GDataXMLElement;
@class PFClassType;

@interface PFClassFeature : NSManagedObject

// Properties

@property (nonatomic, retain) NSString * name;
@property (nonatomic, assign) int16_t type;
@property (nonatomic, retain) NSString * benefit;
@property (nonatomic, assign) int16_t level;
@property (nonatomic, retain) PFClassType *classType;

// General

- (NSString *)nameAndTypeDescription;
- (NSString *)levelDescription;

// Creation

+ (PFClassFeature *)insertedInstanceWithElement:(GDataXMLElement *)anElement
						 inManagedObjectContext:(NSManagedObjectContext*)moc;

@end
