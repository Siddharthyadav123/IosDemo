//
//  SignupScreenViewController.h
//  FleetRight
//
//  Created by test on 12/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "LocalModel.h"
#import "SignUpScreenModel.h"
#import "SignUpDo.h"
#import "CustomAlertView.h"
#import "Utils.h"
#import "AppConstants.h"

@interface SignupScreenViewController : BaseViewController<UITextFieldDelegate,UIScrollViewDelegate,CustomAlertViewDelegate>
{
    UITextField* activeField;
    SignUpDo *signUpDo;
    CustomAlertView *customAlertView;
    CustomAlertView *progressAlertView;
   
}


@property (strong, nonatomic) IBOutlet UIView *alphaView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UIView *usernameView;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UIView *conformPasswordView;
@property (strong, nonatomic) IBOutlet UIView *contactNumberView;

@property (strong, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (strong, nonatomic) IBOutlet UITextField *emailTextfield;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (strong, nonatomic) IBOutlet UITextField *conformPassword;
@property (strong, nonatomic) IBOutlet UITextField *contactNumberTextfield;


@property (strong, nonatomic) IBOutlet UIButton *registerButton;
- (IBAction)registerButtonClicked:(id)sender;
- (IBAction)alreadyLoginButtonClicked:(id)sender;


@property(strong,nonatomic)SignUpScreenModel *signUpScreenModel;

@end
