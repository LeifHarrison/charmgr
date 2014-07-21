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
	//TRACE;
	[super prepareForReuse];
	
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

@end
