//
//  PFSelectClassViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 11/18/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFDetailViewController.h"

#import <CoreData/CoreData.h>

@interface PFSelectClassViewController : PFDetailViewController
	<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
