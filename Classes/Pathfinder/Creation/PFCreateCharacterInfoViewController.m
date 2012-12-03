//
//  PFCreateCharacterInfoViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 10/9/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFCreateCharacterInfoViewController.h"

#import "PFCharacter.h"

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFCreateCharacterInfoViewController ()

@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UITextField *playerField;
@property (nonatomic, weak) IBOutlet UITextField *campaignField;

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFCreateCharacterInfoViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.parentViewController.view.superview.bounds = CGRectMake(0, 0, 400, 550);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	
	CGPoint centerPoint = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
	self.parentViewController.view.superview.center = centerPoint;
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}
//------------------------------------------------------------------------------
#pragma mark - Memory Management
//------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (IBAction)save:(id)sender
{
	TRACE;

	[self.view endEditing:YES];

	self.character.name = self.nameField.text;
	self.character.player = self.playerField.text;
	self.character.campaign = self.campaignField.text;
	
    [super save:sender];
}

//------------------------------------------------------------------------------
#pragma mark - UITextFieldDelegate
//------------------------------------------------------------------------------

- (BOOL)textFieldShouldReturn:(UITextField*)textField;
{
	NSInteger nextTag = textField.tag + 1;
	// Try to find next responder
	UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
	if (nextResponder) {
		// Found next responder, so set it.
		[nextResponder becomeFirstResponder];
	} else {
		// Not found, so remove keyboard.
		[textField resignFirstResponder];
	}
	return NO; // We do not want UITextField to insert line-breaks.
}

//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	LOG_DEBUG(@"seque = %@, sender = %@", segue.identifier, sender);

	if ([self.nameField isFirstResponder]) {
		[self.nameField resignFirstResponder];
	}
	else if ([self.playerField isFirstResponder]){
		[self.playerField resignFirstResponder];
	}
	else if ([self.campaignField isFirstResponder]){
		[self.campaignField resignFirstResponder];
	}
	
	[super prepareForSegue:segue sender:sender];
	
	if ([segue.identifier hasSuffix:@"NextController"]) {
		self.character.name = self.nameField.text;
		self.character.player = self.playerField.text;
		self.character.campaign = self.campaignField.text;
	}
}

@end

// Hack to get keyboard to dismiss when leaving the view
@implementation UINavigationController (DelegateAutomaticDismissKeyboard)

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return [self.topViewController disablesAutomaticKeyboardDismissal];
}

@end