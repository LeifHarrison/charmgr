//
//  CMEditTransitioner.m
//  CharMgr
//
//  Created by Leif Harrison on 9/25/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import "CMEditTransitioner.h"

#import "CMEditPresentationController.h"

@implementation CMEditTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
													  presentingViewController:(UIViewController *)presenting
														  sourceViewController:(UIViewController *)source
{
	return [[CMEditPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (CMEditAnimatedTransitioning *)animationController
{
	if (!_animationController) {
		_animationController = [[CMEditAnimatedTransitioning alloc] init];
	}
	return _animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
																   presentingController:(UIViewController *)presenting
																	   sourceController:(UIViewController *)source
{
	CMEditAnimatedTransitioning *animationController = [self animationController];
	[animationController setIsPresentation:YES];
	[animationController setSourceViewController:source];

	return animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
	CMEditAnimatedTransitioning *animationController = [self animationController];
	[animationController setIsPresentation:NO];

	return animationController;
}

@end

@implementation CMEditAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
	return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIView *fromView = [fromVC view];
	UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIView *toView = [toVC view];

	UIView *containerView = [transitionContext containerView];

	BOOL isPresentation = [self isPresentation];

	UIViewController *animatingVC = isPresentation? toVC : fromVC;
	UIView *animatingView = [animatingVC view];

	CGRect sourceFrame = [containerView convertRect:self.sourceViewController.view.frame fromView:self.sourceViewController.view.superview];
	CGRect finalFrame = [transitionContext finalFrameForViewController:animatingVC];

	CGFloat sx = sourceFrame.size.width / finalFrame.size.width;
	CGFloat sy = sourceFrame.size.height / finalFrame.size.height;
	//CGFloat tx = sourceFrame.origin.x - finalFrame.origin.x;
	//CGFloat ty = sourceFrame.origin.y - finalFrame.origin.y;

	CGPoint sourceCenter = CGPointMake(CGRectGetMidX(sourceFrame), CGRectGetMidY(sourceFrame));
	CGPoint finalCenter = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));

	CGAffineTransform scale = CGAffineTransformMakeScale(sx, sy);
	//CGAffineTransform offset = CGAffineTransformMakeTranslation(tx, ty);
	//CGAffineTransform transform = CGAffineTransformConcat(scale, offset);

	//LOG_DEBUG(@"initial frame = %@", NSStringFromCGRect([transitionContext initialFrameForViewController:animatingVC]));
	//LOG_DEBUG(@"  source frame = %@", NSStringFromCGRect(sourceFrame));
	//LOG_DEBUG(@"  final frame = %@", NSStringFromCGRect(finalFrame));
	//LOG_DEBUG(@"  scale = %@", NSStringFromCGAffineTransform(scale));
	//LOG_DEBUG(@"  offset = %@", NSStringFromCGAffineTransform(offset));
	if (isPresentation) {
		[animatingView setFrame:finalFrame];
		animatingView.center = sourceCenter;
		animatingView.transform = scale;
		animatingView.alpha = 0.0;
		[containerView addSubview:toView];
	}


	[UIView animateWithDuration:[self transitionDuration:transitionContext]
						  delay:0
		 usingSpringWithDamping:(isPresentation ? 1.0 : 1.0)
		  initialSpringVelocity:5.0
						options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 animatingView.transform = isPresentation ? CGAffineTransformIdentity : scale;
						 animatingView.center = isPresentation ? finalCenter : sourceCenter;
						 animatingView.alpha = isPresentation ? 1.0 : 0.0;
					 }
					 completion:^(BOOL finished){
						 if(![self isPresentation])
						 {
							 [fromView removeFromSuperview];
						 }
						 [transitionContext completeTransition:YES];
					 }];
}

@end
