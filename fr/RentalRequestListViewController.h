//
//  RentalRequestListViewController.h
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "RentalRequestTableViewCell.h"
#import "RenterRequestListModel.h"
#import "CustomAlertView.h"
#import "Utils.h"
#import "UserDefaultPreferences.h"
#import "AppConstants.h"
#import "SupplierRequestApprovalModel.h"

@interface RentalRequestListViewController : BaseViewController<UITabBarDelegate,UITableViewDataSource,CustomAlertViewDelegate>
{
    CustomAlertView *customAlertView;
        CustomAlertView* progressAlertView;
    UserDefaultPreferences *userDefaultPreferences;
    NSString* loginType;
}

@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) IBOutlet UITableView *renterTableView;
@property (strong, nonatomic) RenterRequestListModel *renterRequestListModel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) SupplierRequestApprovalModel *supplierRequestApprovalModel;
-(void)onPendingButtonClicked:(int)clickedButtonIndex;
-(void)onStatusApprovalResponse:(int)buttonIndex;
@end
