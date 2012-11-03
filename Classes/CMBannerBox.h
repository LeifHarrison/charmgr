//
//  CMBannerBox.h
//  CharMgr
//
//  Created by Leif Harrison on 4/28/10.
//  Copyright 2010 Ubermind, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBannerBox : UIView
{
}

@property (nonatomic, strong) UIColor *bannerColor;
@property (nonatomic, strong) UIColor *bannerTextColor;
@property (nonatomic, strong) UIFont *bannerFont;

@property (nonatomic, strong) NSString *bannerTitle;
@property (nonatomic, assign) CGFloat bannerHeight;

@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, assign) BOOL selected;

@end
