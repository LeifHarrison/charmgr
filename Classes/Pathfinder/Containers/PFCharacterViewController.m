//
//  PFCharacterViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import "PFCharacterViewController.h"

#import "PFAlignment.h"
#import "PFCharacter.h"
#import "PFCharacterClass.h"
#import "PFClassType.h"
#import "PFRace.h"

#import "CMBannerBox.h"

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFCharacterViewController ()

@property (nonatomic, strong) IBOutlet NSArray *editableFields;

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
	
	self.editableFields = @[_characterField, _playerField, _campaignField];
	[self setEditableFieldsEnabled:NO];

	self.raceButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.raceButton.layer.borderWidth = 1.0f;
	self.raceButton.layer.cornerRadius = 5.0f;
	self.raceButton.alpha = 0.0;

	self.genderButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.genderButton.layer.borderWidth = 1.0f;
	self.genderButton.layer.cornerRadius = 5.0f;
	self.genderButton.alpha = 0.0;

	self.sizeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.sizeButton.layer.borderWidth = 1.0f;
	self.sizeButton.layer.cornerRadius = 5.0f;
	self.sizeButton.alpha = 0.0;

	self.alignmentButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.alignmentButton.layer.borderWidth = 1.0f;
	self.alignmentButton.layer.cornerRadius = 5.0f;
	self.alignmentButton.alpha = 0.0;

	for (UITextField *aField in self.editableFields) {
		//aField.frame = CGRectInset(aField.frame, 0, 3);
	}
	
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
	
	self.genderLabel.text = self.character.genderDescription;
	self.raceLabel.text = self.character.race.name;
	self.sizeLabel.text = self.character.race.size;
	self.alignmentLabel.text = self.character.alignment.name;
	
	LOG_DEBUG(@"race = %@", self.character.race.name);
	[self.raceButton setTitle:self.character.race.name forState:UIControlStateNormal];
	[self.genderButton setTitle:self.character.genderDescription forState:UIControlStateNormal];
	[self.sizeButton setTitle:self.character.race.size forState:UIControlStateNormal];
	[self.alignmentButton setTitle:self.character.alignment.name forState:UIControlStateNormal];
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

//------------------------------------------------------------------------------
#pragma mark - State Transitions
//------------------------------------------------------------------------------

- (void)willTransitionToState:(PFContainerViewState)newState;
{
	LOG_DEBUG(@"newState = %d", newState);
	[super willTransitionToState:newState];

	if (newState == PFContainerViewStateStatic) {
		[self setEditableFieldsEnabled:NO];
/*
		void (^animations) (void) = ^{
			self.raceButton.alpha = 0.0;
			self.genderButton.alpha = 0.0;
			self.sizeButton.alpha = 0.0;
			self.alignmentButton.alpha = 0.0;

			self.raceLabel.alpha = 1.0;
			self.genderLabel.alpha = 1.0;
			self.sizeLabel.alpha = 1.0;
			self.alignmentLabel.alpha = 1.0;
		};
		void (^completion) (BOOL) = ^(BOOL finished) {
		};
		[UIView animateWithDuration:0.3
						 animations:animations
						 completion:completion];
*/
	}
}

- (void)didTransitionToState:(PFContainerViewState)newState;
{
	LOG_DEBUG(@"newState = %d", newState);
	//LOG_DEBUG(@"parentViewController = %@", self.parentViewController);
	[super didTransitionToState:newState];

	if (newState == PFContainerViewStateEditing) {
/*
		void (^animations) (void) = ^{
			self.raceButton.alpha = 1.0;
			self.genderButton.alpha = 1.0;
			self.sizeButton.alpha = 1.0;
			self.alignmentButton.alpha = 1.0;

			self.raceLabel.alpha = 0.0;
			self.genderLabel.alpha = 0.0;
			self.sizeLabel.alpha = 0.0;
			self.alignmentLabel.alpha = 0.0;
		};
		void (^completion) (BOOL) = ^(BOOL finished) {
		};
		[UIView animateWithDuration:0.3
						 animations:animations
						 completion:completion];
*/
		[self setEditableFieldsEnabled:YES];
	}
}

- (void)animateTransitionToState:(PFContainerViewState)newState;
{
	LOG_DEBUG(@"newState = %d", newState);
	[super animateTransitionToState:newState];

	if (newState == PFContainerViewStateEditing) {
		self.raceButton.alpha = 1.0;
		self.genderButton.alpha = 1.0;
		self.sizeButton.alpha = 1.0;
		self.alignmentButton.alpha = 1.0;
		
		self.raceLabel.alpha = 0.0;
		self.genderLabel.alpha = 0.0;
		self.sizeLabel.alpha = 0.0;
		self.alignmentLabel.alpha = 0.0;
	}
	else {
		self.raceButton.alpha = 0.0;
		self.genderButton.alpha = 0.0;
		self.sizeButton.alpha = 0.0;
		self.alignmentButton.alpha = 0.0;
		
		self.raceLabel.alpha = 1.0;
		self.genderLabel.alpha = 1.0;
		self.sizeLabel.alpha = 1.0;
		self.alignmentLabel.alpha = 1.0;
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
	}
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController;
{
	TRACE;
	self.detailPopover = nil;
	[self updateUI];
}

- (void)detailViewControllerDidFinish:(PFDetailViewController*)viewController
{
	if (self.detailPopover) [self.detailPopover dismissPopoverAnimated:YES];
	self.detailPopover = nil;
	[self updateUI];
}


@end
