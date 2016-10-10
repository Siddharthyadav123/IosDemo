//
//  EquipmentRentRequByRenterViewController.m
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "EquipmentRentRequByRenterViewController.h"

@interface EquipmentRentRequByRenterViewController ()

@end

@implementation EquipmentRentRequByRenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeInstance];
    [self initializeViews];
    [self applyTapGestureOnView];
    [self registerForKeyboardNotifications];
    [self addDatePickerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    if (!isScreenLaunchFirst) {
        [self initFilterView];
        [self setDataInLabels];
        isScreenLaunchFirst = true;
        
    }
    
}


/*
 * Method to add custom datepicker view
 */
-(void)addDatePickerView{
    // ActionBarView *actionBarView = [[ActionBarView alloc]init];
    self.datePickerView = [[[NSBundle mainBundle] loadNibNamed:@"DatePickerView"
                                                         owner:self options:nil]objectAtIndex:0];
    self.datePickerView.equipmentRentRequByRenterViewController = self;
    [self.view addSubview:self.datePickerView];
    [self.datePickerView setHidden:YES];
    [self.view sendSubviewToBack:_datePickerView];
    
}

/*
 * Method to initialize views
 */
-(void)initializeInstance{
    [super initializeInstance];
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
        
    
    rentDaysArray = [[NSArray alloc]initWithObjects:@"Daily",@"Weekly", @"Monthly", nil];
    self.rentalRequestDao = [[RentalRequestDao alloc]init];
    [_scrollView setContentSize:CGSizeMake(_parentView.frame.size.width, _parentView.frame.size.height)];
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    activeField.delegate = self;
    activeTextView.delegate = self;
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    progressAlertView = [CustomAlertView createCustomProgressDialog:CUSTOM_ALERT_PROGRESS_TITLE delegate:self identifier:2];
    self.rentalRequestModel = [[RentalRequestModel alloc]init];
    [self.rentalRequestModel registerview:self];
}


-(void)initializeViews{
    
    [activeField resignFirstResponder];
    [activeTextView resignFirstResponder];
    
    [Utils setBorderColourToView:self.sendOfferButton colour:[UIColor blackColor] ];
    [Utils setBorderColourToView:self.cancelButton colour:[UIColor blackColor] ];
    
    [self setBorderColourToView:self.nameView colour:[UIColor lightGrayColor] ];
    [self setBorderColourToView:self.emailView colour:[UIColor lightGrayColor] ];
    [self setBorderColourToView:self.contactNumberView colour:[UIColor lightGrayColor] ];
    [self setBorderColourToView:self.jobLocationView colour:[UIColor lightGrayColor] ];
    [self setBorderColourToView:self.provinceView colour:[UIColor lightGrayColor] ];
    [self setBorderColourToView:self.rentDaysButton colour:[UIColor lightGrayColor] ];
    [self setBorderColourToView:self.toDateView colour:[UIColor lightGrayColor] ];
    [self setBorderColourToView:self.fromDateView colour:[UIColor lightGrayColor] ];
    [self setBorderColourToView:self.commentTextField colour:[UIColor lightGrayColor] ];
    
    //Ad placehodel in comment textview
    _commentTextField.text = @"Comment";
    _commentTextField.textColor = [UIColor lightGrayColor];
    _commentTextField.delegate = self;
    _commentTextField.scrollEnabled = NO;
    
    
}

/*
 * Method to set border colour to view.
 */
