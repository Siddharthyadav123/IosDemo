//
//  RenterContractModel.h
//  FleetRight
//
//  Created by test on 21/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "RenterContractListDao.h"
#import "UserDefaultPreferences.h"

@interface RenterContractModel : BaseModel
{
    UserDefaultPreferences *userDefaultPreferences;
    NSString *loginType;
}
@property(strong,nonatomic)NSMutableArray *renterContractRentEquipmentArray;

//VARIABLE TO IDENTIFY REQUEST IF FOR RENT OR PURCHASE
@property NSString* CONTRACT_REQUEST_TYPE_IDENTIFIER;
@end
