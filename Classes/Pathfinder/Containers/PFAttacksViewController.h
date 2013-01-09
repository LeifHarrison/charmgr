//
//  PFAttacksViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerViewController.h"

@interface PFAttacksViewController : PFContainerViewController

@property (nonatomic, strong) IBOutlet UILabel *initiativeTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *initiativeSubtitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *initiativeField;
@property (nonatomic, strong) IBOutlet UITextField *initiativeDexterityField;
@property (nonatomic, strong) IBOutlet UITextField *initiativeFeatsField;
@property (nonatomic, strong) IBOutlet UITextField *initiativeTrainingField;
@property (nonatomic, strong) IBOutlet UITextField *initiativeMiscField;

@property (nonatomic, strong) IBOutlet UILabel *baseAttackTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *baseAttackSubtitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *baseAttackField;

@property (nonatomic, strong) IBOutlet UILabel *numberOfAttacksTitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *numberOfAttacksField;

@property (nonatomic, strong) IBOutlet UILabel *meleeAttackTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *meleeAttackSubtitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *meleeAttackField;
@property (nonatomic, strong) IBOutlet UITextField *meleeAttackBaseField;
@property (nonatomic, strong) IBOutlet UITextField *meleeAttackStrengthField;
@property (nonatomic, strong) IBOutlet UITextField *meleeAttackSizeField;

@property (nonatomic, strong) IBOutlet UILabel *rangedAttackTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *rangedAttackSubtitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *rangedAttackField;
@property (nonatomic, strong) IBOutlet UITextField *rangedAttackBaseField;
@property (nonatomic, strong) IBOutlet UITextField *rangedAttackDexterityField;
@property (nonatomic, strong) IBOutlet UITextField *rangedAttackSizeField;

@property (nonatomic, strong) IBOutlet UILabel *cmbTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *cmbSubtitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *cmbField;
@property (nonatomic, strong) IBOutlet UITextField *cmbStrengthModifierField;
@property (nonatomic, strong) IBOutlet UITextField *cmbBaseAttackBonusField;
@property (nonatomic, strong) IBOutlet UITextField *cmbSizeModifierField;
@property (nonatomic, strong) IBOutlet UITextField *cmbMiscModifierField;

@property (nonatomic, strong) IBOutlet UIView *editingContainer;

@end
