//
//  AppDelegate.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalModel.h"
#import "UserDefaultPreferences.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) UIViewController *splashscreenViewController;
@property (strong,nonatomic)LocalModel *localModel;
@property (strong,nonatomic) UserDefaultPreferences *userDefaultPreferences ;

@end

