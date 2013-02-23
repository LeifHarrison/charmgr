//
//  CMRootViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "CMRootViewController.h"

#import "CMAppDelegate.h"

#import "CMMainViewController.h"

#import "PFCharacter.h"


//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface CMRootViewController ()

@end


//==============================================================================
// Class Implementation
//==============================================================================

@implementation CMRootViewController

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];

	//LOG_DEBUG(@"frame = %@", NSStringFromCGRect(self.view.frame));
	//self.view.layer.borderColor = [UIColor redColor].CGColor;
	//self.view.layer.borderWidth = 1.0f;
	
	self.mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CMMainViewController"];

	NSDictionary *pageViewOptions = @{@(UIPageViewControllerSpineLocationMin): UIPageViewControllerOptionSpineLocationKey};
	self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
															  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
																			options:pageViewOptions];
	//self.pageViewController.doubleSided = YES;
	self.pageViewController.dataSource = self;
	self.pageViewController.delegate = self;
	self.pageViewController.view.frame = self.view.bounds;
	
	[self addChildViewController:self.pageViewController];
	[self.view addSubview:self.pageViewController.view];
	[self.pageViewController didMoveToParentViewController:self];

	self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
	
	// Find the tap gesture recognizer so we can remove it!
	UIGestureRecognizer* tapRecognizer = nil;
	for (UIGestureRecognizer* recognizer in self.pageViewController.gestureRecognizers) {
		if ( [recognizer isKindOfClass:[UITapGestureRecognizer class]] ) {
			tapRecognizer = recognizer;
			break;
		}
	}
	
	if ( tapRecognizer ) {
		[self.view removeGestureRecognizer:tapRecognizer];
		[self.pageViewController.view removeGestureRecognizer:tapRecognizer];
	}
	
	[self.pageViewController setViewControllers:@[self.mainViewController]
									  direction:UIPageViewControllerNavigationDirectionForward
									   animated:NO
									 completion:nil];
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *currentCharacter = [userDefaults stringForKey:kCMCurrentCharacterDefaultsKey];
	if (currentCharacter) {
		[self performSelector:@selector(openCharacterWithName:) withObject:currentCharacter afterDelay:0.5];
	}

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//LOG_DEBUG(@"frame = %@", NSStringFromCGRect(self.view.frame));
	self.pageViewController.view.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	//LOG_DEBUG(@"frame = %@", NSStringFromCGRect(self.view.frame));
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


//------------------------------------------------------------------------------
#pragma mark - Interface Orientation
//------------------------------------------------------------------------------

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

//------------------------------------------------------------------------------
#pragma mark - Public Methods
//------------------------------------------------------------------------------

- (void)setPageTurningEnabled:(BOOL)flag;
{
	for (UIGestureRecognizer *gesture in self.pageViewController.gestureRecognizers) {
		gesture.enabled = flag;
	}
}

//------------------------------------------------------------------------------
#pragma mark - Private Methods
//------------------------------------------------------------------------------

- (void)openCharacterWithName:(NSString *)aCharacterName
{
	if (aCharacterName) {
		NSManagedObjectContext *moc = [(CMAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
		PFCharacter *aCharacter = [PFCharacter fetchCharacterWithName:aCharacterName context:moc];

		NSArray *pages = [self.mainViewController createViewControllersForCharacter:aCharacter];
		LOG_DEBUG(@"pages = %@", pages);
		self.characterViewControllers = pages;
		
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		NSInteger pageIndex = [userDefaults integerForKey:kCMCurrentPageDefaultsKey];

		if (pageIndex == NSNotFound) pageIndex = 0;
		
		[self.pageViewController setViewControllers:[NSArray arrayWithObject:[pages objectAtIndex:pageIndex]]
										  direction:UIPageViewControllerNavigationDirectionForward
										   animated:YES
										 completion:nil];
	}
}

//------------------------------------------------------------------------------
#pragma mark - UIPageViewControllerDataSource
//------------------------------------------------------------------------------

- (UIViewController *)pageViewController:(UIPageViewController *)aPageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	//LOG_DEBUG(@"pageViewController = %@, viewController = %@", aPageViewController, viewController);
	if (viewController == (UIViewController*)self.mainViewController) {
		return nil;
	}
	else {
		NSInteger pageIndex = [self indexOfCharacterPageViewController:viewController];
		if (pageIndex != NSNotFound) {
			NSInteger previousIndex = pageIndex - 1;
			if (previousIndex >= 0)
				return [self characterPageViewControllerAtIndex:previousIndex];
			else
				return (UIViewController *)self.mainViewController;
		}
		else {
			return nil;
		}
	}
	
}

- (UIViewController *)pageViewController:(UIPageViewController *)aPageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	//LOG_DEBUG(@"pageViewController = %@, viewController = %@", aPageViewController, viewController);
	if (viewController == (UIViewController*)self.mainViewController) {
		if (self.characterViewControllers.count > 0)
			return [self characterPageViewControllerAtIndex:0];
		else
			return nil;
	}
	else {
		NSInteger pageIndex = [self indexOfCharacterPageViewController:viewController];
		if (pageIndex != NSNotFound) {
			NSInteger nextIndex = pageIndex + 1;
			if (nextIndex < self.characterViewControllers.count)
				return [self characterPageViewControllerAtIndex:nextIndex];
			else
				return nil;
		}
		else {
			return nil;
		}
	}
}

//------------------------------------------------------------------------------
#pragma mark - UIPageViewControllerDelegate
//------------------------------------------------------------------------------

- (void)pageViewController:(UIPageViewController *)pageViewController
		didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
	   transitionCompleted:(BOOL)completed;
{
	if (completed) {
		NSArray *viewControllers = pageViewController.viewControllers;
		NSInteger pageIndex = [self indexOfCharacterPageViewController:[viewControllers objectAtIndex:0]];
		
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		[userDefaults setInteger:pageIndex forKey:kCMCurrentPageDefaultsKey];
		[userDefaults synchronize];
	}
	
}

//------------------------------------------------------------------------------
#pragma mark - Page Management
//------------------------------------------------------------------------------

- (NSInteger)indexOfCharacterPageViewController:(UIViewController*)aController
{
	return [self.characterViewControllers indexOfObject:aController];
}

- (UIViewController*)characterPageViewControllerAtIndex:(NSInteger)anIndex
{
	return [self.characterViewControllers objectAtIndex:anIndex];
}

@end
