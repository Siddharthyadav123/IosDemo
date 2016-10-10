//
//  LoginScreenViewController.m
//  IosApplicationFrameworkProject
//
//  Created by test on 11/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "LoginScreenViewController.h"
#import "SignupScreenViewController.h"
#import "Utils.h"


@interface LoginScreenViewController ()

@end

@implementation LoginScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeInstance];
    [self initializeViews];
    [self applyTapGestureOnView];
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Method to initialize instance
 */
-(void)initializeInstance{
    [super initializeInstance];
    
    activeField.delegate = self;
    self.usernameTextField.tag = 1;
    self.passwordTextField.tag = 2;
    
    preferences = [UserDefaultPreferences getInstance];
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    progressAlertView = [CustomAlertView createCustomProgressDialog:CUSTOM_ALERT_PROGRESS_TITLE delegate:self identifier:2];
    loginDo = [[LoginDo alloc]init];
    self.signInScreenModel = [[SignInScreenModel alloc]init];
    self.localModel.signInScreenModel = self.signInScreenModel;
    [self.signInScreenModel registerview:self];
    
}

/*
 * Method to initialize views
 */
-(void)initializeViews{
    self.scrollView.contentSize = CGSizeMake(self.parentView.frame.size.width, self.parentView.frame.size.height);
    [Utils roundButtonCorner: self.loginButton];
    [Utils setBorderToView:self.usernameView];
    [Utils setBorderToView:self.passwordView];
    [Utils changePlaceHolderColour:self.usernameTextField];
    [Utils changePlaceHolderColour:self.passwordTextField];
    [activeField resignFirstResponder];
}

/*
 * Method to apply tap gesture on parent views
 */
-(void)applyTapGestureOnView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.parentView addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [activeField resignFirstResponder];
}

- (IBAction)loginButtonClicked:(id)sender {
    
    if([self isStoredDataInDao]){
        self.signInScreenModel.loginDo = loginDo;
        [progressAlertView show:self];
        [self.signInScreenModel initialize];
        
    }
    else{
        [customAlertView show:self];
    }
    
    //   [[ApplicationController getInstance] handleEvent:EVENT_ID_HOME_SCREEN];
    
    
}



- (IBAction)signUpButtonClicked:(id)sender {
    [[ApplicationController getInstance]handleEvent:EVENT_ID_SIGNUP_SCREEN];
    
}

- (IBAction)forgotPasswordButtonClicked:(id)sender {
    
}

/*
 * Method to store text field data into SignUpDo
 */
-(BOOL)isStoredDataInDao{
    
    //Validate username Text field should not be empty
    if (![self.usernameTextField.text isEqual:@""]) {
        loginDo.userNameText = self.usernameTextField.text;
        
    }
    //Validate password Text field should not be empty
    if (![self.passwordTextField.text isEqual:@""]) {
        loginDo.passwordText = self.passwordTextField.text;
    }
    else{
        [customAlertView setMessage:MANDATORY_FIELD_ERROR_MESSAGE];
        return false;
    }
    return true;
    
}


/*
 * Update: Method gets called when response come form server (From model's informView method)
 */
-(void)update{
    [progressAlertView dismissCustomProgressDialog:^{[self checkResponseFromSignIn];}];
}

/*
 * Check response from sign In model
 */
-(void)checkResponseFromSignIn{
    if (_signInScreenModel.errorCode == SUCCESS_CODE) {
        [self storeLoginResponseToPref];
        
        [[ApplicationController getInstance] handleEvent:EVENT_ID_HOME_SCREEN];
        
    }
    else{
        if (![Utils isInternertConnectionAvailabel]) {
            [customAlertView setMessage:@"No Internet connection available"];
        }
        else{
        [customAlertView setMessage:_signInScreenModel.errorMessage];
        }
        [customAlertView show:self];
    }
}


-(void)onAlertViewLeftButtonClicked:(int)identifier{
    
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}

/*
 * Method to store login response in shared preferences.
 */
-(void)storeLoginResponseToPref{
    
    NSString *prefUserNameKey = PREF_KEY_USERNAME;
    NSString *prefPasswordKey = PREF_KEY_PASSWORD;
    NSString *prefRoledKey = PREF_KEY_ROLE;
    NSString *prefEmailKey = PREF_KEY_EMAIL;
    NSString *prefSessinIdKey = PREF_KEY_SESSION_ID;
    
    if (_signInScreenModel!=nil) {
        [preferences saveString:prefUserNameKey stringValue:_signInScreenModel.session_username];
        [preferences saveString:prefPasswordKey stringValue:_signInScreenModel.password];
        [preferences saveString:prefEmailKey stringValue:_signInScreenModel.session_email];
        [preferences saveString:prefSessinIdKey stringValue:[NSString stringWithFormat:@"%d",_signInScreenModel.session_id]];
        [preferences saveString:prefRoledKey stringValue:_signInScreenModel.role];
    }
    
    
    prefUserNameKey = nil;
    prefPasswordKey = nil;
    prefRoledKey = nil;
    prefEmailKey = nil;
    prefSessinIdKey = nil;
}


-(void)destroy{
    loginDo = nil;
    _signInScreenModel = nil;
    customAlertView = nil;
    progressAlertView = nil;
    
}


/********* SCREEN SCROLL ON KEYBOARD OPEN *********/
/*
 * Method to ajust the height of screen when keyboard is open
 */
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}


/********* TEXTFIELD CALLBACK METHODS *********/

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}



@end
