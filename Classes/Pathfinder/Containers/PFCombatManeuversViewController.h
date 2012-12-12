//
//  PFCombatManeuversViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerViewController.h"

@interface PFCombatManeuversViewController : PFContainerViewController

@property (nonatomic, strong) IBOutlet UILabel *cmbTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *cmbSubtitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *cmbField;
@property (nonatomic, strong) IBOutlet UITextField *cmbStrengthModifierField;
@property (nonatomic, strong) IBOutlet UITextField *cmbBaseAttackBonusField;
@property (nonatomic, strong) IBOutlet UITextField *cmbSizeModifierField;
@property (nonatomic, strong) IBOutlet UITextField *cmbMiscModifierField;

@property (nonatomic, strong) IBOutlet UILabel *cmdTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *cmdSubtitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *cmdField;
@property (nonatomic, strong) IBOutlet UITextField *cmdStrengthModifierField;
@property (nonatomic, strong) IBOutlet UITextField *cmdDexterityModifierField;
@property (nonatomic, strong) IBOutlet UITextField *cmdDodgeModifierField;
@property (nonatomic, strong) IBOutlet UITextField *cmdDeflectionModifierField;
@property (nonatomic, strong) IBOutlet UITextField *cmdBaseAttackBonusField;
@property (nonatomic, strong) IBOutlet UITextField *cmdSizeModifierField;
@property (nonatomic, strong) IBOutlet UITextField *cmdMiscModifierField;

@property (nonatomic, strong) IBOutlet UILabel *flatFootedCMDTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *flatFootedCMDSubtitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDStrengthModifierField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDDeflectionModifierField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDBaseAttackBonusField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDSizeModifierField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDMiscModifierField;

@property (nonatomic, strong) IBOutlet UIView *editingContainer;

@end
