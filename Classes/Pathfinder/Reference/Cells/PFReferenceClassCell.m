//
//  PFReferenceClassCell.m
//  CharMgr
//
//  Created by Leif Harrison on 7/22/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "PFReferenceClassCell.h"

@implementation PFReferenceClassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
