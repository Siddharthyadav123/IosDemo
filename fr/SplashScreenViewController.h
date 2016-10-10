//
//  SplashScreenViewController.h
//  IosApplicationFrameworkProject
//
//  Created by test on 16/07/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef __SPLASH_SCREEN_VIEW_CONTROLLER_H__
#define __SPLASH_SCREEN_VIEW_CONTROLLER_H__


#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Utils.h"

@interface SplashScreenViewController : BaseViewController
{
    
    /*
     * If splash was already launched then set it to YES or NO.
     */
    BOOL wasSplashAlreadyLaunched;
    LocalModel *localModel;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *splashBackgroundImageview;

@property (strong,nonatomic) UserDefaultPreferences *userDefaultPreferences;

@end

#endif