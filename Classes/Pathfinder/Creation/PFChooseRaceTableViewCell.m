//
//  PFChooseRaceTableViewCell.m
//  CharMgr
//
//  Created by Leif Harrison on 8/3/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "PFChooseRaceTableViewCell.h"

@implementation PFChooseRaceTableViewCell


- (void)prepareForReuse
{
	[super prepareForReuse];
	self.raceNameLabel.text = nil;
	self.raceDescriptionLabel.text = nil;
}

@end
