//
//  RentalRequestModel.h
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "ApplicationController.h"
#import "SignInScreenModel.h"
#import "UserDefaultPreferences.h"

@class RentalRequestDao;
@class LocalModel;

@interface RentalRequestModel : BaseModel
{
    UserDefaultPreferences *userDefaultPreferences;
    int session_id;
}
@property(strong,nonatomic) RentalRequestDao *rentalRequestDao;
@property int equipment_id;
@end
