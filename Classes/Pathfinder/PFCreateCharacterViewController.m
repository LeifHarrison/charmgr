//
//  PFCreateCharacterViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/7/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFCreateCharacterViewController.h"

#import "PFCharacter.h"

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFCreateCharacterViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFCreateCharacterViewController

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
	// Do any additional setup after loading the view.
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
#pragma mark - Actions
//------------------------------------------------------------------------------

- (IBAction)cancel:(id)sender
{
	TRACE;
    [self.delegate createCharacterViewController:self didFinishWithSave:NO];
}


- (IBAction)save:(id)sender
{
	TRACE;
	
    [self.delegate createCharacterViewController:self didFinishWithSave:YES];
}

//------------------------------------------------------------------------------
#pragma mark - Storyboard
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	LOG_DEBUG(@"seque = %@, sender = %@", segue.identifier, sender);
	
	if ([segue.identifier hasSuffix:@"NextController"]) {
		PFCreateCharacterViewController *nextController = segue.destinationViewController;
		nextController.delegate = self.delegate;
		nextController.managedObjectContext = self.managedObjectContext;
		nextController.character = self.character;
	}
}


@end
