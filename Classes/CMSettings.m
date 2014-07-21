//
//  CMSettings.m
//  CharMgr
//
//  Created by Leif Harrison on 7/11/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "CMSettings.h"

@implementation CMSettings

#pragma mark Singleton Methods

+ (instancetype)sharedSettings
{
	static CMSettings *sharedMySettings = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedMySettings = [[self alloc] init];
	});
	return sharedMySettings;
}

- (instancetype)init
{
	if (self = [super init]) {
		self.pageBackgroundImage = [UIImage imageNamed:@"paper_texture3"];
	}
	return self;
}

- (void)dealloc
{
	// Should never be called, but just here for clarity really.
}

@end
