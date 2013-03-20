//
//  PFWeaponsViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/20/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerViewController.h"

#import "PFDetailViewController.h"

@interface PFWeaponsViewController : PFContainerViewController
	<UIPopoverControllerDelegate, PFDetailViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