-(void)setBorderColourToView:(UIView*)view colour:(UIColor*)colour{
    
    view.layer.cornerRadius = 1.0f; // set as you want.
    view.layer.borderColor = colour.CGColor; // set color as you want.
    view.layer.borderWidth = 1.0;
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

/*
 * Method to set data in views
 */
-(void)setDataInLabels{
    
    if (_equipmentDo!=nil) {
        if (_equipmentDo.ename!=nil) {
            self.vehicleNameLabel.text = _equipmentDo.ename;
        }
        
//        if([_equipmentDo.sale_price isEqual:@"0"])
//        {   self.salePriceAmountLabel.hidden=YES;
//            self.salePriceTextLabel.hidden=YES;
//            self.notAvailableFOrSaleLabel.hidden=NO;
//        }else{
//            self.salePriceAmountLabel.text=_equipmentDo.sale_price;
//            self.salePriceAmountLabel.hidden=NO;
//            self.salePriceTextLabel.hidden=NO;
//            self.notAvailableFOrSaleLabel.hidden=YES;
//        }
        if (_equipmentDo.mnfname!=nil) {
            self.companyNameLabel.text = _equipmentDo.mnfname;
        }
        if (_equipmentDo.mdname!=nil) {
            self.modelNumberLabel.text = _equipmentDo.mdname;
        }
        if (_equipmentDo.cname!=nil) {
            self.cnnameLabel.text = _equipmentDo.cname;
        }
        if (_equipmentDo.year!=0) {
            self.yearLabel.text = [NSString stringWithFormat:@"Year-%ld",(long)_equipmentDo.year];
        }
        if (_equipmentDo.hour_per_miles!=0) {
            self.hoursLabel.text = [NSString stringWithFormat:@"Hour-%ld",(long)_equipmentDo.hour_per_miles];
        }
        if (_equipmentDo.daily!=nil) {
            self.dayAmountLabel.text = _equipmentDo.daily;
        }
        if (_equipmentDo.weekly!=nil) {
            self.weekAmountLabel.text = _equipmentDo.weekly;
        }
        if (_equipmentDo.monthly!=nil) {
            self.monthAmountLabel.text = _equipmentDo.monthly;
        }
        
        // set default user image while image is being downloaded
        //self.vehicleImageView.image = [UIImage imageNamed:@"icon_logo.png"];
        
        if (_equipmentDo.vehicleImage!=nil ) {
            [self.vehicleImageView setImage:_equipmentDo.vehicleImage];
        }
    }
    
}

/*
 * Method to store text field data into SignUpDo
 */
-(BOOL)isStoredDataInDao{
    
    //Validate username Text field should not be empty
    if (![self.nameTextField.text isEqual:@""]) {
        _rentalRequestDao.name = self.nameTextField.text;
        
    } else{
        [customAlertView setMessage:MANDATORY_FIELD_ERROR_MESSAGE];
        return false;
    }
    
    
    //Validate email Text field should not be empty
    if (![self.emailTextField.text isEqual:@""]) {
        
        //Validate email pattern
        if ([self isValidEmail]) {
            _rentalRequestDao.emailAddress = self.emailTextField.text;
            
        }
        else{
            [customAlertView show:self];
            return false;
        }
        
    }
    
    //Validate contactNumber Text field should not be empty
    if (![self.contactNumberTextField.text isEqual:@""]) {
        
        //Validate 10 digit Contact Number
        if ([self isValidContactNumber]) {
            _rentalRequestDao.contactNumber = self.contactNumberTextField.text;
        }
        else{
            [customAlertView show:self];
            return false;
        }
        
    }
    
    if (![self.jobLocationTextField.text isEqual:@""]) {
        _rentalRequestDao.jobLocation = self.jobLocationTextField.text;
        [customAlertView setMessage:@""];
    } else{
        [customAlertView setMessage:MANDATORY_FIELD_ERROR_MESSAGE];
        return false;
    }
    
    
    if (![self.provinceTextField.text isEqual:@""]) {
        _rentalRequestDao.province = self.provinceTextField.text;
        
        
    } else{
        [customAlertView setMessage:MANDATORY_FIELD_ERROR_MESSAGE];
        return false;
    }
    
    
    if (![self.rentDaysLabel.text isEqual:@""]) {
        _rentalRequestDao.rentDay  = self.rentDaysLabel.text;
        
        
    } else{
        [customAlertView setMessage:MANDATORY_FIELD_ERROR_MESSAGE];
        return false;
    }
    
    
    if (![self.commentTextField.text isEqual:@""]) {
        _rentalRequestDao.comment  = self.commentTextField.text;
        
    } else{
        [customAlertView setMessage:MANDATORY_FIELD_ERROR_MESSAGE];
        return false;
    }
    
    
    if (![self.fromDateLabel.text isEqual:@""]) {
        _rentalRequestDao.fromDate = self.fromDateLabel.text;
        
    } else{
        [customAlertView setMessage:MANDATORY_FIELD_ERROR_MESSAGE];
        return false;
    }
    
    
    if (![self.toDateLabel.text isEqual:@""]) {
        _rentalRequestDao.toDate = self.toDateLabel.text;
        
    }else{
        [customAlertView setMessage:MANDATORY_FIELD_ERROR_MESSAGE];
        return false;
    }
    return true;
}

/*
 * Method to check entered email pattern is correct or not
 */
-(BOOL)isValidEmail{
    BOOL isValidEmail = [Utils isValidateEmail:self.emailTextField.text];
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
    BOOL isValidContactNumber = [Utils isValidateMobileNumber:self.contactNumberTextField.text];
    if (!isValidContactNumber) {
        [customAlertView setMessage:INCORRECT_PHONE_NUMBER_ERROR_MESSAGE];
        return false;
    }
    return true;
}

//******************DATE PICKER CODE ******************//

- (void)datePickerChanged:(NSString*)fromDate toDate:(NSString*)toDate{
    self.fromDateLabel.text = fromDate;
    self.toDateLabel.text = toDate;
    
    [self.datePickerView setHidden:YES];
    [self.view sendSubviewToBack:self.datePickerView];
    [self.view bringSubviewToFront:self.datePickerView];
}


- (IBAction)fromDataButtonClicked:(id)sender {
    clickedButtonIndex = (int)self.fromDataButton.tag;
    [self.datePickerView initialize];
    [self.datePickerView setHidden:NO];
    [self.view bringSubviewToFront:self.datePickerView];
    
    
}

- (IBAction)toDateButtonClicked:(id)sender {
    
    //    clickedButtonIndex = (int)self.toDateButton.tag;
    //    [self.datePickerView initialize];
    //    [self.datePickerView setHidden:NO];
    //    [self.view bringSubviewToFront:self.datePickerView];
    
    
}




- (IBAction)rentDaysButtonClicked:(id)sender {
    [self.rentDaysPickerView setHidden:NO];
    
}

- (IBAction)sendOfferButtonClicked:(id)sender {
    if([self isStoredDataInDao]){
        [progressAlertView show:self];
        self.rentalRequestModel.rentalRequestDao = self.rentalRequestDao;
        self.rentalRequestModel.equipment_id = (int)self.equipmentDo.id;
        [self.rentalRequestModel initialize];
    }
    else{
        [customAlertView show:self];
    }
    
}

- (IBAction)cancelButtonClicked:(id)sender {
    [[ApplicationController getInstance] handleEvent:EVENT_ID_FINISH_SCREEN];
    
}


-(void)update{
    [progressAlertView dismissCustomProgressDialog:^{[self checkResponseFromRentelRequest];}];
}

/*
 * Check response from sign In model
 */
-(void)checkResponseFromRentelRequest{
    if (_rentalRequestModel.errorCode == SUCCESS_CODE) {
        
        // [[ApplicationController getInstance] handleEvent:EVENT_ID_FINISH_SCREEN];
        [customAlertView setMessage:_rentalRequestModel.errorMessage];
        [self clearAllData];
        
    }
    else{
        if (![Utils isInternertConnectionAvailabel]) {
            [customAlertView setMessage:@"No Internet connection available"];
        }
        else{
        [customAlertView setMessage:_rentalRequestModel.errorMessage];
        }
    }
    [customAlertView show:self];
}

-(void)clearAllData{
    
    self.nameTextField.text= @"";
    self.emailTextField.text= @"";
    self.contactNumberTextField.text= @"";
    self.jobLocationTextField.text= @"";
    self.provinceTextField.text= @"";
    self.rentDaysLabel.text= @"";
    self.commentTextField.text= @"";
    self.fromDateLabel.text= @"";
    self.toDateLabel.text= @"";
    
}

-(void)onAlertViewLeftButtonClicked:(int)identifier{
    
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}

- (IBAction)backButtonClicked:(id)sender {
    [[ApplicationController getInstance]handleEvent:EVENT_ID_FINISH_SCREEN];
}

//****************** DATA PICKER (RENT DAY PICKER) CODE ******************//
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [rentDaysArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return rentDaysArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _rentDaysLabel.text = rentDaysArray[row];
    [self.rentDaysPickerView setHidden:YES];
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

/*
 * Restrict input of mobile no textfield upto 10 digits.
 */

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //If textfield is contact number, then restrict it to accept only 10 digits
    if (textField == self.contactNumberTextField) {
        if (textField.text.length >= 10 && range.length == 0){
            return NO;
        }
        
    }
    
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
    if (textView ==  _commentTextField) {
        _commentTextField.text = @"";
        _commentTextField.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if (textView ==  _commentTextField) {
        if(_commentTextField.text.length == 0){
            _commentTextField.textColor = [UIColor lightGrayColor];
            _commentTextField.text = @"Comment";
            [_commentTextField resignFirstResponder];
        }
    }
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
