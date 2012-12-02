//
//  PFClassFeatureCell.h
//  CharMgr
//
//  Created by Leif Harrison on 12/1/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerCell.h"

@interface PFClassFeatureCell : PFContainerCell

@property (nonatomic, strong) IBOutlet UILabel *featureNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *featureLevelLabel;

+ (CGFloat)rowHeightForState:(PFContainerViewState)aState;

@end
