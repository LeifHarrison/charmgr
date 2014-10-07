//
//  PFEditCharacterViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 7/16/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "PFEditContainerViewController.h"

#import "PFDetailViewController.h"

@interface PFEditCharacterViewController : PFEditContainerViewController <UIPopoverControllerDelegate, PFDetailViewControllerDelegate>

@property (nonatomic) IBOutlet UITextField *characterField;
@property (nonatomic) IBOutlet UITextField *playerField;
@property (nonatomic) IBOutlet UITextField *campaignField;

@property (nonatomic) IBOutlet UIButton *alignmentButton;
@property (nonatomic) IBOutlet UIButton *genderButton;
@property (nonatomic) IBOutlet UIButton *raceButton;
@property (nonatomic) IBOutlet UIButton *sizeButton;

@end
