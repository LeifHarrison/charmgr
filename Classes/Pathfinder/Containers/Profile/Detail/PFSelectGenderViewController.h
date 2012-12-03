//
//  PFSelectGenderViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 11/11/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFDetailViewController.h"

@interface PFSelectGenderViewController : PFDetailViewController

@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)genderChanged:(id)sender;

@end
