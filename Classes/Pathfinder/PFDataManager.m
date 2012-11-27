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

#import <CoreData/CoreData.h>

@implementation PFDataManager

- (void)importAbilitiesAsXML;
{
	LOG_DEBUG(@"Importing abilities...");
	CMAppDelegate *appDelegate = (CMAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	[moc setPersistentStoreCoordinator:[appDelegate persistentStoreCoordinator]];
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Abilities" ofType:@"xml" inDirectory:@"Data/Core"];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
	
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) { return; }
	
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Ability"];
	for (GDataXMLElement *anElement in elements) {
		PFAbility *newInstance = [PFAbility insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}
	
	LOG_DEBUG(@"  %d abilities imported.", importCount);
	
	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
}

- (void)importAlignmentsAsXML;
{
	LOG_DEBUG(@"Importing alignments...");
	CMAppDelegate *appDelegate = (CMAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	[moc setPersistentStoreCoordinator:[appDelegate persistentStoreCoordinator]];
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Alignments" ofType:@"xml" inDirectory:@"Data/Core"];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
	
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) { return; }
	
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Alignment"];
	for (GDataXMLElement *anElement in elements) {
		PFAlignment *newInstance = [PFAlignment insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}
	
	LOG_DEBUG(@"  %d alignments imported.", importCount);
	
	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
}

- (void)importClassTypesAsXML;
{
	LOG_DEBUG(@"Importing classes...");
	CMAppDelegate *appDelegate = (CMAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	[moc setPersistentStoreCoordinator:[appDelegate persistentStoreCoordinator]];
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Classes" ofType:@"xml" inDirectory:@"Data/Core"];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
	
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) { return; }
	
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Class"];
	for (GDataXMLElement *anElement in elements) {
		PFClassType *newInstance = [PFClassType insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}
	
	LOG_DEBUG(@"  %d classes imported.", importCount);
	
	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
}

- (void)importFeatsAsXML;
{
	LOG_DEBUG(@"Importing feats...");
	CMAppDelegate *appDelegate = (CMAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	[moc setPersistentStoreCoordinator:[appDelegate persistentStoreCoordinator]];
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Feats" ofType:@"xml" inDirectory:@"Data/Core"];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
	
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) { return; }
	
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;
	
	NSArray *elements = [doc.rootElement elementsForName:@"Feat"];
	for (GDataXMLElement *anElement in elements) {
		PFFeat *newInstance = [PFFeat insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}
	
	LOG_DEBUG(@"  %d feats imported.", importCount);
	
	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
}

- (void)importRacesAsXML;
{
	LOG_DEBUG(@"Importing races...");
	CMAppDelegate *appDelegate = (CMAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	[moc setPersistentStoreCoordinator:[appDelegate persistentStoreCoordinator]];

	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Races" ofType:@"xml" inDirectory:@"Data/Core"];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
	
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) { return; }
	
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Race"];
	for (GDataXMLElement *anElement in elements) {
		PFRace *newInstance = [PFRace insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}
	
	LOG_DEBUG(@"  %d races imported.", importCount);
	
	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}

}

- (void)importSkillsAsXML;
{
	LOG_DEBUG(@"Importing skills...");
	CMAppDelegate *appDelegate = (CMAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	[moc setPersistentStoreCoordinator:[appDelegate persistentStoreCoordinator]];
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Skills" ofType:@"xml" inDirectory:@"Data/Core"];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
	
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) { return; }
	
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Skill"];
	for (GDataXMLElement *anElement in elements) {
		PFSkill *newInstance = [PFSkill insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}
	
	LOG_DEBUG(@"  %d skills imported.", importCount);
	
	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
}

- (void)importSourcesAsXML;
{
	LOG_DEBUG(@"Importing sources...");
	CMAppDelegate *appDelegate = (CMAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	[moc setPersistentStoreCoordinator:[appDelegate persistentStoreCoordinator]];
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Sources" ofType:@"xml" inDirectory:@"Data"];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
	
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) { return; }
	
    //NSLog(@"%@", doc.rootElement);
	NSInteger importCount = 0;

	NSArray *elements = [doc.rootElement elementsForName:@"Source"];
	for (GDataXMLElement *anElement in elements) {
		PFSource *newInstance = [PFSource insertedInstanceWithElement:anElement inManagedObjectContext:moc];
		//LOG_DEBUG(@"  newInstance = %@", newInstance.name);
		if (newInstance) importCount++;
	}
	
	LOG_DEBUG(@"  %d sources imported.", importCount);
	
	if (![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
}

@end
