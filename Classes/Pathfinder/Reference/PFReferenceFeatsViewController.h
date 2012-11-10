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

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *detailContainerView;

@property (nonatomic, strong) IBOutlet UILabel *featNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *featTypeLabel;
@property (nonatomic, strong) IBOutlet UILabel *featSourceLabel;

@property (nonatomic, strong) IBOutlet UITextView *prerequisitesTextView;
@property (nonatomic, strong) IBOutlet UITextView *benefitTextView;

//@property (nonatomic, strong) IBOutlet UITextField *featNameField;
//@property (nonatomic, strong) IBOutlet UITextField *featTypeField;

- (IBAction)dismissView:(id)sender;

@end
