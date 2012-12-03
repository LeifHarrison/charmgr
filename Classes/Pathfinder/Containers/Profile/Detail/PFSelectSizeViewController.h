//
//  PFSelectSizeViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 11/11/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFDetailViewController.h"

@interface PFSelectSizeViewController : PFDetailViewController
	<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
