//
//  PFChooseClassTableViewCell.m
//  CharMgr
//
//  Created by Leif Harrison on 9/8/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "PFChooseClassTableViewCell.h"

@implementation PFChooseClassTableViewCell

- (void)prepareForReuse
{
	[super prepareForReuse];
	self.classNameLabel.text = nil;
	self.classDescriptionLabel.text = nil;
}

@end
