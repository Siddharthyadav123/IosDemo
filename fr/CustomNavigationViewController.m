//
//  CustomNavigationViewController.m
//  IosApplicationFrameworkProject
//
//  Created by test on 21/07/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "CustomNavigationViewController.h"
#import "ApplicationController.h"
#import "NavigationDrawerViewController.h"

@implementation CustomNavigationViewController
@synthesize isSliderDrawerOpen;
@synthesize panGestureRecognizer,tapGestureRecognizerForHomeScreen,tapGestureRecognizerForNavigationDrawer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self onNewRootCustomNavigationControllerPushed:self];
    [self addJobListScreenAsRootChildView];
    
    [self setNavigationDrawerView];
    
    [self setValuesAsPerDeviceType];
    
    [self setGestureRecognizersOnView];
    
    [self initializeValues];
    [self initialize];
}

/*
 * Do here some initialization code.
 */
-(void)initialize{
    [Utils setBorderToView:self.bodyContainerView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) update{
    
    
}



/*
 * Here, launching the Job list screen as root view for this controller.
 */
-(void) addJobListScreenAsRootChildView{
    /*
     * IMP: ADD ANY CONTROLLER WHICH IS ROOT VIEW OF NAVIGATION CONTROLLER
     */
    //[[ApplicationController getInstance]handleEvent:EVENT_ID_JOB_LIST_SCREEN];
    
}


/**
 * Method to set navigation drawer view controller as child view controller in Custom Navigation Controller.
 **/
- (void)setNavigationDrawerView
{
    
    if (navigationDrawerViewController == nil)
    {
        // this is where you define the view for the right panel
        navigationDrawerViewController = [[NavigationDrawerViewController alloc] initWithNibName:@"NavigationDrawerViewController" bundle:nil];
        
        [self.navigationDrawerContainerView addSubview:navigationDrawerViewController.view];
        
        [self addChildViewController:navigationDrawerViewController];
        [navigationDrawerViewController didMoveToParentViewController:self];
        
        [self.navigationDrawerContainerView sendSubviewToBack:navigationDrawerViewController.view];
    }
    
}


/*
 * Method to initialize values as per device type i.e. iPhone or iPad.
 */
-(void) setValuesAsPerDeviceType{
    
    //To set panelwidth and navigation drawer width as per device size.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        NSLog(@"device height: %f",[UIScreen mainScreen].bounds.size.width);
        panelWidth = 90;
        naviagtionDrawerWidth = navigationDrawerViewController.navigationDrawerOriginalWidth;
        
    } else {
        
        panelWidth = 268;
        naviagtionDrawerWidth = navigationDrawerViewController.navigationDrawerOriginalWidth;

    }
    
}


/**
 * Method to initialize values which are repeatedly used.
 **/
-(void)initializeValues{
    
    bodyControllerViewCenterMinXValue = self.bodyContainerView.center.x;
    bodyControllerViewCenterMaxXValue = self.bodyContainerView.center.x+500;
    bodyViewControllerOriginY = self.bodyContainerView.frame.origin.y;
    bodyViewControllerWidth = self.bodyContainerView.frame.size.width;
    bodyViewControllerHeight = self.bodyContainerView.frame.size.height;
    halfOfbodyViewControllerWidth = bodyViewControllerWidth/2.0;

    
}



/**
 * Method to set gesture recognizer on the home screen view controller and navigation drawer view controller.
 **/
-(void)setGestureRecognizersOnView{
    
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.bodyContainerView addGestureRecognizer:panGestureRecognizer];
    
    tapGestureRecognizerForNavigationDrawer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureForNavigationDrawer:)];
    [self.navigationDrawerContainerView addGestureRecognizer:tapGestureRecognizerForNavigationDrawer];
    
    tapGestureRecognizerForHomeScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureForHomeScreen:)];
    [self.bodyContainerView addGestureRecognizer:tapGestureRecognizerForHomeScreen];
    
}


