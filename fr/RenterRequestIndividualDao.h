//
//  RenterRequestIndividualDao.h
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RenterRequestIndividualDao : NSObject

/*"id": 16
 "equipment_id": 48
 "ename": "Ducati"
 "rname": "Mye New Request"
 "email": "yogesh@gmail.com"
 "province": "india"
 "job_location": "Nagpur"
 "from_date": "2016-07-01 08:23:31"
 "to_date": "2016-07-30 08:23:31"
 "comment": "kokokokoko"
 "created_on": "2016-07-16 08:23:31"
 "plan": "Monthly"
 "status": ""
 */

@property  NSInteger id;
@property  NSInteger equipment_id;
@property (strong,nonatomic) NSString* equipment_name;
@property (strong,nonatomic) NSString* request_for;
@property NSInteger request_id;
@property (strong,nonatomic) NSString* province;
@property (strong,nonatomic) NSString* job_location;
@property (strong,nonatomic) NSString* from_date;
@property (strong,nonatomic) NSString* to_date;
@property (strong,nonatomic) NSString* request_name;
@property (strong,nonatomic) NSString* status;
@property (strong,nonatomic) NSString* plan;
@property (strong,nonatomic) NSString* sale_or_rent_amt;

@end
