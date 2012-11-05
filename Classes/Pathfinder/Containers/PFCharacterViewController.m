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
    [super viewDidLoad];
    
    [(CMBannerBox*)self.view setBannerTitle:@"Character"];
	
	self.editableFields = @[_characterField, _playerField, _campaignField];
	[self setEditableFieldsEnabled:NO];

	for (UITextField *aField in self.editableFields) {
		//aField.frame = CGRectInset(aField.frame, 0, 3);
	}
	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self updateUI];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


//------------------------------------------------------------------------------
#pragma mark - Private
//------------------------------------------------------------------------------

- (void)updateUI
{
	[super updateUI];

	//LOG_DEBUG(@"character = %@", self.character);
	self.characterField.text = self.character.name;
	self.playerField.text = self.character.player;
	self.campaignField.text = self.character.campaign;
	
	self.genderLabel.text = self.character.genderDescription;
	self.raceLabel.text = self.character.race.name;
	self.sizeLabel.text = self.character.race.size;
	self.alignmentLabel.text = self.character.alignment.name;
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
	//TRACE;
	[super willTransitionToState:newState];

	if (newState == PFContainerViewStateStatic) {
		[self setEditableFieldsEnabled:NO];
	}
	else if (newState == PFContainerViewStateEditing) {
		self.raceButton.hidden = NO;
		self.raceButton.alpha = 0.0;
	}
}

- (void)didTransitionToState:(PFContainerViewState)newState;
{
	//TRACE;
	//LOG_DEBUG(@"parentViewController = %@", self.parentViewController);
	[super didTransitionToState:newState];
	
	void (^animations) (void) = ^{
		if (newState == PFContainerViewStateEditing) {
			self.raceButton.alpha = 1.0;
			self.raceLabel.alpha = 0.0;
		}
		else {
		}
    };
    void (^completion) (BOOL) = ^(BOOL finished) {
		if (newState == PFContainerViewStateEditing) {
			self.raceButton.enabled = YES;
		}
    };
    [UIView animateWithDuration:0.3
					 animations:animations
					 completion:completion];

	if (newState == PFContainerViewStateEditing) {
		[self setEditableFieldsEnabled:YES];
	}
}

- (void)animateTransitionToState:(PFContainerViewState)newState;
{
	//TRACE;
	[super animateTransitionToState:newState];
	// Default implementation does nothing
}


//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	LOG_DEBUG(@"seque = %@, sender = %@", segue.identifier, sender);
	
	//if ([segue.identifier hasSuffix:@"Container"]) {
	//}
}


@end
