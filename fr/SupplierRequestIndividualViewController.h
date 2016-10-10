//
//  SupplierRequestIndividualViewController.h
//  FleetRight
//
//  Created by test on 20/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "RenterRequestListDao.h"
#import "CustomAlertView.h"
#import "SupplierRequestIndividualModel.h"
#import "Utils.h"
#import "SupplierRequestIndividualCell.h"
#import "RenterRequestIndividualDao.h"

@interface SupplierRequestIndividualViewController : BaseViewController<CustomAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isScreenLaunchFirst;
    CustomAlertView* customAlertView;
    CustomAlertView* progressAlertView;
}
@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) RenterRequestListDao *renterRequestListDao;
@property (strong, nonatomic) SupplierRequestIndividualModel *supplierRequestIndividualModel;
@property (strong, nonatomic) IBOutlet UITableView *supplierTableView;
@end
