//
//  PFAbilityTableViewCell
//  CharMgr
//
//  Created by Leif Harrison on 10/18/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerCell.h"

@class PFCharacterAbility;

@interface PFAbilityTableViewCell : PFContainerCell

@property (nonatomic, strong) PFCharacterAbility *characterAbility;

@property (nonatomic, strong) IBOutlet UILabel *abilityNameLabel;
@property (nonatomic, strong) IBOutlet UITextField *abilityScoreTextField;
@property (nonatomic, strong) IBOutlet UITextField *abilityBonusTextField;
@property (nonatomic, strong) IBOutlet UITextField *temporaryScoreTextField;
@property (nonatomic, strong) IBOutlet UITextField *temporaryBonusTextField;
@property (nonatomic, strong) IBOutlet UIStepper *abilityStepper;

- (IBAction)stepperValueChanged:(id)sender;

@end
