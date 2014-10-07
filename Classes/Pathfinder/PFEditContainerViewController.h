//
//  PFEditContainerViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/29/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMBannerBox;
@class PFCharacter;

@interface PFEditContainerViewController : UIViewController

@property (nonatomic, readonly) CMBannerBox* bannerBox;

@property (nonatomic) PFCharacter *character;

- (void)updateUI;
- (void)saveChanges;

@end
