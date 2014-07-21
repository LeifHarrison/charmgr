//
//  PFRacialTraitTableViewCell.m
//  CharMgr
//
//  Created by Leif Harrison on 10/30/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFRacialTraitTableViewCell.h"

#import "PFRacialTrait.h"

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

//------------------------------------------------------------------------------
#pragma mark - Layout
//------------------------------------------------------------------------------

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGRect descriptionRect = self.traitDescriptionLabel.frame;
	NSString *descriptionText = self.traitDescriptionLabel.text;
	CGSize descriptionSize = [descriptionText sizeWithFont:self.traitDescriptionLabel.font
												 constrainedToSize:CGSizeMake(descriptionRect.size.width, 600)
													 lineBreakMode:NSLineBreakByWordWrapping];
	descriptionRect.size.height = descriptionSize.height;
	self.traitDescriptionLabel.frame = descriptionRect;
}

@end
