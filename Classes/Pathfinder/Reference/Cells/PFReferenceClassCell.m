//
//  PFReferenceClassCell.m
//  CharMgr
//
//  Created by Leif Harrison on 7/22/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "PFReferenceClassCell.h"

@implementation PFReferenceClassCell

- (void)prepareForReuse
{
	[super prepareForReuse];
	self.classNameLabel.text = nil;
	self.sourceLabel.text = nil;
	self.hitDieTypeLabel.text = nil;
	self.alignmentLabel.text = nil;
	self.descriptionLabel.text = nil;
}

@end
