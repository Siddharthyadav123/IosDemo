//
//  SignupScreenViewController.m
//  FleetRight
//
//  Created by test on 12/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "SignupScreenViewController.h"
#import "Utils.h"

@interface SignupScreenViewController ()

@end

@implementation SignupScreenViewController

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
    
    self.usernameTextfield.tag = 1;
    self.emailTextfield.tag = 2;
    self.passwordTextfield.tag = 3;
    self.conformPassword.tag = 4;
    self.contactNumberTextfield.tag = 5;
    
    activeField.delegate = self;
    
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    progressAlertView = [CustomAlertView createCustomProgressDialog:CUSTOM_ALERT_PROGRESS_TITLE delegate:self identifier:2];
    
    signUpDo = [[SignUpDo alloc]init];
    self.signUpScreenModel = [[SignUpScreenModel alloc]init];
    self.localModel.signUpScreenModel = self.signUpScreenModel;
    [self.signUpScreenModel registerview:self];
}

/*
 * Method to initialize views
 */
-(void)initializeViews{
    self.scrollView.contentSize = CGSizeMake(self.parentView.frame.size.width, self.parentView.frame.size.height);
    [Utils roundButtonCorner: self.registerButton];
    [Utils setBorderToView:self.usernameView];
    [Utils setBorderToView:self.passwordView];
    
    [Utils changePlaceHolderColour:self.usernameTextfield];
    [Utils changePlaceHolderColour:self.emailTextfield];
    [Utils changePlaceHolderColour:self.passwordTextfield];
    [Utils changePlaceHolderColour:self.conformPassword];
    [Utils changePlaceHolderColour:self.contactNumberTextfield];
    
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

- (IBAction)registerButtonClicked:(id)sender {
    
    if ([self isStoredDataInDao]) {
        [progressAlertView show:self];
        self.signUpScreenModel.signUpDo = signUpDo;
        [self.signUpScreenModel initialize];
        
    }else{
        [customAlertView show:self];
    }
    
    
}

- (IBAction)alreadyLoginButtonClicked:(id)sender {
    [[ApplicationController getInstance]handleEvent:EVENT_ID_FINISH_SCREEN];
    
}

/*
 * Method to store text field data into SignUpDo
 */
-(BOOL)isStoredDataInDao{
    
    if ([self.usernameTextfield.text isEqual:@""] && [self.emailTextfield.text isEqual:@""] && [self.passwordTextfield.text isEqual:@""] && [self.conformPassword.text isEqual:@""]) {
        [customAlertView setMessage:MANDATORY_FIELD_ERROR_MESSAGE];
        return false;
    }
    
    
    //Validate username Text field should not be empty
    if (![self.usernameTextfield.text isEqual:@""]) {
        if ([self isUsernameValid]) {
            signUpDo.userNameString = self.usernameTextfield.text;
        }
        else{
            [customAlertView show:self];
            return false;
        }
        
    }else{
        [customAlertView setMessage:@"Username is required"];
        return false;
    }
    
    
    //Validate email Text field should not be empty
    if (![self.emailTextfield.text isEqual:@""]) {
        
        //Validate email pattern
        if ([self isValidEmail]) {
            signUpDo.emailString = self.emailTextfield.text;
        }
        else{
            [customAlertView show:self];
            return false;
        }
        
    }
    else{
        [customAlertView setMessage:@"Email Address is required"];
        return false;
    }
    
    
    
    
    //Validate password Text field should not be empty
    if (![self.passwordTextfield.text isEqual:@""]) {
        if ([self isPasswordValid]) {
            signUpDo.passwordString = self.passwordTextfield.text;
        }
        else{
            [customAlertView show:self];
            return false;
        }
        
    }
    else{
        [customAlertView setMessage:@"Password is required"];
        return false;
    }
    
    
    
    
    //Validate conformPassword Text field should not be empty
    if (![self.conformPassword.text isEqual:@""]) {
        
        //Check password and conform password is same
        if ([self isMatchingPassword]) {
            signUpDo.conformPasswordString = self.conformPassword.text;
        }
        else{
            [customAlertView show:self];
            return false;
        }
        
    }
    else{
        [customAlertView setMessage:@"Confirm Password is required"];
        return false;
    }
    
    
    
    //Validate contactNumber Text field should not be empty
    if (![self.contactNumberTextfield.text isEqual:@""]) {
        
        //Validate 10 digit Contact Number
        if ([self isValidContactNumber]) {
            signUpDo.contactNumberString = self.contactNumberTextfield.text;
        }
        else{
            [customAlertView show:self];
            return false;
        }
        
    }
    
    
    return true;
}

/*
 * Method to check entered password and conform password is same or not
 */
-(BOOL)isUsernameValid{
    if (self.usernameTextfield.text.length<6) {
        [customAlertView setMessage:USERNAME_LENGTH_ERROR_MESSAGE];
        return false;
    }
    return true;
}

/*
 * Method to check entered email pattern is correct or not
 */
-(BOOL)isValidEmail{
    BOOL isValidEmail = [Utils isValidateEmail:self.emailTextfield.text];
    if (!isValidEmail) {
        [customAlertView setMessage:INCORRECT_EMAIL_ERROR_MESSAGE];
        return false;
    }
    return true;
}

/*
 * Method to check entered contact number is 10 digit or not
 */
-(BOOL)isValidContactNumber{
    BOOL isValidContactNumber = [Utils isValidateMobileNumber:self.contactNumberTextfield.text];
    if (!isValidContactNumber) {
        [customAlertView setMessage:INCORRECT_PHONE_NUMBER_ERROR_MESSAGE];
        return false;
    }
    return true;
}

/*
 * Method to check entered password and conform password is same or not
 */
-(BOOL)isPasswordValid{
    if (self.passwordTextfield.text.length<6) {
        [customAlertView setMessage:PASSWORD_LENGTH_ERROR_MESSAGE];
        return false;
    }
    return true;
}


/*
 * Method to check entered password and conform password is same or not
 */
-(BOOL)isMatchingPassword{
    if (![self.passwordTextfield.text isEqual:self.conformPassword.text]) {
        [customAlertView setMessage:CONFIRM_PASSWORD_ERROR_MESSAGE];
        return false;
    }
    return true;
}


/*
 * Update: Method gets called when response come form server (From model's informView method)
 */
-(void)update{
    [progressAlertView dismissCustomProgressDialog:^{[self checkResponseFromSignUp];}];
}

/*
 * Check response from sign up model
 */
-(void)checkResponseFromSignUp{
    if (![Utils isInternertConnectionAvailabel]) {
        [customAlertView setMessage:@"No Internet connection available"];
    }
    else{
    [customAlertView setMessage:_signUpScreenModel.errorMessage];
    }
    [customAlertView show:self];
    
    
}


-(void)onAlertViewLeftButtonClicked:(int)identifier{
    if (_signUpScreenModel.errorCode == SUCCESS_CODE) {
        
        [[ApplicationController getInstance]handleEvent:EVENT_ID_FINISH_SCREEN];
        
    }
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}


/*
 * Method to destroy variables
 */
-(void)destroy{
    self.signUpScreenModel = nil;
    activeField= nil;
    _alphaView= nil;
    _scrollView= nil;
    _parentView= nil;
    _usernameView= nil;
    _emailView= nil;
    _passwordView= nil;
    _conformPasswordView= nil;
    _contactNumberView= nil;
    _usernameTextfield= nil;
    _emailTextfield= nil;
    _passwordTextfield= nil;
    _conformPassword= nil;
    _contactNumberTextfield= nil;
    _registerButton =nil;
    customAlertView = nil;
    progressAlertView = nil;
    signUpDo = nil;
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
    
    [activeField resignFirstResponder];
    
    return YES;
    
}

/*
 * Restrict input of mobile no textfield upto 10 digits.
 */

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //If textfield is contact number, then restrict it to accept only 10 digits
    if (textField == self.contactNumberTextfield) {
        if (textField.text.length >= 10 && range.length == 0){
            return NO;
        }
        
    }
    
    return YES;
    
}


@end
