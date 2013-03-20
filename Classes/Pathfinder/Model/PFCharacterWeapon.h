//
//  PFCharacterWeapon.h
//  CharMgr
//
//  Created by Leif Harrison on 3/17/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PFCharacter, PFWeapon;

@interface PFCharacterWeapon : NSManagedObject

@property (nonatomic, retain) NSString * additionalDescription;
@property (nonatomic, retain) NSString * properties;
@property (nonatomic, retain) PFCharacter *character;
@property (nonatomic, retain) PFWeapon *weapon;

- (NSString *)attackBonusDescription;

@end
