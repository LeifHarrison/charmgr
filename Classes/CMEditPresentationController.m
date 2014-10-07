//
//  CMEditPresentationController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/25/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "CMEditPresentationController.h"

#import "CGGeometry+CMExtensions.h"

@implementation CMEditPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
					   presentingViewController:(UIViewController *)presentingViewController
{
	self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController ];
	if(self)
	{
		dimmingView = [[UIView alloc] init];
		[dimmingView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
	}
	return self;
}

- (CGRect)frameOfPresentedViewInContainerView
{
	CGRect containerBounds = [[self containerView] bounds];

	CGRect presentedViewFrame = CGRectWithSize(self.presentedViewController.preferredContentSize);
	presentedViewFrame = CGRectCenteredInRect(presentedViewFrame, containerBounds);
//	presentedViewFrame.size = CGSizeMake(300, 500);
//	presentedViewFrame.origin = CGPointMake(containerBounds.size.width / 2.0, containerBounds.size.height / 2.0);
//	presentedViewFrame.origin.x -= presentedViewFrame.size.width / 2.0;
//	presentedViewFrame.origin.y -= presentedViewFrame.size.height / 2.0;
//	LOG_DEBUG(@"presentedViewFrame = %@", NSStringFromCGRect(presentedViewFrame));
	return presentedViewFrame;
}

- (void)presentationTransitionWillBegin
{
	[super presentationTransitionWillBegin];

	[self addViewsToDimmingView];

	[dimmingView setAlpha:0.0];

	[[[self presentedViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		[dimmingView setAlpha:1.0];
	} completion:nil];

}

- (void)containerViewWillLayoutSubviews
{
	[super containerViewWillLayoutSubviews];
	[dimmingView setFrame:[[self containerView] bounds]];
}

- (void)containerViewDidLayoutSubviews
{
	[super containerViewDidLayoutSubviews];
}

- (void)dismissalTransitionWillBegin
{
	[super dismissalTransitionWillBegin];

	[[[self presentedViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		[dimmingView setAlpha:0.0];
	} completion:nil];
}

- (void)addViewsToDimmingView
{
	[[self containerView] addSubview:dimmingView];
}

@end
