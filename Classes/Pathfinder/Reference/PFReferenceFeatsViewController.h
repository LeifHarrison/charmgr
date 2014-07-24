//
//  PFReferenceFeatsViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 11/3/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface PFReferenceFeatsViewController : UIViewController
	<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic) IBOutlet UITableView *tableView;

- (IBAction)dismissView:(id)sender;

@end
