//
//  PFDetailViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 11/4/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFCharacter;

@interface PFDetailViewController : UIViewController

@property (nonatomic, strong) PFCharacter *character;

@end
