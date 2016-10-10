//
//  NavigationDrawerViewController.m
//  IosApplicationFrameworkProject
//
//  Created by test on 21/07/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "NavigationDrawerViewController.h"
#import "CustomNavigationViewController.h"
#import "Utils.h"
#import "UIUtils.h"



@implementation NavigationDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setViewBackgroundColor];
    [self initializeInstances];
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Method to initialize instances
 */
-(void)initializeInstances{
    localModel = [[[ApplicationController getInstance] getModelFacade] getLocalModel];
    
    self.navigationDrawerOriginalWidth = self.navigationDrawerContainerView.frame.size.width;
    
    _customNavigationViewController = [[ApplicationController getInstance] getViewFactory].jobListCustomNavigationViewController;
    
   
}

-(void)setViewBackgroundColor{
    
    UIColor *appThemeBlueColor = [Utils getUIColorObjectFromHexString:APP_THEME_BLUE_COLOR alpha:1.0];
    
    //    UIColor *appThemeGreenColor = [Utils getUIColorObjectFromHexString:App_THEME_GREEN_COLOR alpha:1.0];
    
    [self.profileBackgroundView setBackgroundColor:appThemeBlueColor];
    
}

//Calls from logout model
-(void)update{
   
}


-(void)onScreenPopedUp{
    
}

/*
 * Method calls when response from server comes. It override update method.
 */
-(void)update:(int)identifier{
    
}



/*
 * Gets callback on top screen finished
 */
-(void) onTopScreenFinished{
    NSLog(@"Load data on back press");
}

/**
 * Destroy View and Model Data for the given Screen.
 *
 */
-(void) destroy{
    
    
}

@end
