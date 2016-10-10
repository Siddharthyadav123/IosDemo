//
//  ActionBarView.h
//  FleetRight
//
//  Created by test on 16/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationController.h"
#import "AppConstants.h"


@class DemoTableController;
@class BaseViewController;


@interface ActionBarView : UIView

@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UIButton *moreButton;
@property (strong, nonatomic) IBOutlet UIButton *notificationButton;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) IBOutlet UIButton *showFilterButton;
@property (strong, nonatomic) IBOutlet UIButton *homeScreenLogoButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UILabel *shoeFilterLabel;
@property (weak, nonatomic) IBOutlet UIImageView *filterArrowImage;

- (IBAction)notificationButtonClicked:(id)sender;
- (IBAction)messageButtonClicked:(id)sender;
- (IBAction)moreButtonClicked:(id)sender;
- (IBAction)showFilterButtonClicked:(id)sender;
- (IBAction)homeScreenLogoButtonClicked:(id)sender;
- (IBAction)searchButtonClicked:(id)sender;


@property (strong, nonatomic) BaseViewController *baseViewController;

@end
