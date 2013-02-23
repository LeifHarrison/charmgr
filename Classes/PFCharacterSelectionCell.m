//
//  PFCharacterSelectionCell.m
//  CharMgr
//
//  Created by Leif Harrison on 2/20/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import "PFCharacterSelectionCell.h"

@implementation PFCharacterSelectionCell

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
