//
//  PFClassTableViewCell.h
//  CharMgr
//
//  Created by Leif Harrison on 10/17/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFClassTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *classNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *hitDieTypeLabel;
@property (nonatomic, strong) IBOutlet UILabel *skillRanksLabel;
@property (nonatomic, strong) IBOutlet UILabel *levelLabel;

@end
