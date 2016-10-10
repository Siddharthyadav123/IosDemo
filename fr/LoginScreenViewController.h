//
//  LoginScreenViewController.h
//  IosApplicationFrameworkProject
//
//  Created by test on 11/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "ApplicationController.h"
#import "SignInScreenModel.h"
#import "LoginDo.h"
#import "CustomAlertView.h"
#import "AppConstants.h"
#import "UserDefaultPreferences.h"


@interface LoginScreenViewController : BaseViewController<UITextFieldDelegate,UIScrollViewDelegate,CustomAlertViewDelegate>
{
    UITextField* activeField;
    LoginDo *loginDo;
    CustomAlertView *customAlertView;
    CustomAlertView *progressAlertView;
    UserDefaultPreferences *preferences;
    NSString* username;
    NSString* password;

}
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UIView *usernameView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UIView *alphaView;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)signUpButtonClicked:(id)sender;
- (IBAction)forgotPasswordButtonClicked:(id)sender;

@property (strong, nonatomic)SignInScreenModel *signInScreenModel;


@end
