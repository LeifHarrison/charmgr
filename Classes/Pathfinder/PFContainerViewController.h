//
//  PFContainerViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import <UIKit/UIKit.h>

@class PFCharacter;

@protocol PFContainerViewControllerDelegate;

typedef enum {
	PFContainerViewStateStatic,
	PFContainerViewStateEditing
} PFContainerViewState;

@interface PFContainerViewController : UIViewController
	<UIGestureRecognizerDelegate>

@property (nonatomic, assign) PFContainerViewState state;
@property (nonatomic, strong) PFCharacter *character;

@property (nonatomic, strong) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;

@property (nonatomic, weak) id <PFContainerViewControllerDelegate> delegate;

- (void)updateUI;
- (void)saveChanges;

- (CGRect)staticFramePortrait;
- (CGRect)staticFrameLandscape;
- (CGRect)editingBounds;

- (void)willTransitionToState:(PFContainerViewState)newState;
- (void)didTransitionToState:(PFContainerViewState)newState;
- (void)animateTransitionToState:(PFContainerViewState)newState;
- (void)layoutForState:(PFContainerViewState)newState;

@end

@protocol PFContainerViewControllerDelegate <NSObject>

- (void)containerViewController:(PFContainerViewController*)containerViewController
			  didFinishWithSave:(BOOL)save;

@end

