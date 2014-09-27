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
	return 0.75;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIView *fromView = [fromVC view];
	UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIView *toView = [toVC view];

	UIView *containerView = [transitionContext containerView];

	BOOL isPresentation = [self isPresentation];

	if(isPresentation)
	{
		[containerView addSubview:toView];
	}

	UIViewController *animatingVC = isPresentation? toVC : fromVC;
	UIView *animatingView = [animatingVC view];

	CGRect sourceFrame = [containerView convertRect:self.sourceViewController.view.frame fromView:self.sourceViewController.view.superview];
	CGRect finalFrame = [transitionContext finalFrameForViewController:animatingVC];
	//CGFloat dx = CGRectGetMidX(sourceFrame) - CGRectGetMidX(finalFrame);
	//CGFloat dy = CGRectGetMidY(sourceFrame) - CGRectGetMidY(finalFrame);

	LOG_DEBUG(@"initial frame = %@", NSStringFromCGRect([transitionContext initialFrameForViewController:animatingVC]));
	LOG_DEBUG(@"  final frame = %@", NSStringFromCGRect(finalFrame));
	//[animatingView setFrame:[transitionContext finalFrameForViewController:animatingVC]];
	[animatingView setFrame:isPresentation ? sourceFrame : finalFrame];

	//CGAffineTransform presentedTransform = CGAffineTransformIdentity;
	//CGAffineTransform dismissedTransform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.001, 0.001), CGAffineTransformMakeTranslation(dx, dy));

	//[animatingView setTransform:isPresentation ? dismissedTransform : presentedTransform];

	[UIView animateWithDuration:[self transitionDuration:transitionContext]
						  delay:0
		 usingSpringWithDamping:(isPresentation ? 0.7 : 1.0)
		  initialSpringVelocity:5.0
						options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 [animatingView setFrame:isPresentation ? finalFrame : sourceFrame];
						 //[animatingView setTransform:isPresentation ? presentedTransform : dismissedTransform];
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
