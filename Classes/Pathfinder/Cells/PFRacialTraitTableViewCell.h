//
//  PFRacialTraitTableViewCell.h
//  CharMgr
//
//  Created by Leif Harrison on 10/30/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import "PFContainerCell.h"

@class PFRacialTrait;

@interface PFRacialTraitTableViewCell : PFContainerCell

@property (nonatomic, strong) IBOutlet UILabel *traitNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *traitDescriptionLabel;

@end
