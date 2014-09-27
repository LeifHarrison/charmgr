//
//  CMEditTransitioner.h
//  CharMgr
//
//  Created by Leif Harrison on 9/25/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMEditTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic) id <UIViewControllerAnimatedTransitioning> animationController;

@end

@interface CMEditAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL isPresentation;
@property (nonatomic) UIViewController *sourceViewController;

@end

