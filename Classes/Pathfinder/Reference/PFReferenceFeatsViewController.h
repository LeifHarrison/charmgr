//
//  PFReferenceFeatsViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 11/3/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFReferenceFeatsViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet UITextField *featNameField;
@property (nonatomic, strong) IBOutlet UITextField *featTypeField;

@end
