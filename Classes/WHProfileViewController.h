//
//  WHProfileViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 2/22/10.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMBannerBox;

@interface WHProfileViewController : UIViewController
{
	IBOutlet CMBannerBox *characterBox;
	IBOutlet CMBannerBox *detailsBox;
	IBOutlet CMBannerBox *profileBox;
	
}

@property (nonatomic, strong) IBOutlet CMBannerBox *characterBox;
@property (nonatomic, strong) IBOutlet CMBannerBox *detailsBox;
@property (nonatomic, strong) IBOutlet CMBannerBox *profileBox;

@end
