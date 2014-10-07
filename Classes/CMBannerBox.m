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

@property (nonatomic) UILabel *bannerLabel;
@property (nonatomic) UIView  *bannerBackground;

@property (nonatomic, readwrite) UIButton* leftButton;
@property (nonatomic, readwrite) UIButton* rightButton;

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
		self.bannerHeight = PFDefaultBannerHeight;
		[self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		if (self.bannerHeight < 0) self.bannerHeight = PFDefaultBannerHeight;
	}

	return self;
}
//------------------------------------------------------------------------------
#pragma mark - Nib Loading
//------------------------------------------------------------------------------

- (void)awakeFromNib
{
	[self setup];
	[super awakeFromNib];
	//LOG_DEBUG(@" bannerHeight = %lf", self.bannerHeight);
}

//- (void)prepareForInterfaceBuilder
//{
//	[super prepareForInterfaceBuilder];
//}

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
	}
}

//------------------------------------------------------------------------------
#pragma mark - Layout
//------------------------------------------------------------------------------

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

//------------------------------------------------------------------------------
#pragma mark - Private
//------------------------------------------------------------------------------

- (void)setup
{
	self.clipsToBounds = YES;

	self.bannerColor = [UIColor colorWithWhite:0.2 alpha:1.0];
	self.bannerTextColor = [UIColor whiteColor];
	self.bannerFont = [UIFont fontWithName:@"Marker Felt" size:18.0];
//	self.bannerHeight = PFDefaultBannerHeight;

	self.layer.borderColor = self.bannerColor.CGColor;
	self.layer.borderWidth = 1.5;
	self.layer.cornerRadius = 8.0;

	if (!self.bannerLabel) {
		[self createBannerLabel];
	}
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

- (UIButton *)buttonWithTitle:(NSString*)title
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.layer.borderColor = [UIColor darkGrayColor].CGColor;
	button.layer.borderWidth = 1;
	button.layer.cornerRadius = 9.0;
	button.alpha = 0.0f;
	button.backgroundColor = [UIColor lightGrayColor];
	button.translatesAutoresizingMaskIntoConstraints = NO;
	button.titleLabel.font = [UIFont systemFontOfSize:12];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
	[button setTitle:title forState:UIControlStateNormal];
	[button sizeToFit];

	return button;
}

- (void)addLeftButtonWithTitle:(NSString*)title
						target:(id)target
						action:(SEL)action
					  animated:(BOOL)animated;
{
	self.leftButton = [self buttonWithTitle:title];
	[self.leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	[self.bannerBackground addSubview:self.leftButton];

	CGFloat buttonWidth = self.leftButton.bounds.size.width + 10;

	NSDictionary* views = @{ @"button" : self.leftButton };
	NSDictionary* metrics = @{ @"buttonWidth" : [NSNumber numberWithFloat:buttonWidth] };
	[self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[button(buttonWidth)]-(>=0)-|"
																				  options:0
																				  metrics:metrics
																					views:views]];
	[self.leftButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(25)]"
																			options:0
																			metrics:nil
																			  views:views]];

	[self.bannerBackground addConstraint:[NSLayoutConstraint constraintWithItem:self.leftButton
																	  attribute:NSLayoutAttributeCenterY
																	  relatedBy:NSLayoutRelationEqual
																		 toItem:self.bannerBackground
																	  attribute:NSLayoutAttributeCenterY
																	 multiplier:1.0
																	   constant:0]];

	if (animated) {

	}
	else {
		self.leftButton.alpha = 1.0f;
	}
}

- (void)addRightButtonWithTitle:(NSString*)title
						 target:(id)target
						 action:(SEL)action
					   animated:(BOOL)animated;
{
	self.rightButton = [self buttonWithTitle:title];
	[self.rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	[self.bannerBackground addSubview:self.rightButton];

	CGFloat buttonWidth = self.leftButton.bounds.size.width + 10;

	NSDictionary* views = @{ @"button" : self.rightButton };
	NSDictionary* metrics = @{ @"buttonWidth" : [NSNumber numberWithFloat:buttonWidth] };
	[self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[button(buttonWidth)]-5-|"
																				  options:0
																				  metrics:metrics
																					views:views]];
	[self.rightButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(25)]"
																	   options:0
																	   metrics:nil
																			   views:views]];

	[self.bannerBackground addConstraint:[NSLayoutConstraint constraintWithItem:self.rightButton
																	  attribute:NSLayoutAttributeCenterY
																	  relatedBy:NSLayoutRelationEqual
																		 toItem:self.bannerBackground
																	  attribute:NSLayoutAttributeCenterY
																	 multiplier:1.0
																	   constant:0]];

	if (animated) {

	}
	else {
		self.rightButton.alpha = 1.0f;
	}
}

//------------------------------------------------------------------------------
#pragma mark - Event Handling
//------------------------------------------------------------------------------

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//LOG_DEBUG(@"event = %@", event);
	[super touchesBegan:touches withEvent:event];
	if (self.highlightWhenTapped) self.alpha = 0.8f;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	//LOG_DEBUG(@"event = %@", event);
	[super touchesCancelled:touches withEvent:event];
	if (self.highlightWhenTapped) self.alpha = 1.0f;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//LOG_DEBUG(@"event = %@", event);
	[super touchesEnded:touches withEvent:event];
	if (self.highlightWhenTapped) self.alpha = 1.0f;
}

@end
