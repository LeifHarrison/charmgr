//
//  PFAbilityTableViewCell
//  CharMgr
//
//  Created by Leif Harrison on 10/18/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFContainerViewController.h" // for PFContainerViewState

@class PFCharacterAbility;

@interface PFAbilityTableViewCell : UITableViewCell

@property (nonatomic, strong) PFCharacterAbility *characterAbility;

@property (nonatomic, strong) IBOutlet UILabel *abilityNameLabel;
@property (nonatomic, strong) IBOutlet UITextField *abilityScoreTextField;
@property (nonatomic, strong) IBOutlet UITextField *abilityBonusTextField;
@property (nonatomic, strong) IBOutlet UITextField *temporaryScoreTextField;
@property (nonatomic, strong) IBOutlet UITextField *temporaryBonusTextField;
@property (nonatomic, strong) IBOutlet UIStepper *abilityStepper;

@property (nonatomic, assign) PFContainerViewState containerState;

- (IBAction)stepperValueChanged:(id)sender;

- (void)setContainerState:(PFContainerViewState)newState animated:(BOOL)animated;

@end
