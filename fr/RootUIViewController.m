//
//  RootUIViewController.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/4/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "RootUIViewController.h"
#import "ApplicationController.h"

@interface RootUIViewController ()

@end

@implementation RootUIViewController

NSData *loginResponseDataFromPref;
NSData *truckEntrySavedResponseDataFromPref;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeInstances];
    [self getDataFromPreferences];
    
}


/*
 * initialize instances
 */

-(void)initializeInstances{
    localModel = [[[ApplicationController getInstance] getModelFacade] getLocalModel];
    userDefaultPreferences = [UserDefaultPreferences getInstance];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
  
    [super viewDidAppear:animated];
    
    NSLog(@"In Rootview controller");
    //If user is already login so just launch home screen
    if ((username!=nil && username.length>0) && (password!=nil && password.length>0)) {
        [[ApplicationController getInstance] handleEvent:EVENT_ID_HOME_SCREEN];
    }
    else{
        //First time launch login screen
        [[ApplicationController getInstance] handleEvent:EVENT_ID_LOGIN_SCREEN];
        
    }
    
   
   //  [[ApplicationController getInstance]handleEvent:EVENT_ID_CHAT_VIEW_SCREEN];
    
}

/*
 * Method to get data from preferences
 */
-(void)getDataFromPreferences{
    NSString *prefUserNameKey = PREF_KEY_USERNAME;
    NSString *prefPasswordKey = PREF_KEY_PASSWORD;
    username = [userDefaultPreferences getString:prefUserNameKey];
    password = [userDefaultPreferences getString:prefPasswordKey];
}


/**
 * To initialize the Views or Screens, Models
 *
 */
-(void) initialize{
    NSLog(@"Root Controller initialize");
}


/**
 * To reinitialize the View or Screen. This is for some cases when user
 * implement freeResource to optimize memory issue.
 */


-(void) reInitialize{
    NSLog(@"Root Controller reInitialize");
    
}

/**
 * To free only View releated stuff.
 *
 */
-(void) freeResources{
    NSLog(@"Root Controller freeResources");
    
}

/**
 * Destroy View and Model Data for the given Screen.
 *
 */
-(void) destory{
    NSLog(@"Root Controller destory");
    
}

/**
 * This function get called whenever AbstractView redisplay on device screen
 *
 */

-(void) enable{
    NSLog(@"Root Controller enable");
    
}


/**
 * This function get called whenever AbstractView overlapped by another
 * AbstractView
 */

-(void) disbale{
    NSLog(@"Root Controller disbale");
    
}



/**
 * To notify the AbstarctView, that there is an interruption. So
 * AbstractView can handle all the required condition before going
 * application in background.
 *
 */

-(void) showNotify{
    NSLog(@"Root Controller showNotify");
    
}

/**
 * To notify the AbstractView that application will be visible on the screen
 * after calling this method.
 */

-(void) hideNotify{
    NSLog(@"Root Controller hideNotify");
}


/**
 * To update a view
 */

-(void) update{
    NSLog(@"Root Controller update");
    
}

@end
