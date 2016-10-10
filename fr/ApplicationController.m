//
//  ApplicationController.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "ApplicationController.h"
#import "AppDefines.h"
#import <Foundation/Foundation.h>
#import "AppConstants.h"
#import "ViewFactory.h"
#import "LocalModel.h"
#import "AbstractViewController.h"


@implementation ApplicationController


#pragma mark - singleton method

+(ApplicationController *)getInstance
{
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    //static id sharedObject = nil;  //if you're not using ARC
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
        //sharedObject = [[[self alloc] init] retain]; // if you're not using ARC
    });
    return sharedObject;
}



/**
 * Constructor of ApplicationController
 */
- (id)init
{
    self = [super init];
    if (self) {
        // Create the instance of ModelFacade
        self->modelfacade = [[ModelFacde alloc] init];
        self->uicontroller =[[UIController alloc] init];
        self->viewFactory = [[ViewFactory alloc] init];
        
        NSLog(@"modelfacade Object Created");
    }
    return self;
}

//-(void)setMainView:(UIView*)uiView
//{
//    [self->uicontroller setMainView:uiView];
//
//}

/**
 * This Function will get called from MainActivity or Any Activity which is
 * going to display first screen after launching this application
 *
 * @param activity
 */
-(void) initialize
{
    [self->modelfacade initialize];
    
    [self->uicontroller initialize];
    
    
    NSLog(@"uicontroller Object Created by calling getInstance");
    
    
    
    NSLog(@"ViewFactory Object Created by calling getInstance");
    
    
}


/*
 * destroy local model
 */
-(void)destroyLocalModel{
    
    LocalModel *localModel = [[self getModelFacade]getLocalModel];
    [localModel destory];
    NSLog(@"DESTROY INSTANCES OF MODELS FROM LOCAL MODEL");
}
/**
 * This function must get called before exiting the application. otherwise
 * there will be chances for memory leakages.
 */
-(void) destroy
{
    if (self->modelfacade != nil)
    {
        // Destroy the ModelFacade
        [self->modelfacade destory];
        
        
        // set modelFacade to null for garbage collection
        self->modelfacade = nil;
    }
    
    if (self->uicontroller != nil)
    {
        [self->uicontroller destory];
        
        self->uicontroller = nil;
    }
    
    if (self->viewFactory != nil)
    {
        [self->viewFactory releaseAllScreen];
        
        self->viewFactory = nil;
    }
    
    
    [super destory];
}

-(void) disable
{
    if (self->uicontroller != nil)
    {
        [self->uicontroller disbale];
    }
    [super disbale];
}

-(void) hideNotify
{
    if (self->uicontroller != nil)
    {
        [self->uicontroller hideNotify];
    }
    [super hideNotify];
}

-(void) showNotify
{
    if (self->uicontroller != nil)
    {
        [self->uicontroller showNotify];
    }
    [super showNotify];
}

-(void) handleEvent:(int)eventId
{
    [super handleEvent:eventId];
    [self handleEvent:eventId andeventObject:nil];
}

-(void) handleEvent:(int)eventId andeventObject:(NSObject *)eventObject
{
    //[super havdleEvent:eventId andeventObject:NULL];
    
    [super handleEvents:eventId AndEventJoin:nil];
    
    switch (eventId) {
            //define cases to handle particular event.
            
            
        case EVENT_ID_SPLASH_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_SPLASH_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_LOGIN_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_LOGIN_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_SIGNUP_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_SIGNUP_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_HOME_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_HOME_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
        case EVENT_ID_EQUIPMENT_DETAILS_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_EQUIPMENT_DETAILS_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_SEARCH_BAR_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_SEARCH_BAR_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
        case EVENT_ID_EQUIPMENT_MAP_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_EQUIPMENT_MAP_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_EQUIPMENT_RENT_REQUEST_RENTER_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_EQUIPMENT_RENT_REQUEST_RENTER_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_RENTAL_REQUEST_LIST_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_RENTAL_REQUEST_LIST_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
        case EVENT_ID_RENTAL_REQUEST_INDIVIDUAL_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_RENTAL_REQUEST_INDIVIDUAL_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_SUPPLIER_REQUEST_INDIVIDUAL_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_SUPPLIER_REQUEST_INDIVIDUAL_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_DASHBOARD_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_DASHBOARD_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_INVENTORY_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_INVENTORY_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_INDIVIDUAL_REQUEST_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_INDIVIDUAL_REQUEST_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_INDIVIDUAL_CONTRACT_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_INDIVIDUAL_CONTRACT_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_CHAT_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_CHAT_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_RENTAL_CONTRACT_LIST_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_RENTAL_CONTRACT_LIST_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_RENTAL_SUPPLIER_INDIVIDUAL_CONTRACT_VIEW_SCREEN :
        {
            
            [self->uicontroller pushScreen:VCT_VIEW_CONTROLLER screenId:VF_RENTAL_SUPPLIER_INDIVIDUAL_CONTRACT_VIEW_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_JOB_LIST_ROOT_CUSTOM_NAVIGATION_CONTROLLER_SCREEN :
        {
            [self->uicontroller pushScreen:VCT_ROOT_CUSTOM_NAVIGATION_CONTROLLER screenId:VF_JOB_LIST_ROOT_CUSTOM_NAVIGATION_CONTROLLER_SCREEN viewFactory:viewFactory eventObject:eventObject];
            break;
        }
            
        case EVENT_ID_FINISH_SCREEN:{
            [self->uicontroller popScreen:VCT_VIEW_CONTROLLER];
            break;
        }
            
        case EVENT_ID_ON_SCREEN_FINISH:{
            [self->uicontroller onScreenPoped];
            break;
        }
            
        case EVENT_ID_FINISH_CHILD_CUSTOM_NAVIGATION_SCREEN:{
            [self->uicontroller popScreen:VCT_CHILD_CUSTOM_NAVIGATION_CONTROLLER];
            break;
        }
            
        case EVENT_ID_DESTROY_LOCAL_MODEL:{
            [self destroyLocalModel];
            break;
        }
    }
    
}


/**
 * Get the reference of ModelFacade
 *
 * @return ModelFacade
 */
-(ModelFacde *)getModelFacade
{
    return modelfacade;
}

/**
 * Get the reference of UIController
 *
 * @return
 */
-(UIController *)getUiConroller
{
    return uicontroller;
}

/**
 * Get the reference of View Factory
 *
 * @return
 */
-(ViewFactory *) getViewFactory;{
    return viewFactory;
}

-(void) closeStackedActivity
{
    
}

-(void) closeApplication
{
    
}

@end
