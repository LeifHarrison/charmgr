//
//  PFSelectWeaponViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 3/17/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import "PFDetailViewController.h"

#import <CoreData/CoreData.h>

@interface PFSelectWeaponViewController : PFDetailViewController
	<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
