//
//  PFCharacterViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import "PFContainerViewController.h"

#import "PFDetailViewController.h"

@interface PFCharacterViewController : PFContainerViewController
	<UIPopoverControllerDelegate, PFDetailViewControllerDelegate>

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *titleLabels;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *valueFields;

@property (nonatomic, strong) IBOutlet UITextField *characterField;
@property (nonatomic, strong) IBOutlet UITextField *playerField;
@property (nonatomic, strong) IBOutlet UITextField *campaignField;

@property (nonatomic, strong) IBOutlet UIButton *alignmentButton;
@property (nonatomic, strong) IBOutlet UIButton *genderButton;
@property (nonatomic, strong) IBOutlet UIButton *raceButton;
@property (nonatomic, strong) IBOutlet UIButton *sizeButton;

@end
