//
//  RenterSupplierIndividualContractViewController.h
//  FleetRight
//
//  Created by test on 22/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomAlertView.h"
#import "RenterContractIndividualModel.h"
#import "Utils.h"
#import "RenterContractListDao.h"

@interface RenterSupplierIndividualContractViewController : BaseViewController<CustomAlertViewDelegate>
{
    CustomAlertView* customAlertView;
    CustomAlertView* progressAlertView;

}
@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) RenterContractIndividualModel *renterContractIndividualModel;
@property (strong, nonatomic) NSMutableDictionary *renterContractListDataDictionary;
- (IBAction)backButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (strong, nonatomic) IBOutlet UILabel *vehicleNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *perDayChargesLabel;
@property (strong, nonatomic) IBOutlet UILabel *lendToDataLabel;
@property (strong, nonatomic) IBOutlet UILabel *renterDataNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *supplierDataNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *renterImageView;
@property (strong, nonatomic) IBOutlet UIImageView *supplierImageView;
@property (strong, nonatomic) IBOutlet UIView *parentScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *vehicleImageIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *renterIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *supplierIndicator;
-(void)onImageDownloadResponse:(NSString*)identifier;
@property (strong, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *toDateLabel;

@end
