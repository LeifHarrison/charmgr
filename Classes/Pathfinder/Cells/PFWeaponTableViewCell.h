//
//  PFWeaponTableViewCell.h
//  CharMgr
//
//  Created by Leif Harrison on 3/16/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import "PFContainerCell.h"

@interface PFWeaponTableViewCell : PFContainerCell

@property (nonatomic, strong) IBOutlet UILabel *weaponNameLabel;
@property (nonatomic, strong) IBOutlet UITextField *attackBonusTextField;
@property (nonatomic, strong) IBOutlet UITextField *damageTextField;
@property (nonatomic, strong) IBOutlet UILabel *rangeLabel;
@property (nonatomic, strong) IBOutlet UILabel *typeLabel;
@property (nonatomic, strong) IBOutlet UILabel *specialLabel;
@property (nonatomic, strong) IBOutlet UITextField *criticalTextField;

@end
