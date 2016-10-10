//
//  ApplicationController.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//


#ifndef __APP_CONTROLLER_H__
#define __APP_CONTROLLER_H__

#import "Controller.h"
#import "AppDefines.h"
#import "ModelFacde.h"
#import "Controller.h"
#import "UIController.h"
#import "AppConstants.h"
#import "UserDefaultPreferences.h"

@class ViewFactory;

@interface ApplicationController :Controller

{
    /**
     * private instance of ModelFacade. I only can be used via getter method,
     * and there will be no setter method for this variable. so do not make it
     * public
     */
    ModelFacde *modelfacade;
    
    /**
     * private instance of UIController for managing different AbstractViews
     */
    UIController *uicontroller;
    
    /**
     * private instance of ViewFactory for fast accessing.
     */
    ViewFactory *viewFactory;
    
    LocalModel *localModel;
   
}

+(ApplicationController *)getInstance;

-(void) launchCustomNavigationControllerScreen;
-(void) handleEvent:(int)eventId andeventObject:(NSObject *)eventObject;
-(void) handleEvent:(int)eventId;

-(ModelFacde *) getModelFacade;
-(UIController *) getUiConroller;
-(ViewFactory *) getViewFactory;

-(void) closeApplication;



@end

#endif

