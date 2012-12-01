//
//  PFContainerCell.m
//  CharMgr
//
//  Created by Leif Harrison on 11/30/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerCell.h"

@implementation PFContainerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContainerState:(PFContainerViewState)newState animated:(BOOL)animated;
{
	// Default implementation just sets the container state
	[self setContainerState:newState];
	
	// Subclasses should not call super, but should instead call
	// [self setContainerState:newState] in the animation block and/or the
	// completion block of any animations
}


@end
