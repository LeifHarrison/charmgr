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
	//TRACE;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

//------------------------------------------------------------------------------
#pragma mark - Reuse
//------------------------------------------------------------------------------

- (void)prepareForReuse
{
	//TRACE;
	[super prepareForReuse];
	
	self.characterAbility = nil;
	self.abilityScoreTextField.text = @"";
	self.abilityBonusTextField.text = @"";
}

@end
