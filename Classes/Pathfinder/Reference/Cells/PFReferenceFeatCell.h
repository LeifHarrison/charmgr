//
//  PFReferenceFeatCell.h
//  CharMgr
//
//  Created by Leif Harrison on 11/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFReferenceFeatCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *featNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *featTypeLabel;
@property (nonatomic, strong) IBOutlet UILabel *featSourceLabel;
@property (nonatomic, strong) IBOutlet UILabel *prerequisitesLabel;
@property (nonatomic, strong) IBOutlet UILabel *benefitLabel;

@end
