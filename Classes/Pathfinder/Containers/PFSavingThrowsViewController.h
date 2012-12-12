//
//  PFSavingThrowsViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerViewController.h"

@interface PFSavingThrowsViewController : PFContainerViewController

@property (nonatomic, strong) IBOutlet UILabel *fortitudeSaveLabel;
@property (nonatomic, strong) IBOutlet UITextField *fortitudeSaveField;
@property (nonatomic, strong) IBOutlet UILabel *reflexSaveLabel;
@property (nonatomic, strong) IBOutlet UITextField *reflexSaveField;
@property (nonatomic, strong) IBOutlet UILabel *willSaveLabel;
@property (nonatomic, strong) IBOutlet UITextField *willSaveField;

@property (nonatomic, strong) IBOutlet UIView *editingContainer;

@property (nonatomic, strong) IBOutlet UITextField *fortitudeBaseField;
@property (nonatomic, strong) IBOutlet UITextField *fortitudeAbilityField;
@property (nonatomic, strong) IBOutlet UITextField *fortitudeRacialField;
@property (nonatomic, strong) IBOutlet UITextField *fortitudeMiscField;
@property (nonatomic, strong) IBOutlet UITextField *fortitudeTempField;

@property (nonatomic, strong) IBOutlet UITextField *reflexBaseField;
@property (nonatomic, strong) IBOutlet UITextField *reflexAbilityField;
@property (nonatomic, strong) IBOutlet UITextField *reflexRacialField;
@property (nonatomic, strong) IBOutlet UITextField *reflexMiscField;
@property (nonatomic, strong) IBOutlet UITextField *reflexTempField;

@property (nonatomic, strong) IBOutlet UITextField *willBaseField;
@property (nonatomic, strong) IBOutlet UITextField *willAbilityField;
@property (nonatomic, strong) IBOutlet UITextField *willRacialField;
@property (nonatomic, strong) IBOutlet UITextField *willMiscField;
@property (nonatomic, strong) IBOutlet UITextField *willTempField;

@end
