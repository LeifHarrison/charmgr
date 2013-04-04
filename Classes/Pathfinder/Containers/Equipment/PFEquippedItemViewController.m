//
//  PFEquippedItemViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 3/22/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import "PFEquippedItemViewController.h"

#import "CMBannerBox.h"

@interface PFEquippedItemViewController ()

@end

@implementation PFEquippedItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[(CMBannerBox*)self.view setBannerTitle:@"Equipped Items"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
