//
//  SupplierRequestIndividualModel.h
//  FleetRight
//
//  Created by test on 20/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "RenterRequestListDao.h"
#import "RenterRequestIndividualDao.h"

@interface SupplierRequestIndividualModel : BaseModel
@property (strong,nonatomic)RenterRequestListDao *renterRequestListDao;
@property (strong,nonatomic) NSMutableArray *supplierRequestIndivListArray;
@end
