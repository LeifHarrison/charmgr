//
//  CMSettings.h
//  CharMgr
//
//  Created by Leif Harrison on 7/11/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMSettings : NSObject

@property (nonatomic) UIImage *pageBackgroundImage;

+ (instancetype)sharedSettings;

@end
