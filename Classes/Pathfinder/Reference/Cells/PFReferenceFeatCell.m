//
//  PFReferenceFeatCell.m
//  CharMgr
//
//  Created by Leif Harrison on 11/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFReferenceFeatCell.h"

@implementation PFReferenceFeatCell

- (void)prepareForReuse
{
	[super prepareForReuse];
	self.featNameLabel.text = nil;
	self.featSourceLabel.text = nil;
	self.featTypeLabel.text = nil;
	self.prerequisitesLabel.text = nil;
	self.benefitLabel.text = nil;
}

@end
