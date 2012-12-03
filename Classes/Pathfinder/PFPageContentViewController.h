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

@interface PFPageContentViewController : UIViewController <PFContainerViewControllerDelegate>

@property (nonatomic, strong) PFCharacter *character;

@end
