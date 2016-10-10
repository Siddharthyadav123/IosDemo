//
//  IndividualContractViewController.m
//  FleetRight
//
//  Created by test on 06/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "IndividualContractViewController.h"

@interface IndividualContractViewController ()

@end

@implementation IndividualContractViewController

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

-(void)viewDidAppear:(BOOL)animated{
    [self initFilterView];
}

/*
 * Method to initialize views
 */
-(void)initializeInstance{
    [super initializeInstance];
    activeField.delegate = self;
    activeTextView.delegate = self;
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    [_scrollView setContentSize:CGSizeMake(_parentView.frame.size.width, _parentView.frame.size.height)];
    
    
}

-(void)initializeViews{
    
    [activeField resignFirstResponder];
    [activeTextView resignFirstResponder];
    
    [Utils setBorderColourToView:self.saveButton colour:[UIColor blueColor] ];
    [Utils setBorderColourToView:self.endContractButton colour:[UIColor blueColor] ];
    
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
    [activeTextView resignFirstResponder];
}



- (IBAction)backButtonClicked:(id)sender {
    [[ApplicationController getInstance]handleEvent:EVENT_ID_FINISH_SCREEN];
}

- (IBAction)saveButtonClicked:(id)sender {
}

- (IBAction)endContractButtonClicked:(id)sender {
}


//****************** SCREEN SCROLL ON KEYBOARD OPEN ******************//
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


//****************** TEXTFIELD CALLBACK METHODS ******************//

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



//****************** TEXTVIEW CALLBACK METHODS ******************//

- (void)textViewDidBeginEditing:(UITextView *)textView{
    activeTextView = textView;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    activeTextView = nil;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}


@end
