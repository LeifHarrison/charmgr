//
//  PFCharacterClass.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PFCharacter;
@class PFClassType;

@interface PFCharacterClass : NSManagedObject

@property (nonatomic) int16_t level;
@property (nonatomic, retain) PFCharacter *character;
@property (nonatomic, retain) PFClassType *classType;

@end
