//
//  RootUIViewController.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/4/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef __ROOT_UIVIEW_CONTROLLER_H__
#define __ROOT_UIVIEW_CONTROLLER_H__

#import "AbstractViewController.h"
#import <UIKit/UIKit.h>
#import "LocalModel.h"
#import "SignInScreenModel.h"
#import "UserDefaultPreferences.h"

@interface RootUIViewController : UIViewController <AbstractViewController>
{

    LocalModel *localModel;
    UserDefaultPreferences *userDefaultPreferences;
    NSString* username;
    NSString* password;

}



@end

#endif