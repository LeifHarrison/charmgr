//
//  PFAbilityTableViewCell
//  CharMgr
//
//  Created by Leif Harrison on 10/18/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFAbilityTableViewCell.h"

#import "PFCharacterAbility.h"

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFAbilityTableViewCell

//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	TRACE;
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
	self.abilityStepper.alpha = 0.0;
	self.characterAbility = nil;
	self.abilityScoreTextField.text = @"";
	self.abilityBonusTextField.text = @"";
}

//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (IBAction)stepperValueChanged:(id)sender;
{
	LOG_DEBUG(@"value = %0.2lf", self.abilityStepper.value);
	self.characterAbility.abilityScore = [NSNumber numberWithInt:(int)self.abilityStepper.value];
	self.abilityScoreTextField.text = self.characterAbility.abilityScore.stringValue;
	self.abilityBonusTextField.text = self.characterAbility.abilityBonus.stringValue;
}

//------------------------------------------------------------------------------
#pragma mark - Container State
//------------------------------------------------------------------------------

- (void)setContainerState:(PFContainerViewState)newState;
{
	[super setContainerState:newState];

	if (newState == PFContainerViewStateEditing) {
		self.abilityStepper.alpha = 1.0;
	}
	else {
		self.abilityStepper.alpha = 0.0;
	}
}

- (void)setContainerState:(PFContainerViewState)newState animated:(BOOL)animated;
{
	void (^animations) (void) = ^{
		if (newState == PFContainerViewStateEditing) {
			self.abilityStepper.alpha = 1.0;
		}
		else {
			self.abilityStepper.alpha = 0.0;
		}
    };
    void (^completion) (BOOL) = ^(BOOL finished) {
		self.containerState = newState;
    };
    [UIView animateWithDuration: (animated ? 0.3 : 0.0) animations:animations completion:completion];
}

@end
