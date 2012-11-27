//
//  PFFeat.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class GDataXMLElement;

@class PFSource;

@interface PFFeat : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * descriptionShort;
@property (nonatomic, retain) NSString * prerequisitesString;
@property (nonatomic, retain) NSString * benefitString;
@property (nonatomic, retain) NSString * special;
@property (nonatomic, retain) NSString * normal;

@property (nonatomic, retain) PFSource *source;

+ (PFFeat *)insertedInstanceWithElement:(GDataXMLElement *)anElement
				  inManagedObjectContext:(NSManagedObjectContext*)moc;

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc;
+ (PFFeat*)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;

@end
