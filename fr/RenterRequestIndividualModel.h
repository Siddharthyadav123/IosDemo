//
//  RenterRequestIndividualModel.h
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "RenterRequestIndividualDao.h"
#import "RenterRequestListDao.h"


@interface RenterRequestIndividualModel : BaseModel

@property (strong,nonatomic)RenterRequestIndividualDao *renterRequestIndividualDao;
@property (strong,nonatomic)RenterRequestListDao *renterRequestListDao;
@end
