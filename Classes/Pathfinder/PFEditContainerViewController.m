//
//  PFEditContainerViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/29/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "PFEditContainerViewController.h"

#import "PFCharacter.h"

#import "CMBannerBox.h"
#import "CMSettings.h"

@interface PFEditContainerViewController ()

@end

@implementation PFEditContainerViewController

//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.view.layer.contents = (id)[[[CMSettings sharedSettings] pageBackgroundImage] CGImage];
	self.view.layer.contentsGravity = kCAGravityCenter;
	self.view.backgroundColor = [UIColor blackColor];

	[self createBannerButtons];
}

- (void)cancelEditing:(id)sender
{
	[[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
	//[self.delegate containerViewController:self didFinishWithSave:NO];
}

- (void)saveChanges:(id)sender
{
	[self saveChanges];

	NSError *error;
	if (![[self.character managedObjectContext] save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		[[self.character managedObjectContext] rollback];
	}

	[[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
	//[self.delegate containerViewController:self didFinishWithSave:YES];
}

- (void)createBannerButtons
{
	[self.bannerBox addLeftButtonWithTitle:@"Cancel" target:self action:@selector(cancelEditing:) animated:NO];
	[self.bannerBox addRightButtonWithTitle:@"Save" target:self action:@selector(saveChanges:) animated:NO];
}

- (CMBannerBox *)bannerBox
{
	if ([self.view isKindOfClass:[CMBannerBox class]]) {
		return (CMBannerBox*)self.view;
	}
	else {
		return nil;
	}
}
//------------------------------------------------------------------------------
#pragma mark - Updating/Saving
//------------------------------------------------------------------------------

- (void)updateUI;
{
	// Default implementation does nothing
}

- (void)saveChanges;
{
	// Default implementation does nothing
}

@end
