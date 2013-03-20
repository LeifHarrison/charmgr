//
//  PFDefenseViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerViewController.h"

@interface PFDefenseViewController : PFContainerViewController

@property (nonatomic, strong) IBOutlet UILabel *armorClassTitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *armorClassField;
@property (nonatomic, strong) IBOutlet UITextField *armorClassDexterityField;
@property (nonatomic, strong) IBOutlet UITextField *armorClassDodgeField;
@property (nonatomic, strong) IBOutlet UITextField *armorClassDeflectionField;
@property (nonatomic, strong) IBOutlet UITextField *armorClassArmorField;
@property (nonatomic, strong) IBOutlet UITextField *armorClassShieldField;
@property (nonatomic, strong) IBOutlet UITextField *armorClassNaturalArmorField;
@property (nonatomic, strong) IBOutlet UITextField *armorClassSizeField;
//@property (nonatomic, strong) IBOutlet UITextField *armorClassEnhancementField;

@property (nonatomic, strong) IBOutlet UILabel *flatFootedACTitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedACField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedACDeflectionField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedACArmorField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedACShieldField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedACNaturalArmorField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedACSizeField;
//@property (nonatomic, strong) IBOutlet UITextField *flatFootedACEnhancementField;

@property (nonatomic, strong) IBOutlet UILabel *touchACTitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *touchACField;
@property (nonatomic, strong) IBOutlet UITextField *touchACDexterityField;
@property (nonatomic, strong) IBOutlet UITextField *touchACDodgeField;
@property (nonatomic, strong) IBOutlet UITextField *touchACDeflectionField;
@property (nonatomic, strong) IBOutlet UITextField *touchACSizeField;
//@property (nonatomic, strong) IBOutlet UITextField *touchACEnhancementField;

@property (nonatomic, strong) IBOutlet UILabel *cmdTitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *cmdField;
@property (nonatomic, strong) IBOutlet UITextField *cmdStrengthField;
@property (nonatomic, strong) IBOutlet UITextField *cmdDexterityField;
@property (nonatomic, strong) IBOutlet UITextField *cmdDodgeField;
@property (nonatomic, strong) IBOutlet UITextField *cmdDeflectionField;
@property (nonatomic, strong) IBOutlet UITextField *cmdBaseAttackField;
@property (nonatomic, strong) IBOutlet UITextField *cmdSizeField;
@property (nonatomic, strong) IBOutlet UITextField *cmdMiscField;

@property (nonatomic, strong) IBOutlet UILabel *flatFootedCMDTitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDStrengthField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDDeflectionField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDBaseAttackField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDSizeField;
@property (nonatomic, strong) IBOutlet UITextField *flatFootedCMDMiscField;

@property (nonatomic, strong) IBOutlet UIView *editingContainer;

@end