/**
 * Method to handle pan gesture recognizer on home screen view controller.
 **/
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
    
    NSLog(@">>> handlePanGesture called");
    
    //This condition calls when we first touch on to the screen.
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.panStartPoint = [recognizer locationInView:self.bodyContainerView];
        
    }
    
    //This condition calls when we move the touch on to the screen.
    if (recognizer.state == UIGestureRecognizerStateChanged){
        
        if (self.panStartPoint.x < halfOfbodyViewControllerWidth){
            
            [self setNavigationDrawerView];
            
            //Condition to check weather user touches on to the screen within limit or not.
            if(recognizer.view.center.x <= bodyControllerViewCenterMaxXValue && recognizer.view.center.x >= bodyControllerViewCenterMinXValue)
            {
                // Code to move the home screen controller upto perticular limit horizontally.
                CGPoint translation = [recognizer translationInView:self.bodyContainerView];
                float newXValue = recognizer.view.center.x + translation.x;
                
                if(newXValue<bodyControllerViewCenterMinXValue){
                    newXValue = bodyControllerViewCenterMinXValue;
                }else if(newXValue>bodyControllerViewCenterMaxXValue){
                    newXValue = bodyControllerViewCenterMaxXValue;
                }
                
                
                recognizer.view.center = CGPointMake(newXValue,
                                                     recognizer.view.center.y);
                [recognizer setTranslation:CGPointMake(0, 0) inView:self.bodyContainerView];
            }
            NSLog(@"Navigation Drawer Width: %f",naviagtionDrawerWidth);
            // To set home screen view controller on proper position after moving.
            if (self.bodyContainerView.frame.origin.x > naviagtionDrawerWidth) {
                
                NSLog(@"Navigation Drawer Width: %f",naviagtionDrawerWidth);
                isSliderDrawerOpen = YES;
                
                self.bodyContainerView.frame = CGRectMake(naviagtionDrawerWidth, self.bodyContainerView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                
                [tapGestureRecognizerForHomeScreen setEnabled:YES];
                
            }
            if (self.bodyContainerView.frame.origin.x <0) {
                isSliderDrawerOpen = NO;
              
                [tapGestureRecognizerForHomeScreen setEnabled:NO];
               
                self.bodyContainerView.frame = CGRectMake(0, self.bodyContainerView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            }
        }
        
        //        } else if (self.panStartPoint.x > halfOfHomeScreenViewControllerWidth) {
        //
        //            [self setNotificationSliderDrawerView];
        //
        //            NSLog(@"setNotificationSliderDrawerView called");
        //        }
        
    }
    
    // This condition calls when we end the touch and decid weather to open the navigation drawer or not.
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint endPoint = [recognizer locationInView:self.bodyContainerView];
        
        if (endPoint.x >= 50.0) {
            isSliderDrawerOpen = YES;
            
            [tapGestureRecognizerForHomeScreen setEnabled:YES];
            
        }
        
        if(self.panStartPoint.x < halfOfbodyViewControllerWidth){
            
            if (self.bodyContainerView.frame.origin.x >= naviagtionDrawerWidth / 2 && self.bodyContainerView.frame.origin.x < naviagtionDrawerWidth) {
                
                isSliderDrawerOpen = YES;
                
                [self movePanelRight];
                
                
            }
            else if(self.bodyContainerView.frame.origin.x < naviagtionDrawerWidth / 2 && self.bodyContainerView.frame.origin.x > 0){
                
                isSliderDrawerOpen = NO;
                
                [self movePanelToOriginalPosition];
                
            }
        }
        
    }
    
    
}



/**
 * Method to handle tap gesture recognizer on navigation drawer.
 **/
- (void)handleTapGestureForNavigationDrawer:(UIPanGestureRecognizer *)recognizer{
    
    [self movePanelToOriginalPosition];
    
    NSLog(@">>> handleTapGestureForNavigationDrawer called");
}

/**
 * Method to handle tap gesture recognizer on Home Screen.
 **/
- (void)handleTapGestureForHomeScreen:(UIPanGestureRecognizer *)recognizer{

        
    [self movePanelToOriginalPosition];
    
    NSLog(@">>> handleTapGestureForHomeScreen called");
 
}


/**
 * Method to display navigation drawer by moving panel right.
 **/
- (void)movePanelRight // to show left panel
{
    [self setNavigationDrawerView];
    
    [tapGestureRecognizerForHomeScreen setEnabled:YES];
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.bodyContainerView.frame = CGRectMake(naviagtionDrawerWidth, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                         }
                     }];
    
    isSliderDrawerOpen = YES;
    
}

/**
 * Method to display navigation drawer by moving panel left.
 **/
-(void)movePanelLeft{
    
//    [self setNotificationSliderDrawerView];
    
    [tapGestureRecognizerForHomeScreen setEnabled:YES];
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.bodyContainerView.frame = CGRectMake(-naviagtionDrawerWidth, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                            
                         }
                     }];
    
    isSliderDrawerOpen = YES;
}

/**
 * Method to hide navigation drawer by moving panel to its original position.
 **/
- (void)movePanelToOriginalPosition
{
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.bodyContainerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                           
                         }
                     }];
    
    [tapGestureRecognizerForHomeScreen setEnabled:NO];
    
    isSliderDrawerOpen = NO;
    
}


/*
 * Method to launch Job List Screen From Slider Drawer.
 */
-(void)launchJobListScreenFromSliderDrawer{
    
}

/*
 * Method calls when response from server comes. It override update method.
 */
-(void)update:(int)identifier{
    
}


-(void)onScreenPopedUp{
    
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
