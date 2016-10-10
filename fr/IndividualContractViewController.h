//
//  IndividualContractViewController.h
//  FleetRight
//
//  Created by test on 06/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "Utils.h"

@interface IndividualContractViewController : BaseViewController<UITextViewDelegate,UITextFieldDelegate>
{
    UITextField* activeField;
    UITextView* activeTextView;
}
@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *parentView;

//Vehicle Description labels
@property (strong, nonatomic) IBOutlet UILabel *vehicleImage;
@property (strong, nonatomic) IBOutlet UILabel *salePrizeContantLabel;
@property (strong, nonatomic) IBOutlet UILabel *salePriceValue;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *modelNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *cnnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *compactorLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *hourLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayRentLabel;
@property (strong, nonatomic) IBOutlet UILabel *weekRentLabel;
@property (strong, nonatomic) IBOutlet UILabel *monthRentLabel;

//Owner Description Label
@property (strong, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (strong, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *requestStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *rentingPeriodLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextview;
@property (strong, nonatomic) IBOutlet UITextField *fuelTranspoartChargesLabel;
@property (strong, nonatomic) IBOutlet UITextField *maintananceChargesLabel;
@property (strong, nonatomic) IBOutlet UITextField *lateFeesLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountPayableValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *extraChargesLabel;

@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *endContractButton;


- (IBAction)backButtonClicked:(id)sender;
- (IBAction)saveButtonClicked:(id)sender;
- (IBAction)endContractButtonClicked:(id)sender;




@end
