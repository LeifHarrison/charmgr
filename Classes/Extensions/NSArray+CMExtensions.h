//
//  NSArray+CMExtensions.h
//  CharMgr
//
//  Created by Leif Harrison on 11/19/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CMExtensions)

- (NSArray*) sortByObjectTag;
- (NSArray*) sortByUIViewOriginX;
- (NSArray*) sortByUIViewOriginY;

@end
