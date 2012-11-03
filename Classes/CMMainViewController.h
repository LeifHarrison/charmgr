//
//  CMMainViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFBaseViewController.h"

#import <CoreData/CoreData.h>

#import "PFCreateCharacterViewController.h"


@interface CMMainViewController : PFBaseViewController <NSFetchedResultsControllerDelegate, PFCreateCharacterViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *charactersTableView;
@property (nonatomic, strong) IBOutlet UIButton *createCharacterButton;

- (IBAction)showReferenceView:(id)sender;
- (IBAction)showPreferencesView:(id)sender;

- (NSArray *)createViewControllersForCharacter:(PFCharacter*)aCharacter;

@end
