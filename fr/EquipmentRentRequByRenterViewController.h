//
//  EquipmentRentRequByRenterViewController.h
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "EquipmentDo.h"
#import "CustomAlertView.h"
#import "RentalRequestDao.h"
#import "Utils.h"
#import "RentalRequestModel.h"
#import "DatePickerView.h"


@interface EquipmentRentRequByRenterViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,CustomAlertViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource>

{
    UITextField* activeField;
    UITextView* activeTextView;
    CustomAlertView *customAlertView;
    CustomAlertView *progressAlertView;
    NSArray* rentDaysArray;
    int clickedButtonIndex;
    BOOL isScreenLaunchFirst;
}

@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;

//Rental Request variable
@property (strong, nonatomic) IBOutlet UIView *requestRentView;
@property (strong, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (strong, nonatomic) IBOutlet UILabel *vehicleNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *salePriceTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *salePriceAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *modelNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *weekAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *monthAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *notAvailableFOrSaleLabel;
@property (strong, nonatomic) IBOutlet UILabel *cnnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *compactorLabel;
- (IBAction)backButtonClicked:(id)sender;


//Details variable
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UIView *childView;
@property (strong, nonatomic) IBOutlet UILabel *separaterLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *jobLocationTextField;
@property (strong, nonatomic) IBOutlet UITextField *provinceTextField;
@property (strong, nonatomic) IBOutlet UILabel *rentDaysLabel;
@property (strong, nonatomic) IBOutlet UIButton *rentDaysButton;
- (IBAction)rentDaysButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *fromDataButton;
- (IBAction)fromDataButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *toDateButton;
- (IBAction)toDateButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *commentTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendOfferButton;
- (IBAction)sendOfferButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
- (IBAction)cancelButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *toDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *rentDaysPickerView;
//@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIView *nameView;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UIView *contactNumberView;
@property (strong, nonatomic) IBOutlet UIView *jobLocationView;
@property (strong, nonatomic) IBOutlet UIView *provinceView;
@property (strong, nonatomic) IBOutlet UIView *toDateView;
@property (strong, nonatomic) IBOutlet UIView *fromDateView;






//General variables
@property(strong,nonatomic)EquipmentDo *equipmentDo;
@property(strong,nonatomic) RentalRequestDao *rentalRequestDao;
@property(strong,nonatomic) RentalRequestModel *rentalRequestModel;
@property(strong,nonatomic) DatePickerView *datePickerView;


- (void)datePickerChanged:(NSString*)fromDate toDate:(NSString*)toDate;

@end
