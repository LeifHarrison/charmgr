//
//  PFEditClassViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 11/3/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFDetailViewController.h"

#import <CoreData/CoreData.h>

@interface PFSelectRaceViewController : PFDetailViewController
	<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
