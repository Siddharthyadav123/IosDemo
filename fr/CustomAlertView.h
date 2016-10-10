//
//  CustomAlertView.h
//  CustomAlertViewProject
//
//  Created by ranjit singh on 9/23/15.
//  Copyright (c) 2015 ranjit singh. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class ViewController;

#define LEFT_BUTTON_TAG 0
#define RIGHT_BUTTON_TAG 1
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//Delegate to get call back from viewcontroller.
@protocol CustomAlertViewDelegate <NSObject>
@optional

-(void)onAlertViewLeftButtonClicked:(int)identifier;
-(void)onAlertViewRightButtonClicked:(int)identifier;
@end

@interface CustomAlertView : NSObject<UIAlertViewDelegate>

{
    int sender;
}

/*
 * The alertview instatnce to be maintained if iOS version below 8.
 */
@property UIAlertView *alertView;

/*
 * The alertview controller instatnce to be maintained if iOS version is 8 or above.
 */
@property UIAlertController *alertViewController;

/*
 * Instance of message is maintain
 */
@property (strong,nonatomic) NSString* message;

/*
 * Instance of title is maintain
 */
@property (strong,nonatomic) NSString* title;

/*
 * To recognize for which this alertview is performing/working.
 */
@property int identifier;
/*
 * Show Alert view .
 */
-(void) show:(UIViewController *)presentViewController;

/*
 * Custom Alertview Deligate Instance
 */
@property (nonatomic, weak) id <CustomAlertViewDelegate> delegate;


/*
 * Method called from controller to create and display alertview or alertController as per the version of current device.
 */
-(void)addButtons:(NSString*)leftButtonTitle rightButtonTitle:(NSString*)rightButtonTitle;

/*
 * Method called from controller to create and display alertview or alertController as per the version of current device.
 */
+(CustomAlertView*) createCustomAlertView:(NSString*)title alertMessage:(NSString*)message leftButtonTitle:(NSString*)leftButtonTitle rightButtonTitle:(NSString*)rightButtonTitle delegate:(id <CustomAlertViewDelegate>) delegate identifier:(int)identifier;


/*
 * Method called from controller to create and display progress dialog as per the version of current device. It takes paramater like title to set title, custom alertview delegate and an identifier to know from which dialog this method is called.
 */
+(CustomAlertView*) createCustomProgressDialog:(NSString*)title delegate:(id <CustomAlertViewDelegate>) delegate identifier:(int)identifier;

/*
 * Method to dismiss progress dialog.
 */
-(void)dismissCustomProgressDialog:(void(^)(void)) completion;

@end
