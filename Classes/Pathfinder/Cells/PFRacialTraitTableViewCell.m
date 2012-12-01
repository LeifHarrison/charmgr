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

//------------------------------------------------------------------------------
#pragma mark - NSCoding
//------------------------------------------------------------------------------

- (id)initWithCoder:(NSCoder *)aDecoder
{
	TRACE;
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
	TRACE;
	[super prepareForReuse];
	
	self.containerState = PFContainerViewStateStatic;
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
//		if (newState == PFContainerViewStateStatic) {
//			self.traitDescriptionLabel.alpha = 0.0f;
//		}
//		else {
//			self.traitDescriptionLabel.alpha = 1.0f;
//		}
    };
    void (^completion) (BOOL) = ^(BOOL finished) {
		self.containerState = newState;
    };
    [UIView animateWithDuration: (animated ? 0.3 : 0.0) animations:animations completion:completion];
}

+ (CGFloat)rowHeightForState:(PFContainerViewState)aState;
{
	if (aState == PFContainerViewStateStatic) {
		return 20;
	}
	else {
		return 30;
	}
}

@end
