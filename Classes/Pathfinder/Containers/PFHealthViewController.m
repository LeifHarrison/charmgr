//
//  PFHealthViewController
//  CharMgr
//
//  Created by Leif Harrison on 9/13/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFHealthViewController.h"

#import "CMBannerBox.h"

#import "PFCharacter.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGRect kPFHealthViewFramePortrait	= { {  10,  10 }, { 305,  100 } };
static const CGRect kPFHealthViewFrameLandscape	= { {  10,  10 }, { 305,  100 } };
static const CGRect kPFHealthViewBoundsEditing	= { {   0,   0 }, { 305,  100 } };

//------------------------------------------------------------------------------
#pragma mark - Private Interface Declaration
//------------------------------------------------------------------------------

@interface PFHealthViewController ()

@end

//==============================================================================
// Class Implementation
//==============================================================================

@implementation PFHealthViewController

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
	
    [(CMBannerBox*)self.view setBannerTitle:@"Health"];
}

//------------------------------------------------------------------------------
#pragma mark - Memory Management
//------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------------------
#pragma mark - Private
//------------------------------------------------------------------------------

- (void)updateUI
{
	[super updateUI];
	self.hitPointsField.text = [NSString stringWithFormat:@"%d", self.character.hitPoints];
	self.woundsField.text = [NSString stringWithFormat:@"%d", self.character.wounds];
	self.nonLethalField.text = [NSString stringWithFormat:@"%d", self.character.nonLethalWounds];
}

- (void)saveChanges
{
	self.character.hitPoints = [self.hitPointsField.text intValue];
	self.character.wounds = [self.woundsField.text intValue];
	self.character.nonLethalWounds = [self.nonLethalField.text intValue];
}

//------------------------------------------------------------------------------
#pragma mark - Frame Sizes (for different states)
//------------------------------------------------------------------------------

- (CGRect)staticFramePortrait;
{
	return kPFHealthViewFramePortrait;
}

- (CGRect)staticFrameLandscape;
{
	return kPFHealthViewFrameLandscape;
}

- (CGRect)editingBounds;
{
	return kPFHealthViewBoundsEditing;
}

@end
