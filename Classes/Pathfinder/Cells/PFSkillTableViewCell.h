//
//  PFSkillTableViewCell.h
//  CharMgr
//
//  Created by Leif Harrison on 10/18/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerCell.h"

#import "PFCharacterSkill.h"

@interface PFSkillTableViewCell : PFContainerCell

@property (nonatomic, strong) PFCharacterSkill *characterSkill;

@property (nonatomic, strong) IBOutlet UILabel *skillNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *skillBonusLabel;
@property (nonatomic, strong) IBOutlet UILabel *classSkillLabel;
@property (nonatomic, strong) IBOutlet UILabel *abilityAbbreviationLabel;
@property (nonatomic, strong) IBOutlet UILabel *abilityModifierLabel;
@property (nonatomic, strong) IBOutlet UILabel *otherModifierLabel;

@property (nonatomic, strong) IBOutlet UITextField *skillRanksTextField;
@property (nonatomic, strong) IBOutlet UIStepper *skillRanksStepper;

- (IBAction)stepperValueChanged:(id)sender;

@end
