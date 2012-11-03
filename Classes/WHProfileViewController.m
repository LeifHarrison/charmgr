//
//  WHProfileViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 2/22/10.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "WHProfileViewController.h"

#import "CMBannerBox.h"

@implementation WHProfileViewController

@synthesize characterBox, detailsBox, profileBox;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[characterBox setBannerTitle:@"Character"];
	[detailsBox setBannerTitle:@"Personal Details"];
	[profileBox setBannerTitle:@"Character Profile"];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
