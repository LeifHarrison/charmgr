//
//  PFEditCharacterViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 7/16/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "PFContainerViewController.h"

@interface PFEditCharacterViewController : PFContainerViewController

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *titleLabels;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *valueFields;

@property (nonatomic, strong) IBOutlet UITextField *characterField;
@property (nonatomic, strong) IBOutlet UITextField *playerField;
@property (nonatomic, strong) IBOutlet UITextField *campaignField;

@property (nonatomic, strong) IBOutlet UIButton *alignmentButton;
@property (nonatomic, strong) IBOutlet UIButton *genderButton;
@property (nonatomic, strong) IBOutlet UIButton *raceButton;
@property (nonatomic, strong) IBOutlet UIButton *sizeButton;

@end
