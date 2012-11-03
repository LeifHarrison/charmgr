//
//  PFAttacksViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/20/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFAttacksViewController.h"

#import "CMBannerBox.h"

@interface PFAttacksViewController ()

@end

@implementation PFAttacksViewController

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
	
    [(CMBannerBox*)self.view setBannerTitle:@"Attacks"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
