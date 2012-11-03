//
//  PFFeat.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PFFeat : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * descriptionShort;
@property (nonatomic, retain) NSString * prerequisitesString;
@property (nonatomic, retain) NSString * benefitString;
@property (nonatomic, retain) NSString * special;
@property (nonatomic, retain) NSString * normal;
@property (nonatomic, retain) NSString * source;

@end
