//
//  CMRootViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMMainViewController;

@interface CMRootViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) CMMainViewController *mainViewController;
@property (nonatomic, strong) NSArray *characterViewControllers;

- (void)setPageTurningEnabled:(BOOL)flag;

@end
