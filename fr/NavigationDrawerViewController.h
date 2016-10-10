//
//  NavigationDrawerViewController.h
//  IosApplicationFrameworkProject
//
//  Created by test on 21/07/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "AbstractViewController.h"
#import "ApplicationController.h"
#import "ViewFactory.h"
#import "LocalModel.h"
#import "CustomAlertView.h"

@class CustomNavigationViewController;

@interface NavigationDrawerViewController : UIViewController<AbstractViewController,CustomAlertViewDelegate>
{
    LocalModel *localModel;
  
}
@property (strong, nonatomic) IBOutlet UIView *navigationDrawerContainerView;
@property (strong, nonatomic) IBOutlet UIView *profileBackgroundView;


@property (strong, nonatomic) IBOutlet UIView *jobListView;
@property (strong, nonatomic) IBOutlet UIView *jobMapView;
@property (strong, nonatomic) IBOutlet UIView *jobSearchView;
@property (strong, nonatomic) IBOutlet UIView *logoutView;

@property (strong, nonatomic) IBOutlet UIButton *jobListButton;
- (IBAction)jobListButtonClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *jobMapButton;
- (IBAction)jobMapButtonClicked:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *jobSearchButton;
- (IBAction)jobSearchButtonClicked:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
- (IBAction)logoutButtonClicked:(id)sender;


@property (strong, nonatomic) CustomNavigationViewController *customNavigationViewController;


@property (weak, nonatomic) IBOutlet UILabel *driverNameText;

@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizerForJobListView;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizerForJobMapView;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizerForJobSearchView;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizerForLogoutView;

@property NSInteger navigationDrawerOriginalWidth;
@end
