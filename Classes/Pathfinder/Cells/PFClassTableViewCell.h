//
//  PFClassTableViewCell.h
//  CharMgr
//
//  Created by Leif Harrison on 10/17/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerCell.h"

#import "PFCharacterClass.h"

@interface PFClassTableViewCell : PFContainerCell

@property (nonatomic, strong) PFCharacterClass *characterClass;

@property (nonatomic, strong) IBOutlet UILabel *classNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *hitDieTypeLabel;
@property (nonatomic, strong) IBOutlet UILabel *skillRanksLabel;

@property (nonatomic, strong) IBOutlet UITextField *levelTextField;
@property (nonatomic, strong) IBOutlet UIStepper *levelStepper;

- (IBAction)stepperValueChanged:(id)sender;

@end
