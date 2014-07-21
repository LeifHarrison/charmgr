//
//  PFPageContentViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import <UIKit/UIKit.h>

#import "PFContainerViewController.h"

@class PFCharacter;

@interface PFPageContentViewController : UIViewController

@property (nonatomic, strong) PFCharacter *character;

@property (nonatomic, strong) NSMutableArray *containers;

@end
