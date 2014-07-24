//
//  PFReferenceClassCell.h
//  CharMgr
//
//  Created by Leif Harrison on 7/22/14.
//  Copyright (c) 2014 Leif Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFReferenceClassCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *classNameLabel;
@property (nonatomic) IBOutlet UILabel *sourceLabel;
@property (nonatomic) IBOutlet UILabel *hitDieTypeLabel;
@property (nonatomic) IBOutlet UILabel *alignmentLabel;
@property (nonatomic) IBOutlet UILabel *descriptionLabel;

@end
