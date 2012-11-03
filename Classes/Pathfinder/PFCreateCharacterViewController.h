//
//  PFCreateCharacterViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/7/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFCharacter;

@protocol PFCreateCharacterViewControllerDelegate;

@interface PFCreateCharacterViewController : UIViewController

@property (nonatomic, strong) PFCharacter *character;

@property (nonatomic, weak) id <PFCreateCharacterViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end

@protocol PFCreateCharacterViewControllerDelegate

- (void)createCharacterViewController:(PFCreateCharacterViewController *)controller
					didFinishWithSave:(BOOL)save;

@end