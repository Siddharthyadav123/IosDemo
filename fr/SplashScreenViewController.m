//
//  SplashScreenViewController.m
//  IosApplicationFrameworkProject
//
//  Created by test on 16/07/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "SplashScreenViewController.h"

@implementation SplashScreenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializeInstances];
    [self setSplashImage];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self setTimerToLaunchNextScreen];
}

/*
 * initialize instances
 */

-(void)initializeInstances{
    localModel = [[[ApplicationController getInstance] getModelFacade] getLocalModel];
    _userDefaultPreferences = [UserDefaultPreferences getInstance];
}

/*
 * Method to set splash image to imageview.
 */
-(void)setSplashImage{
    
    @autoreleasepool {
        
        //Here we set the filepath of splash screen image.
        NSString *fileLocation = [[NSBundle mainBundle] pathForResource:@"splashscreen" ofType:@"png"];
        
        UIImage* yourImage = [[UIImage alloc] initWithContentsOfFile:fileLocation];
        
        //Set splash image to splashBackgroundImageview.
        [_splashBackgroundImageview setImage:yourImage];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Method to set Timer on Splash Screen to launch next screen (Login Screen).
 */
-(void) setTimerToLaunchNextScreen{
    
    [NSTimer scheduledTimerWithTimeInterval:SPLASH_SCREEN_DISPLAY_LENGTH
                                     target:self
                                   selector:@selector(launchNextScreen)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

/*
 * NSTimer Selector Method to launch Next Screen.
 */
-(void)launchNextScreen{
    
   }

-(void) update{
    
    
}

-(void)onScreenPopedUp{
    NSLog(@"Splash >> Onscreen Popped Up");
}

/*
 * Gets callback on top screen finished
 */
-(void) onTopScreenFinished{
    NSLog(@"Load data on back press");
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self destroy];
}

/**
 * Destroy View and Model Data for the given Screen.
 *
 */
-(void) destroy{
    
    if (_splashBackgroundImageview!=nil) {
        
        _splashBackgroundImageview.image = nil;
        
        [_splashBackgroundImageview removeFromSuperview];
        
        _splashBackgroundImageview = nil;
    }
    
    [self.view removeFromSuperview];
    
}



@end
