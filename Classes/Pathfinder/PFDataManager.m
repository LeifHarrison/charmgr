//
//  PFDataManager.m
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFDataManager.h"

#import "CMAppDelegate.h"
#import "GDataXMLNode.h"

#import "PFAbility.h"
#import "PFAlignment.h"
#import "PFClassType.h"
#import "PFFeat.h"
#import "PFRace.h"
#import "PFSkill.h"
#import "PFSource.h"
#import "PFTrait.h"
#import "PFWeapon.h"

#import <CoreData/CoreData.h>

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFDataManager

- (GDataXMLDocument *)documentWithType:(NSString *)type forSource:(PFSource *)source
{
	NSString *directory = @"Data";
	if (source && source.abbreviation.length > 0) {
		directory = [directory stringByAppendingFormat:@"/%@", source.abbreviation];
	}
	NSString *filePath = [[NSBundle mainBundle] pathForResource:type ofType:@"xml" inDirectory:directory];

	NSFileManager *fileManager = [NSFileManager defaultManager];
	GDataXMLDocument *doc = nil;
    NSError *error = nil;

	if ([fileManager fileExistsAtPath:filePath]) {
		NSDictionary *attributes = [fileManager attributesOfItemAtPath:filePath error:&error];
		NSDate *modificationDate = [attributes fileModificationDate];

		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSDictionary *importDates = [defaults valueForKey:kPFImportDatesDefaultsKey];
		NSString *key = [NSString stringWithFormat:@"%@/%@", source.abbreviation, type];
		NSDate *lastImportDate = [importDates valueForKey:key];
		//LOG_DEBUG(@"modificationDate = %@, lastImportDate = %@", modificationDate, lastImportDate);
		if (!lastImportDate || ([lastImportDate compare:modificationDate] == NSOrderedAscending))
		{
			NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
			doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];

			NSMutableDictionary *mutableImportDates = [importDates mutableCopy];
			if (!mutableImportDates) mutableImportDates = [NSMutableDictionary dictionaryWithCapacity:1];
			[mutableImportDates setValue:modificationDate forKey:key];
			[defaults setValue:mutableImportDates forKey:kPFImportDatesDefaultsKey];
		}
	}

	return doc;
}

- (void)importSourcesInManagedObjectContext:(NSManagedObjectContext *)moc;
{
	GDataXMLDocument *doc = [self documentWithType:@"Sources" forSource:nil];
	if (doc == nil) { return; }

	LOG_DEBUG(@"Importing sources...");
	//NSLog(@"%@", doc.rootElement);

	NSArray *elements = [doc.rootElement elementsForName:@"Source"];
	NSMutableArray *sources = [NSMutableArray arrayWithCapacity:elements.count];
	for (GDataXMLElement *anElement in elements) {
		PFSource *newInstance = [PFSource insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"  newInstance = %@", newInstance.name);
		if (newInstance) [sources addObject:newInstance];
	}

	LOG_DEBUG(@"  %lu sources imported.", (unsigned long)sources.count);
}

- (void)importAbilitiesInManagedObjectContext:(NSManagedObjectContext *)moc;
{
	PFSource *core = [PFSource fetchWithAbbreviation:@"Core" inContext:moc];
    GDataXMLDocument *doc = [self documentWithType:@"Abilities" forSource:core];
    if (doc == nil) { return; }

	LOG_DEBUG(@"Importing abilities...");
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Ability"];
	for (GDataXMLElement *anElement in elements) {
		PFAbility *newInstance = [PFAbility insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}

	LOG_DEBUG(@"  %ld abilities imported.", importCount);
}

- (void)importAlignmentsInManagedObjectContext:(NSManagedObjectContext *)moc;
{
	PFSource *core = [PFSource fetchWithAbbreviation:@"Core" inContext:moc];
    GDataXMLDocument *doc = [self documentWithType:@"Alignments" forSource:core];
    if (doc == nil) { return; }

	LOG_DEBUG(@"Importing alignments...");
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Alignment"];
	for (GDataXMLElement *anElement in elements) {
		PFAlignment *newInstance = [PFAlignment insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}

	LOG_DEBUG(@"  %ld alignments imported.", (long)importCount);
}

- (void)importSkillsInManagedObjectContext:(NSManagedObjectContext *)moc;
{
	PFSource *core = [PFSource fetchWithAbbreviation:@"Core" inContext:moc];
    GDataXMLDocument *doc = [self documentWithType:@"Skills" forSource:core];
    if (doc == nil) { return; }

	LOG_DEBUG(@"Importing skills...");
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Skill"];
	for (GDataXMLElement *anElement in elements) {
		PFSkill *newInstance = [PFSkill insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}

	LOG_DEBUG(@"  %ld skills imported.", (long)importCount);
}

- (void)importClassesForSource:(PFSource*)source inManagedObjectContext:(NSManagedObjectContext *)moc;
{
    GDataXMLDocument *doc = [self documentWithType:@"Classes" forSource:source];
    if (doc == nil) { return; }
	
	LOG_DEBUG(@"Importing classes for source %@...", source.name);
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Class"];
	for (GDataXMLElement *anElement in elements) {
		PFClassType *newInstance = [PFClassType insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}
	
	LOG_DEBUG(@"  %ld classes imported.", (long)importCount);
	
    NSError *error = nil;
	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
}

- (void)importRacesForSource:(PFSource*)source inManagedObjectContext:(NSManagedObjectContext *)moc;
{
    GDataXMLDocument *doc = [self documentWithType:@"Races" forSource:source];
    if (doc == nil) { return; }

	LOG_DEBUG(@"Importing races for source %@...", source.name);
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Race"];
	for (GDataXMLElement *anElement in elements) {
		PFRace *newInstance = [PFRace insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}

	LOG_DEBUG(@"  %ld races imported.", (long)importCount);
}

- (void)importFeatsForSource:(PFSource*)source inManagedObjectContext:(NSManagedObjectContext *)moc;
{
    GDataXMLDocument *doc = [self documentWithType:@"Feats" forSource:source];
    if (doc == nil) { return; }
	
	LOG_DEBUG(@"Importing feats for source %@...", source.name);
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;
	
	NSArray *elements = [doc.rootElement elementsForName:@"Feat"];
	for (GDataXMLElement *anElement in elements) {
		PFFeat *newInstance = [PFFeat insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}
	
	LOG_DEBUG(@"  %ld feats imported.", (long)importCount);
	
    NSError *error = nil;
	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
}

- (void)importWeaponsForSource:(PFSource*)source inManagedObjectContext:(NSManagedObjectContext *)moc;
{
    GDataXMLDocument *doc = [self documentWithType:@"Weapons" forSource:source];
    if (doc == nil) { return; }

	LOG_DEBUG(@"Importing weapons for source %@...", source.name);
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;
	
	NSArray *elements = [doc.rootElement elementsForName:@"Weapon"];
	for (GDataXMLElement *anElement in elements) {
		PFWeapon *newInstance = [PFWeapon insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}
	
	LOG_DEBUG(@"  %ld weapons imported.", (long)importCount);
}

@end
