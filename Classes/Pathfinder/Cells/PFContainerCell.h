//
//  PFContainerCell.h
//  CharMgr
//
//  Created by Leif Harrison on 11/30/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFContainerViewController.h" // for PFContainerViewState

@interface PFContainerCell : UITableViewCell

@property (nonatomic, assign) PFContainerViewState containerState;

- (void)setContainerState:(PFContainerViewState)newState animated:(BOOL)animated;

@end
