//
//  RentalRequestIndividualViewController.h
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "RenterRequestListDao.h"
#import "RenterRequestIndividualModel.h"
#import "CustomAlertView.h"
#import "Utils.h"

@interface RentalRequestIndividualViewController : BaseViewController<CustomAlertViewDelegate>

{
    CustomAlertView *customAlertView;
    CustomAlertView *progressAlertView;
     BOOL isScreenLaunchFirst;

}
@property (strong, nonatomic) RenterRequestListDao *renterRequestListDao;
@property (strong, nonatomic) RenterRequestIndividualModel *renterRequestIndividualModel;


@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *enameLabel;
@property (strong, nonatomic) IBOutlet UILabel *requestFor;
@property (strong, nonatomic) IBOutlet UILabel *requestName;
@property (strong, nonatomic) IBOutlet UILabel *provinceLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *toDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIView *parentView;

@end
