//
//  PFSkillTableViewCell.m
//  CharMgr
//
//  Created by Leif Harrison on 10/18/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFSkillTableViewCell.h"

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFSkillTableViewCell

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
	//self.skillRanksTextField.layer.borderColor = [UIColor clearColor].CGColor;
	//self.skillRanksStepper.alpha = 0.0;
	self.characterSkill = nil;
}

//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (IBAction)stepperValueChanged:(id)sender;
{
	LOG_DEBUG(@"value = %0.0lf", self.skillRanksStepper.value);
	self.characterSkill.ranks = (int16_t)self.skillRanksStepper.value;
	self.skillRanksTextField.text = [NSString stringWithFormat:@"%d", self.characterSkill.ranks];
	self.skillBonusLabel.text = [self.characterSkill skillBonusString];
}

//------------------------------------------------------------------------------
#pragma mark - Container State
//------------------------------------------------------------------------------

- (void)setContainerState:(PFContainerViewState)newState;
{
	//LOG_DEBUG(@"newState = %d", newState);
	if (newState != _containerState) {
		_containerState = newState;
	}
	
	if (newState == PFContainerViewStateEditing) {
		self.skillRanksTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;
		//CGRect levelFrame = self.levelTextField.frame;
		//levelFrame.origin.y = 2; levelFrame.size.height = 27;
		//self.levelTextField.frame = levelFrame;
		self.skillRanksStepper.alpha = 1.0;
	}
	else {
		self.skillRanksTextField.layer.borderColor = [UIColor clearColor].CGColor;
		//CGRect levelFrame = self.levelTextField.frame;
		//levelFrame.origin.y = 0; levelFrame.size.height = 21;
		//self.levelTextField.frame = levelFrame;
		self.skillRanksStepper.alpha = 0.0;
	}
}

- (void)setContainerState:(PFContainerViewState)newState animated:(BOOL)animated;
{
	LOG_DEBUG(@"newState = %d, animated = %d", newState, animated);
	void (^animations) (void) = ^{
		self.containerState = newState;
    };
    void (^completion) (BOOL) = ^(BOOL finished) {
		self.containerState = newState;
    };
    [UIView animateWithDuration: (animated ? 0.3 : 0.0) animations:animations completion:completion];
}

@end
