//
//  PFClassTableViewCell.m
//  CharMgr
//
//  Created by Leif Harrison on 10/17/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFClassTableViewCell.h"

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFClassTableViewCell

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
		self.levelTextField.layer.borderColor = [UIColor clearColor].CGColor;
		self.levelTextField.layer.borderWidth = 1.0f;
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
	self.levelTextField.layer.borderColor = [UIColor clearColor].CGColor;
	self.levelStepper.alpha = 0.0;
	self.characterClass = nil;
	self.classNameLabel.text = @"";
	self.hitDieTypeLabel.text = @"";
	self.skillRanksLabel.text = @"";
	self.levelTextField.text = @"";
	self.levelStepper.value = 1.0f;
}

//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (IBAction)stepperValueChanged:(id)sender;
{
	LOG_DEBUG(@"value = %0.0lf", self.levelStepper.value);
	self.characterClass.level = (int16_t)self.levelStepper.value;
	self.levelTextField.text = [NSString stringWithFormat:@"%d", self.characterClass.level];
}

//------------------------------------------------------------------------------
#pragma mark - Container State
//------------------------------------------------------------------------------

- (void)setContainerState:(PFContainerViewState)newState;
{
	if (newState != _containerState) {
		_containerState = newState;
	}

	if (newState == PFContainerViewStateEditing) {
		self.levelTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;
		self.levelTextField.layer.borderWidth = 1.0f;
		//CGRect levelFrame = self.levelTextField.frame;
		//levelFrame.origin.y = 2; levelFrame.size.height = 27;
		//self.levelTextField.frame = levelFrame;
		self.levelStepper.alpha = 1.0;
	}
	else {
		self.levelTextField.layer.borderColor = [UIColor clearColor].CGColor;
		//CGRect levelFrame = self.levelTextField.frame;
		//levelFrame.origin.y = 0; levelFrame.size.height = 21;
		//self.levelTextField.frame = levelFrame;
		self.levelStepper.alpha = 0.0;
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

@end
