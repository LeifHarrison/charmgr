//
//  PFAlignment.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class GDataXMLElement;

@class PFCharacter;

@interface PFAlignment : NSManagedObject

@property (nonatomic) int16_t alignmentType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * abbreviation;
@property (nonatomic, retain) NSString * descriptionShort;

@property (nonatomic, retain) NSSet *characters;

+ (PFAlignment *)insertedInstanceWithElement:(GDataXMLElement *)anElement
					  inManagedObjectContext:(NSManagedObjectContext*)moc;

+ (NSArray*)fetchAllAbilitiesInContext:(NSManagedObjectContext*)moc;

@end

@interface PFAlignment (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(PFCharacter *)value;
- (void)removeCharactersObject:(PFCharacter *)value;
- (void)addCharacters:(NSSet *)values;
- (void)removeCharacters:(NSSet *)values;

@end
