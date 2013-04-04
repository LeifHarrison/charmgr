//
//  PFScrollsViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 3/22/13.
//  Copyright (c) 2013 Leif Harrison. All rights reserved.
//

#import "PFScrollsViewController.h"

#import "CMBannerBox.h"

@interface PFScrollsViewController ()

@end

@implementation PFScrollsViewController

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
	[(CMBannerBox*)self.view setBannerTitle:@"Scrolls"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
