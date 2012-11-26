//
//  PFRacialTraitTableViewCell.m
//  CharMgr
//
//  Created by Leif Harrison on 10/30/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFRacialTraitTableViewCell.h"

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFRacialTraitTableViewCell

//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

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

@end
