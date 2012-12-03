//
//  PFChooseClassViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 10/9/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFCreateCharacterViewController.h"

#import <CoreData/CoreData.h>

@interface PFCreateCharacterChooseClassViewController : PFCreateCharacterViewController
	<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITextView *descriptionTextView;

@end
