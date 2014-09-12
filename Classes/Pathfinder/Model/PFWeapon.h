//
//  PFWeapon.h
//  CharMgr
//
//  Created by Leif Harrison on 2/26/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class GDataXMLElement;
@class PFCharacter;
@class PFSource;

@interface PFWeapon : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * classification;
@property (nonatomic, retain) NSString * cost;
@property (nonatomic, retain) NSString * criticalDamage;
@property (nonatomic, retain) NSString * criticalThreat;
@property (nonatomic, retain) NSString * damageMedium;
@property (nonatomic, retain) NSString * damageSmall;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * range;
@property (nonatomic, retain) NSString * special;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * weight;

@property (nonatomic, retain) PFSource *source;

@property (nonatomic, retain) NSSet *characters;


+ (PFWeapon *)newOrUpdatedInstanceWithElement:(GDataXMLElement *)anElement
					   inManagedObjectContext:(NSManagedObjectContext*)moc;

+ (NSArray*)fetchAllInContext:(NSManagedObjectContext*)moc;
+ (PFWeapon*)fetchWithName:(NSString *)aName inContext:(NSManagedObjectContext*)moc;

@end

@interface PFWeapon (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(PFCharacter *)value;
- (void)removeCharactersObject:(PFCharacter *)value;
- (void)addCharacters:(NSSet *)values;
- (void)removeCharacters:(NSSet *)values;

@end
