//
//  PFCharacterViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import "PFCharacterViewController.h"

#import "PFSelectAlignmentViewController.h"
#import "PFSelectGenderViewController.h"
#import "PFSelectRaceViewController.h"
#import "PFSelectSizeViewController.h"

#import "PFAlignment.h"
#import "PFCharacter.h"
#import "PFCharacterClass.h"
#import "PFClassType.h"
#import "PFRace.h"

#import "CMBannerBox.h"

#import "NSArray+CMExtensions.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGRect kPFCharacterViewFramePortrait	= { {  10,  10 }, { 238, 240 } };
static const CGRect kPFCharacterViewFrameLandscape	= { {  10,  10 }, { 285, 238 } };
static const CGRect kPFCharacterViewBoundsEditing	= { {   0,   0 }, { 268, 258 } };

static const CGFloat kPFCharacterViewLabelsInsetX		= 15.0f;
static const CGFloat kPFCharacterViewSpacingX			= 5.0f;
static const CGFloat kPFCharacterViewInsetY				= 35.0f;
static const CGFloat kPFCharacterViewSpacingYStatic		= 7.0f;
static const CGFloat kPFCharacterViewSpacingYEditing	= 5.0f;
static const CGFloat kPFCharacterViewHeightStatic		= 20.0f;
static const CGFloat kPFCharacterViewHeightEditing		= 26.0f;
static const CGFloat kPFCharacterViewTitleWidthStatic	= 70.0f;
static const CGFloat kPFCharacterViewTitleWidthEditing	= 80.0f;
static const CGFloat kPFCharacterViewValueWidthStatic	= 140.0f;
static const CGFloat kPFCharacterViewValueWidthEditing	= 160.0f;

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFCharacterViewController ()

@property (nonatomic, strong) UIPopoverController *detailPopover;
@property (nonatomic, strong) NSArray *editableFields;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFCharacterViewController

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
	TRACE;
    [super viewDidLoad];
    
    [(CMBannerBox*)self.view setBannerTitle:@"Character"];
	
	self.titleLabels = [self.titleLabels sortByUIViewOriginY];
	self.valueFields = [self.valueFields sortByUIViewOriginY];
	
	self.editableFields = @[_characterField, _playerField, _campaignField];
	[self setEditableFieldsEnabled:NO];
	
	self.raceButton.layer.borderColor = [UIColor clearColor].CGColor;
	self.raceButton.layer.borderWidth = 1.0f;
	self.raceButton.layer.cornerRadius = 5.0f;

	self.genderButton.layer.borderColor = [UIColor clearColor].CGColor;
	self.genderButton.layer.borderWidth = 1.0f;
	self.genderButton.layer.cornerRadius = 5.0f;

	self.sizeButton.layer.borderColor = [UIColor clearColor].CGColor;
	self.sizeButton.layer.borderWidth = 1.0f;
	self.sizeButton.layer.cornerRadius = 5.0f;

	self.alignmentButton.layer.borderColor = [UIColor clearColor].CGColor;
	self.alignmentButton.layer.borderWidth = 1.0f;
	self.alignmentButton.layer.cornerRadius = 5.0f;
}

- (void)viewWillAppear:(BOOL)animated
{
	TRACE;
	[super viewWillAppear:animated];
	[self updateUI];
}


//------------------------------------------------------------------------------
#pragma mark - Private
//------------------------------------------------------------------------------

- (void)updateUI
{
	[super updateUI];

	self.characterField.text = self.character.name;
	self.playerField.text = self.character.player;
	self.campaignField.text = self.character.campaign;
	
	[self.raceButton setTitle:self.character.race.name forState:UIControlStateNormal];
	[self.genderButton setTitle:self.character.genderDescription forState:UIControlStateNormal];
	[self.sizeButton setTitle:self.character.sizeDescription forState:UIControlStateNormal];
	[self.alignmentButton setTitle:self.character.alignment.name forState:UIControlStateNormal];
	
}

- (void)saveChanges
{
	self.character.name = self.characterField.text;
	self.character.player = self.playerField.text;
	self.character.campaign = self.campaignField.text;
}

- (void)setEditableFieldsEnabled:(BOOL)enabled
{
	for (UITextField *aField in self.editableFields) {
		aField.enabled = enabled;
		if (enabled)
			aField.borderStyle = UITextBorderStyleRoundedRect;
		else
			aField.borderStyle = UITextBorderStyleNone;
	}
}

