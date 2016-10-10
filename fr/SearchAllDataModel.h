//
//  SearchAllDataModel.h
//  FleetRight
//
//  Created by test on 25/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "Utils.h"
#import "AppConstants.h"
#import "SearchDao.h"

@interface SearchAllDataModel : BaseModel
@property(strong,nonatomic) NSMutableArray *allSearchDataArray;

@end
