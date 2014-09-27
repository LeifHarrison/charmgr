//
//  CMBannerBox.m
//  CharMgr
//
//  Created by Leif Harrison on 4/28/10.
//  Copyright 2010 Ubermind, Inc. All rights reserved.
//

#import "CMBannerBox.h"

#import "CGGeometry+CMExtensions.h"

#define PFDefaultBannerHeight 32.0f;

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface CMBannerBox ()

@property (nonatomic, strong) UILabel *bannerLabel;
@property (nonatomic, strong) UIView  *bannerBackground;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation CMBannerBox

//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

- (id)initWithFrame:(CGRect)frame
{
	TRACE;

    if ((self = [super initWithFrame:frame])) {
		[self setup];
    }
    return self;
}

- (void)awakeFromNib
{
	[self setup];
	[super awakeFromNib];
}

//------------------------------------------------------------------------------
#pragma mark - Implemented Properties
//------------------------------------------------------------------------------

- (void)setBannerTitle:(NSString *)aString
{
	if (_bannerTitle != aString)
	{
		_bannerTitle = aString;

		if (self.bannerLabel) {
			self.bannerLabel.text = aString;
		}
	}
}

- (void)setBannerFont:(UIFont *)aFont
{
	if (_bannerFont != aFont)
	{
		_bannerFont = aFont;
		
		if (self.bannerLabel) {
			self.bannerLabel.font = aFont;
		}
	}
}

- (void)setBannerColor:(UIColor *)aColor
{
	if (_bannerColor != aColor)
	{
		_bannerColor = aColor;
		
		if (self.bannerLabel) {
			self.bannerLabel.backgroundColor = aColor;
		}

		self.layer.borderColor =  aColor.CGColor;
		[self setNeedsDisplay];
	}
}

- (void)setBannerTextColor:(UIColor *)aColor
{
	if (_bannerTextColor != aColor)
	{
		_bannerTextColor = aColor;
		
		if (self.bannerLabel) {
			self.bannerLabel.textColor = aColor;
		}
	}
}

- (void)setBannerHeight:(CGFloat)bannerHeight
{
	if (_bannerHeight != bannerHeight)
	{
		_bannerHeight = bannerHeight;
		[self setNeedsLayout];
//		[self layoutIfNeeded];
	}

}

- (void)setHighlighted:(BOOL)highlighted
{
	//LOG_DEBUG(@"highlighted = %d", highlighted);
	if (highlighted != _highlighted) {
		_highlighted = highlighted;
		if (highlighted) {
			self.layer.borderColor = [UIColor lightGrayColor].CGColor;
			self.bannerLabel.backgroundColor = [UIColor lightGrayColor];
		}
		else {
			self.layer.borderColor = self.bannerColor.CGColor;
			self.bannerLabel.backgroundColor = self.bannerColor;
		}
		[self setNeedsDisplay];
	}
}

- (void)setSelected:(BOOL)selected
{
	LOG_DEBUG(@"selected = %d", selected);
	if (selected != _selected) {
		_selected = selected;
		if (selected) {
			self.layer.borderColor = [UIColor darkGrayColor].CGColor;
			self.bannerBackground.backgroundColor = [UIColor darkGrayColor];
		}
		else {
			self.layer.borderColor = self.bannerColor.CGColor;
			self.bannerBackground.backgroundColor = self.bannerColor;
		}
		
//		CGRect bannerFrame = self.bannerBackground.frame;
//		bannerFrame.size.height = self.bannerHeight;
//		self.bannerBackground.frame = bannerFrame;
//		
//		self.bannerLabel.frame = CGRectCenteredInRect(self.bannerLabel.frame, bannerFrame);
//		[self setNeedsDisplay];
	}
}

//------------------------------------------------------------------------------
#pragma mark - Private
//------------------------------------------------------------------------------

