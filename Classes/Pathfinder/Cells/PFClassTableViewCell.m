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

@end
