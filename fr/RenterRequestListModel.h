//
//  RenterRequestListModel.h
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "RenterRequestListDao.h"
#import "UserDefaultPreferences.h"

@interface RenterRequestListModel : BaseModel
{
    UserDefaultPreferences *userDefaultPreferences;
    NSString* loginType;
}
@property (nonatomic,retain) NSMutableArray *renterListArray;
@end
