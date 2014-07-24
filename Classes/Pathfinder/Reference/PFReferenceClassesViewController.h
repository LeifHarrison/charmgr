//
//  PFReferenceClassesViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 7/18/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFReferenceClassesViewController : UIViewController

@property (nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic) IBOutlet UITableView *tableView;

- (IBAction)dismissView:(id)sender;

@end