- (void)layoutSubviewsForState:(PFContainerViewState)state;
{
	LOG_DEBUG(@"state = %d", state);
	if (state == PFContainerViewStateStatic) {
		CGFloat currentY = kPFCharacterViewInsetY;
		for (UIView *aView in self.titleLabels) {
			aView.frame = CGRectMake(kPFCharacterViewLabelsInsetX, currentY, kPFCharacterViewTitleWidthStatic, kPFCharacterViewHeightStatic);
			//LOG_DEBUG(@"viewFrame = %@, view = %@", NSStringFromCGRect(viewFrame), aView);
			currentY = CGRectGetMaxY(aView.frame) + kPFCharacterViewSpacingYStatic;
		}

		currentY = kPFCharacterViewInsetY;
		for (UIView *aView in self.valueFields) {
			CGFloat viewX = kPFCharacterViewLabelsInsetX + kPFCharacterViewTitleWidthStatic + kPFCharacterViewSpacingX;
			aView.frame = CGRectMake(viewX, currentY, kPFCharacterViewValueWidthStatic, kPFCharacterViewHeightStatic);
			//LOG_DEBUG(@"viewFrame = %@, view = %@", NSStringFromCGRect(viewFrame), aView);
			currentY = CGRectGetMaxY(aView.frame) + kPFCharacterViewSpacingYStatic;
		}
	}
	else {
		CGFloat currentY = kPFCharacterViewInsetY;
		for (UIView *aView in self.titleLabels) {
			aView.frame = CGRectMake(kPFCharacterViewLabelsInsetX, currentY, kPFCharacterViewTitleWidthEditing, kPFCharacterViewHeightEditing);
			//LOG_DEBUG(@"viewFrame = %@, view = %@", NSStringFromCGRect(viewFrame), aView);
			currentY = CGRectGetMaxY(aView.frame) + kPFCharacterViewSpacingYEditing;
		}

		currentY = kPFCharacterViewInsetY;
		for (UIView *aView in self.valueFields) {
			CGFloat viewX = kPFCharacterViewLabelsInsetX + kPFCharacterViewTitleWidthEditing + kPFCharacterViewSpacingX;
			aView.frame = CGRectMake(viewX, currentY, kPFCharacterViewValueWidthEditing, kPFCharacterViewHeightEditing);
			//LOG_DEBUG(@"viewFrame = %@, view = %@", NSStringFromCGRect(viewFrame), aView);
			currentY = CGRectGetMaxY(aView.frame) + kPFCharacterViewSpacingYEditing;
		}
	}
}

//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	// Default implementation just returns our current view frame
	return kPFCharacterViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	// Default implementation just returns our current view frame
	return kPFCharacterViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	// Default implementation just returns our current view frame
	return kPFCharacterViewBoundsEditing;
}

//------------------------------------------------------------------------------
#pragma mark - State Transitions
//------------------------------------------------------------------------------

- (void)willTransitionToState:(PFContainerViewState)newState;
{
	LOG_DEBUG(@"newState = %d", newState);
	[super willTransitionToState:newState];

	if (newState == PFContainerViewStateStatic) {
		[self setEditableFieldsEnabled:NO];
		[self.raceButton setEnabled:NO];
		[self.genderButton setEnabled:NO];
		[self.sizeButton setEnabled:NO];
		[self.alignmentButton setEnabled:NO];
	}
}

- (void)didTransitionToState:(PFContainerViewState)newState;
{
	LOG_DEBUG(@"newState = %d", newState);
	//LOG_DEBUG(@"parentViewController = %@", self.parentViewController);
	[super didTransitionToState:newState];

	if (newState == PFContainerViewStateEditing) {
		[self setEditableFieldsEnabled:YES];
		[self.raceButton setEnabled:YES];
		[self.genderButton setEnabled:YES];
		[self.sizeButton setEnabled:YES];
		[self.alignmentButton setEnabled:YES];
	}
}

- (void)animateTransitionToState:(PFContainerViewState)newState;
{
	LOG_DEBUG(@"newState = %d", newState);
	[super animateTransitionToState:newState];

	[self layoutSubviewsForState:newState];

	[self configureButton:self.raceButton forState:newState];
	[self configureButton:self.genderButton forState:newState];
	[self configureButton:self.sizeButton forState:newState];
	[self configureButton:self.alignmentButton forState:newState];
}

- (void)configureButton:(UIButton *)aButton forState:(PFContainerViewState)aState;
{
	if (aState == PFContainerViewStateEditing) {
		[aButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		aButton.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
		aButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
	}
	else {
		[aButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		aButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
		aButton.layer.borderColor = [UIColor clearColor].CGColor;
	}
}

//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	LOG_DEBUG(@"segue = %@, sender = %@", segue.identifier, sender);
	LOG_DEBUG(@"source = %@, destination = %@", segue.sourceViewController, segue.destinationViewController);
	[super prepareForSegue:segue sender:sender];
	//if ([segue.identifier hasSuffix:@"Container"]) {
	//}
    if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]])
    {
        UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue*)segue;
        popoverSegue.popoverController.delegate = self;
		self.detailPopover = popoverSegue.popoverController;
    }

    if ([segue.destinationViewController isKindOfClass:[PFDetailViewController class]])
    {
		PFDetailViewController *controller = segue.destinationViewController;
		controller.delegate = self;
		controller.character = self.character;
	}
}

//------------------------------------------------------------------------------
#pragma mark - UIPopoverController Delegate
//------------------------------------------------------------------------------

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController;
{
	TRACE;
	self.detailPopover = nil;
	[self updateUI];
}

//------------------------------------------------------------------------------
#pragma mark - PFDetailViewController Delegate
//------------------------------------------------------------------------------

- (void)detailViewControllerDidFinish:(PFDetailViewController*)viewController
{
	if (self.detailPopover) [self.detailPopover dismissPopoverAnimated:YES];
	self.detailPopover = nil;
	[self updateUI];
}


@end
