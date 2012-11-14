//
//  PFDetailViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 11/4/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFCharacter;

@protocol PFDetailViewControllerDelegate;

@interface PFDetailViewController : UIViewController

@property (nonatomic, strong) PFCharacter *character;

@property (nonatomic, weak) id <PFDetailViewControllerDelegate> delegate;

@end

@protocol PFDetailViewControllerDelegate <NSObject>

- (void)detailViewControllerDidFinish:(PFDetailViewController*)viewController;

@end
