//
//  PFSkillTableViewCell.h
//  CharMgr
//
//  Created by Leif Harrison on 10/18/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFSkillTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *skillNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *skillBonusLabel;
@property (nonatomic, strong) IBOutlet UILabel *classSkillLabel;
@property (nonatomic, strong) IBOutlet UILabel *skillRanksLabel;
@property (nonatomic, strong) IBOutlet UILabel *abilityAbbreviationLabel;
@property (nonatomic, strong) IBOutlet UILabel *abilityModifierLabel;
@property (nonatomic, strong) IBOutlet UILabel *otherModifierLabel;

@end
