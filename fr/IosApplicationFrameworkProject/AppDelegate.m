//
//  AppDelegate.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "AppDelegate.h"
#import "RootUIViewController.h"
#import "ApplicationController.h"
#import "HomeScreenViewController.h"
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //here set the our root view controller to the winddow's root.
    RootUIViewController *rootUIViewController =[RootUIViewController alloc];
    
    self.window = [[UIWindow alloc]
                   initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = rootUIViewController;
    
    
    //below function should get call only once in the whole life cycle of the app.
    [[ApplicationController getInstance] initialize];
    
    //    //here sets the main root view controller to the UI Controller.
    
    
    [[[ApplicationController getInstance]getUiConroller]setRootViewController:self.window.rootViewController];
    
//    HomeScreenViewController *splash= [HomeScreenViewController alloc];
//    self.window.rootViewController=splash;
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}


-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    // This is in order to allow views that do not support landscape mode to be able to load in
     
    return UIInterfaceOrientationMaskPortrait;
}



@end
