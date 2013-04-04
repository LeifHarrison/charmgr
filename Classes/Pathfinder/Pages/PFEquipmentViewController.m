//
//  PFEquipmentViewController.m
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFEquipmentViewController.h"

#import "PFEncumbranceViewController.h"
#import "PFEquippedItemViewController.h"
#import "PFInventoryViewController.h"
#import "PFMoneyViewController.h"
#import "PFPotionsViewController.h"
#import "PFScrollsViewController.h"

//------------------------------------------------------------------------------
#pragma mark - Constants
//------------------------------------------------------------------------------

static const CGPoint kPFInventoryViewOriginPortrait			= {  10,  10 };
static const CGPoint kPFInventoryViewOriginLandscape		= {  10,  10 };

static const CGPoint kPFEncumbranceViewOriginPortrait		= {  10, 550 };
static const CGPoint kPFEncumbranceViewOriginLandscape		= {  10, 550 };

static const CGPoint kPFMoneyViewOriginPortrait				= {  10, 735 };
static const CGPoint kPFMoneyViewOriginLandscape			= {  10, 735 };

static const CGPoint kPFPotionsViewOriginPortrait			= { 265, 735 };
static const CGPoint kPFPotionsViewOriginLandscape			= { 265, 735 };

static const CGPoint kPFScrollsViewOriginPortrait			= { 520, 735 };
static const CGPoint kPFScrollsViewOriginLandscape			= { 520, 735 };

static const CGPoint kPFEquippedItemsViewOriginPortrait		= { 350,  10 };
static const CGPoint kPFEquippedItemsViewOriginLandscape	= { 350,  10 };

@interface PFEquipmentViewController ()

@end

@implementation PFEquipmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	PFEncumbranceViewController *encumbranceController = [[PFEncumbranceViewController alloc] initWithNibName:@"PFEncumbranceView" bundle:nil];
	[self.containers addObject:encumbranceController];
	encumbranceController.view.frame = (CGRect){ .origin = kPFEncumbranceViewOriginPortrait, .size = encumbranceController.view.frame.size };
	[self.view addSubview:encumbranceController.view];

	PFEquippedItemViewController *equippedItemsController = [[PFEquippedItemViewController alloc] initWithNibName:@"PFEquippedItemsView" bundle:nil];
	[self.containers addObject:equippedItemsController];
	equippedItemsController.view.frame = (CGRect){ .origin = kPFEquippedItemsViewOriginPortrait, .size = equippedItemsController.view.frame.size };
	[self.view addSubview:equippedItemsController.view];

	PFInventoryViewController *inventoryController = [[PFInventoryViewController alloc] initWithNibName:@"PFInventoryView" bundle:nil];
	[self.containers addObject:inventoryController];
	inventoryController.view.frame = (CGRect){ .origin = kPFInventoryViewOriginPortrait, .size = inventoryController.view.frame.size };
	[self.view addSubview:inventoryController.view];

	PFMoneyViewController *moneyController = [[PFMoneyViewController alloc] initWithNibName:@"PFMoneyView" bundle:nil];
	[self.containers addObject:moneyController];
	moneyController.view.frame = (CGRect){ .origin = kPFMoneyViewOriginPortrait, .size = moneyController.view.frame.size };
	[self.view addSubview:moneyController.view];

	PFPotionsViewController *potionsController = [[PFPotionsViewController alloc] initWithNibName:@"PFPotionsView" bundle:nil];
	[self.containers addObject:potionsController];
	potionsController.view.frame = (CGRect){ .origin = kPFPotionsViewOriginPortrait, .size = potionsController.view.frame.size };
	[self.view addSubview:potionsController.view];

	PFScrollsViewController *scrollsController = [[PFScrollsViewController alloc] initWithNibName:@"PFScrollsView" bundle:nil];
	[self.containers addObject:scrollsController];
	scrollsController.view.frame = (CGRect){ .origin = kPFScrollsViewOriginPortrait, .size = scrollsController.view.frame.size };
	[self.view addSubview:scrollsController.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
