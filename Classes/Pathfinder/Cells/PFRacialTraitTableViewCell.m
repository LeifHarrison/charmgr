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
		
		self.containerState = PFContainerViewStateStatic;
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
	
	self.containerState = PFContainerViewStateStatic;
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

//------------------------------------------------------------------------------
#pragma mark - Container State
//------------------------------------------------------------------------------

- (void)setContainerState:(PFContainerViewState)newState;
{
	[super setContainerState:newState];
	
	if (newState == PFContainerViewStateStatic) {
		self.traitDescriptionLabel.alpha = 0.0f;
	}
	else {
		self.traitDescriptionLabel.alpha = 1.0f;
	}
}

- (void)setContainerState:(PFContainerViewState)newState animated:(BOOL)animated;
{
	void (^animations) (void) = ^{
		self.containerState = newState;
    };
    void (^completion) (BOOL) = ^(BOOL finished) {
		self.containerState = newState;
    };
    [UIView animateWithDuration: (animated ? 0.3 : 0.0) animations:animations completion:completion];
}

+ (CGFloat)rowHeightForState:(PFContainerViewState)aState
					   trait:(PFRacialTrait*)aTrait
				   cellWidth:(CGFloat)cellWidth;
{
	if (aState == PFContainerViewStateStatic) {
		return 20;
	}
	else {
		CGFloat maxWidth = cellWidth - (2 * 10);
		CGSize descriptionSize = [aTrait.descriptionShort sizeWithFont:[UIFont systemFontOfSize:10]
													  constrainedToSize:CGSizeMake(maxWidth, 600)
														  lineBreakMode:NSLineBreakByWordWrapping];
		CGFloat height = 18 + descriptionSize.height + 2;
		return height;
	}
}

@end
