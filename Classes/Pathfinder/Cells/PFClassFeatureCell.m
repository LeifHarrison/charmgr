//
//  PFClassFeatureCell.m
//  CharMgr
//
//  Created by Leif Harrison on 12/1/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFClassFeatureCell.h"

@implementation PFClassFeatureCell

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

//------------------------------------------------------------------------------
#pragma mark - NSCoding
//------------------------------------------------------------------------------

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		//self.layer.borderColor = [UIColor redColor].CGColor;
		//self.layer.borderWidth = 1.0f;
		
	}
	return self;
}

//------------------------------------------------------------------------------
#pragma mark - Selection
//------------------------------------------------------------------------------

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

//------------------------------------------------------------------------------
#pragma mark - Reuse
//------------------------------------------------------------------------------

- (void)prepareForReuse
{
	[super prepareForReuse];
	
}

@end
