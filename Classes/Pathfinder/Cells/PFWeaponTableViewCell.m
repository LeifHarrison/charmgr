//
//  PFWeaponTableViewCell.m
//  CharMgr
//
//  Created by Leif Harrison on 3/16/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import "PFWeaponTableViewCell.h"

#define PFWeaponTableViewCellDividerHeight 2.0f
#define PFWeaponTableViewCellDividerInset  5.0f

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFWeaponTableViewCell ()

@property (nonatomic) UIView *dividerImageView;

@end


@implementation PFWeaponTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self createDivider];
    }
    return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	if (!self.dividerImageView) {
		[self createDivider];
	}
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat dividerY = CGRectGetMaxY(self.bounds) - PFWeaponTableViewCellDividerHeight;
	self.dividerImageView.frame = CGRectMake(PFWeaponTableViewCellDividerInset, dividerY,
											 CGRectGetMaxX(self.bounds) - (2*PFWeaponTableViewCellDividerInset), PFWeaponTableViewCellDividerHeight);
}

- (void)createDivider
{
	//self.dividerImageView = [[UIImageView alloc] initWithImage:nil];
	self.dividerImageView = [[UIView alloc] initWithFrame:CGRectZero];
	self.dividerImageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.dividerImageView.layer.borderWidth = 1.5f;
	[self addSubview:self.dividerImageView];	
}
@end
