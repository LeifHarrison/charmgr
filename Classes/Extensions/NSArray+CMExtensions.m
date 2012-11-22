//
//  NSArray+CMExtensions.m
//  CharMgr
//
//  Created by Leif Harrison on 11/19/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "NSArray+CMExtensions.h"

@implementation NSArray (CMExtensions)

- (NSArray*)sortByObjectTag
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
			   ([objA tag] < [objB tag]) ? NSOrderedAscending  :
			   ([objA tag] > [objB tag]) ? NSOrderedDescending :
			   NSOrderedSame);
    }];
}

- (NSArray*)sortByUIViewOriginX
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
			   ([objA frame].origin.x < [objB frame].origin.x) ? NSOrderedAscending  :
			   ([objA frame].origin.x > [objB frame].origin.x) ? NSOrderedDescending :
			   NSOrderedSame);
    }];
}

- (NSArray*)sortByUIViewOriginY
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
			   ([objA frame].origin.y < [objB frame].origin.y) ? NSOrderedAscending  :
			   ([objA frame].origin.y > [objB frame].origin.y) ? NSOrderedDescending :
			   NSOrderedSame);
    }];
}

@end
