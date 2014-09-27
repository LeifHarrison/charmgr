//
//  PFCharacterViewController.h
//  CharMgr
//
//  Created by Leif Harrison on 9/6/12.
//
//

#import "PFContainerViewController.h"

@interface PFCharacterViewController : PFContainerViewController
{
	id<UIViewControllerTransitioningDelegate> transitioningDelegate;
}

@property (nonatomic) IBOutlet UILabel *characterLabel;
@property (nonatomic) IBOutlet UILabel *playerLabel;
@property (nonatomic) IBOutlet UILabel *campaignLabel;

@property (nonatomic) IBOutlet UILabel *alignmentLabel;
@property (nonatomic) IBOutlet UILabel *genderLabel;
@property (nonatomic) IBOutlet UILabel *raceLabel;
@property (nonatomic) IBOutlet UILabel *sizeLabel;

@end
