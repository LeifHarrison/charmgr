//
//  PFClassesViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 10/12/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerViewController.h"

#import "PFDetailViewController.h"

@interface PFClassesViewController : PFContainerViewController
	<UIPopoverControllerDelegate, PFDetailViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITextField *levelAdjustmentTextField;
@property (nonatomic, strong) IBOutlet UITextField *effectiveLevelTextField;
@property (nonatomic, strong) IBOutlet UILabel *currentXPLabel;
@property (nonatomic, strong) IBOutlet UILabel *nextLevelXPLabel;

@end
