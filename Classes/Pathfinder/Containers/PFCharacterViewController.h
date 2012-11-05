//
//  PFCharacterViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import "PFContainerViewController.h"

@interface PFCharacterViewController : PFContainerViewController

@property (nonatomic, strong) IBOutlet UITextField *characterField;
@property (nonatomic, strong) IBOutlet UITextField *playerField;
@property (nonatomic, strong) IBOutlet UITextField *campaignField;

@property (nonatomic, strong) IBOutlet UILabel *alignmentLabel;
@property (nonatomic, strong) IBOutlet UILabel *genderLabel;
@property (nonatomic, strong) IBOutlet UILabel *raceLabel;
@property (nonatomic, strong) IBOutlet UILabel *sizeLabel;

@property (nonatomic, strong) IBOutlet UIButton *raceButton;

@end
