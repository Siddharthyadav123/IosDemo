//
//  SupplierRequestApprovalModel.h
//  FleetRight
//
//  Created by test on 22/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "RenterRequestListDao.h"

@class RentalRequestListViewController;

@interface SupplierRequestApprovalModel : BaseModel

@property(strong,nonatomic) RenterRequestListDao *renterRequestListDao;
@property(strong,nonatomic) RentalRequestListViewController *rentalRequestListViewController;
@property int buttonIndex;
@end
