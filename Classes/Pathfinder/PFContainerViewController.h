//
//  PFContainerViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import <UIKit/UIKit.h>

@class PFCharacter;

@interface PFContainerViewController : UIViewController

@property (nonatomic, strong) PFCharacter *character;

- (void)updateUI;

@end

