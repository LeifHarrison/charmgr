//
//  CMBannerBox.h
//  CharMgr
//
//  Created by Leif Harrison on 4/28/10.
//  Copyright 2010 Ubermind, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CMBannerBox : UIView
{
}

@property (nonatomic) IBInspectable UIColor *bannerColor;
@property (nonatomic) IBInspectable UIColor *bannerTextColor;
@property (nonatomic) IBInspectable UIFont  *bannerFont;

@property (nonatomic) IBInspectable NSString *bannerTitle;
@property (nonatomic) IBInspectable CGFloat bannerHeight;

@property (nonatomic) UIButton *editButton;

@property (nonatomic) BOOL highlighted;
@property (nonatomic) BOOL selected;

@end
