//
//  PFReferenceViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 7/18/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "PFReferenceViewController.h"

@interface PFReferenceViewController ()

@end

@implementation PFReferenceViewController

//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//[self setNeedsStatusBarAppearanceUpdate];
	//[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

//------------------------------------------------------------------------------
#pragma mark - Memory Management
//------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------------------
#pragma mark - Layout
//------------------------------------------------------------------------------

//- (BOOL)prefersStatusBarHidden
//{
//	return YES;
//}

@end
