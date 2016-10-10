//
//  UIController.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef __UI_CONTROLLER_H__
#define __UI_CONTROLLER_H__


#import <Foundation/Foundation.h>
#import "IController.h"
#import <UIKit/UIKit.h>
#import "AbstractViewController.h"
@class CustomNavigationViewController;
@class ViewFactory;

@interface UIController : NSObject<IController>
{
    
    /*
     Points to current visible UI view.
     */
    id <AbstractViewController> currentUIViewController;
    /*
     Points to prev UI VIew.
     */
    id <AbstractViewController> prevUIViewController;
    /*
     Maintains the All UI in the stack.
     */
    NSMutableArray *UIStack;
    
    id <AbstractViewController> mainRootUIViewController;
}
@property CustomNavigationViewController *jobListCustomNavigationController;
-(void)onNewScreenPushed;
-(void) onScreenPoped;
-(void)pushScreen:(int)viewControllerType screenId:(int)screenId viewFactory:(ViewFactory*)viewFactory eventObject:(NSObject *)eventObject;
-(void)popScreen:(int)viewControllerType;

//-(void)setMainView:(UIView*)uiView;
-(void)setRootViewController:(UIViewController*)uiViewController;
-(UIViewController*)getRootViewController;
-(UIViewController*)getCurrentUIViewController;
@property(nonatomic,strong)NSMutableArray *UIStack;

-(void)clearUIStack;
@end

#endif