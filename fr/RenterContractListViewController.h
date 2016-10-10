//
//  RenterContractListViewController.h
//  FleetRight
//
//  Created by test on 21/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomAlertView.h"
#import "RenterContractTableViewCell.h"
#import "RenterContractModel.h"
#import "Utils.h"
#import "RenterContractListDao.h"


@interface RenterContractListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CustomAlertViewDelegate>
{
    CustomAlertView* customAlertView;
    CustomAlertView* progressAlertView;
    int clickedButtonTag;
     BOOL isScreenLaunchFirst;
}
@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) IBOutlet UIButton *rentalEquipmentButton;
@property (strong, nonatomic) IBOutlet UIButton *purchaseEquipmentButton;

- (IBAction)rentalEquipmentButtonClicked:(id)sender;
- (IBAction)purchaseEquipmentButtonClicked:(id)sender;
- (IBAction)backButtonClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *labelView;
@property (strong, nonatomic) IBOutlet UITableView *contractTableView;
@property (strong, nonatomic) RenterContractModel *renterContractModel;
@end
