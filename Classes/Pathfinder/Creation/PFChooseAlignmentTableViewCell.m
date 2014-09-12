//
//  PFChooseAlignmentTableViewCell.m
//  CharMgr
//
//  Created by Leif Harrison on 9/11/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "PFChooseAlignmentTableViewCell.h"

@implementation PFChooseAlignmentTableViewCell

- (void)prepareForReuse
{
	[super prepareForReuse];
	self.alignmentNameLabel.text = nil;
	self.alignmentDescriptionLabel.text = nil;
}

@end
