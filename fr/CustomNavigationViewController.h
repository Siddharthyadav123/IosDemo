//
//  CustomNavigationViewController.h
//  IosApplicationFrameworkProject
//
//  Created by test on 21/07/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"

@class NavigationDrawerViewController;

@interface CustomNavigationViewController : UIViewController<AbstractViewController>
{
    
    NavigationDrawerViewController *navigationDrawerViewController;
    
#pragma Variables for doing Calculations.
    
    int panelWidth;
    float bodyControllerViewCenterMaxXValue;
    float bodyControllerViewCenterMinXValue;
    float bodyViewControllerOriginY;
    float bodyViewControllerWidth;
    float bodyViewControllerHeight;
    float halfOfbodyViewControllerWidth;
    float naviagtionDrawerWidth;

    
    
  
}

@property (strong, nonatomic) IBOutlet UIView *navigationDrawerContainerView;
@property (strong, nonatomic) IBOutlet UIView *bodyContainerView;
//@property (strong, nonatomic) IBOutlet UIView *childControllerView;

#pragma Gesture Recognizer Stubs.
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizerForNavigationDrawer;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizerForHomeScreen;

/*
 * For maintaining currently loaded screen Id.
 */
@property NSInteger currentScreenId;
@property NSInteger previousScreenId;

@property BOOL isSliderDrawerOpen;

@property CGPoint panStartPoint;

- (void)movePanelRight;
- (void)movePanelLeft;
- (void)movePanelToOriginalPosition;

-(void)launchJobListScreenFromSliderDrawer;


@end
