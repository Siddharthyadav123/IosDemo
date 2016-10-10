//
//  RenterListDao.h
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RenterRequestListDao : NSObject

/*
 "rid": 14
"rname": "New Request"
"eid": 58
"province": "India"
"job_location": "Nagpur"
"from_date": "01 Jul,16"
"to_date": "01 Jul,16"
"status": "Declined"
"request_for": "Rent Request"
*/

@property  NSInteger request_id;
@property  NSInteger equipment_id;
@property (strong,nonatomic) NSString* equipment_name;
@property (strong,nonatomic) NSString* status;
@property (strong,nonatomic) NSString* province;
@property (strong,nonatomic) NSString* job_location;
@property (strong,nonatomic) NSString* from_date;
@property (strong,nonatomic) NSString* to_date;
@property (strong,nonatomic) NSString* request_for;
@property (strong,nonatomic) NSString* request_name;
@property (strong,nonatomic) NSString* plan;
@property (strong,nonatomic) NSString* sale_or_rent_amt;
@end