- (void)setup
{
	self.clipsToBounds = YES;

	self.bannerColor = [UIColor colorWithWhite:0.2 alpha:1.0];
	self.bannerTextColor = [UIColor whiteColor];
	self.bannerFont = [UIFont fontWithName:@"Marker Felt" size:18.0];
	self.bannerHeight = PFDefaultBannerHeight;

	self.layer.borderColor = self.bannerColor.CGColor;
	self.layer.borderWidth = 1.5;
	self.layer.cornerRadius = 8.0;
}

- (void)layoutSubviews
{
	[super layoutSubviews];

	if (!self.bannerLabel) {
		[self createBannerLabel];
	}

	CGRect bannerRect, contentRect;
	CGRectDivide(self.bounds, &bannerRect, &contentRect, self.bannerHeight, CGRectMinYEdge);
	self.bannerBackground.frame = bannerRect;
	self.bannerLabel.frame = bannerRect;
}

- (void)createBannerLabel
{
	CGRect bannerRect, contentRect;
	CGRectDivide(self.bounds, &bannerRect, &contentRect, self.bannerHeight, CGRectMinYEdge);

	self.bannerBackground = [[UIView alloc] initWithFrame:bannerRect];
	self.bannerBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	self.bannerBackground.backgroundColor = self.bannerColor;
	//LOG_DEBUG(@" frame = %@", NSStringFromCGRect(frame));
	//LOG_DEBUG(@" bannerRect = %@", NSStringFromCGRect(bannerRect));
	//LOG_DEBUG(@" contentRect = %@", NSStringFromCGRect(contentRect));
	[self addSubview:self.bannerBackground];

	self.bannerLabel = [[UILabel alloc] initWithFrame:bannerRect];
	//self.bannerLabel.autoresizingMask = UIViewAutoresizingNone;
	self.bannerLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	//self.bannerLabel.layer.borderColor = [UIColor redColor].CGColor;
	//self.bannerLabel.layer.borderWidth = 1.0f;
	self.bannerLabel.font = self.bannerFont;
	self.bannerLabel.backgroundColor = [UIColor clearColor];
	self.bannerLabel.textColor = [UIColor whiteColor];
	self.bannerLabel.text = self.bannerTitle;
	self.bannerLabel.textAlignment = NSTextAlignmentCenter;
	[self.bannerBackground addSubview:self.bannerLabel];
}

- (void)createEditButton
{
	self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.editButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.editButton.layer.borderWidth = 1;
	self.editButton.layer.cornerRadius = 9.0;
	self.editButton.backgroundColor = [UIColor lightGrayColor];
	//self.editButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	self.editButton.translatesAutoresizingMaskIntoConstraints = NO;
	self.editButton.titleLabel.font = [UIFont systemFontOfSize:12];
	[self.editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
	[self.editButton setTitle:@"edit" forState:UIControlStateNormal];
	self.editButton.hidden = YES;
	[self.editButton sizeToFit];
	[self.bannerBackground addSubview:self.editButton];

	NSDictionary* views = @{ @"editButton" : self.editButton };
	[self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[editButton]-5-|"
																				  options:0
																				  metrics:nil
																					views:views]];

	[self.bannerBackground addConstraint:[NSLayoutConstraint constraintWithItem:self.editButton
																	  attribute:NSLayoutAttributeCenterY
																	  relatedBy:NSLayoutRelationEqual
																		 toItem:self.bannerBackground
																	  attribute:NSLayoutAttributeCenterY
																	 multiplier:1.0
																	   constant:0]];

	[self.editButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[editButton(20)]"
																			options:0
																			metrics:nil
																			  views:views]];
	[self.editButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[editButton(55)]"
																			options:0
																			metrics:nil
																			  views:views]];
}
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//LOG_DEBUG(@"event = %@", event);
	[super touchesBegan:touches withEvent:event];
	if (!self.selected) {
		self.highlighted = YES;
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	//LOG_DEBUG(@"event = %@", event);
	[super touchesCancelled:touches withEvent:event];
	self.highlighted = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//LOG_DEBUG(@"event = %@", event);
	[super touchesEnded:touches withEvent:event];
	self.highlighted = NO;
}
*/
@end
