//
//  PFClassTableViewCell.h
//  CharMgr
//
//  Created by Leif Harrison on 10/17/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFContainerViewController.h" // for PFContainerViewState

#import "PFCharacterClass.h"

@interface PFClassTableViewCell : UITableViewCell

@property (nonatomic, strong) PFCharacterClass *characterClass;

@property (nonatomic, strong) IBOutlet UILabel *classNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *hitDieTypeLabel;
@property (nonatomic, strong) IBOutlet UILabel *skillRanksLabel;

@property (nonatomic, strong) IBOutlet UITextField *levelTextField;
@property (nonatomic, strong) IBOutlet UIStepper *levelStepper;

@property (nonatomic, assign) PFContainerViewState containerState;

- (IBAction)stepperValueChanged:(id)sender;

- (void)setContainerState:(PFContainerViewState)newState animated:(BOOL)animated;

@end
