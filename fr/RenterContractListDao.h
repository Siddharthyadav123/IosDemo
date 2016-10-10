//
//  RenterContractListDao.h
//  FleetRight
//
//  Created by test on 21/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RenterContractListDao : NSObject

/*
 "contract_id": 11
 "equipment_name": "Dankker Koti"
 "request_name": "Alkurn111"
 "job_location": "Nagpur"
 "from_date": "01 Aug,16"
 "to_date": "01 Aug,16"
 "equipment_status": "Sold"
 "plan": ""
 "price": "$150"
 "supplier_image": "/home1/alkurnte/public_html/clients/fleetright/uploads/avatar/profile_user-1474117232.jpg"
 "renter_image": "/home1/alkurnte/public_html/clients/fleetright/uploads/avatar/michael-wilson-1474117162.jpg"
 "equipment_image": "http://fleetright.alkurn.net/uploads/default.jpg"
 "supplier_name": "Yogesh Dangre"
 "renter_name": "Sankalp Bhoyar"
 */

@property NSInteger contract_id;
@property(strong,nonatomic)NSString* equipment_name;
@property(strong,nonatomic)NSString* request_name;
@property(strong,nonatomic)NSString* job_location;
@property(strong,nonatomic)NSString*  from_date;
@property(strong,nonatomic)NSString*  to_date;
@property(strong,nonatomic)NSString* equipment_status ;
@property(strong,nonatomic)NSString*  plan;
@property(strong,nonatomic)NSString* price ;
@property(strong,nonatomic)NSString* supplier_image ;
@property(strong,nonatomic)NSString* renter_image ;
@property(strong,nonatomic)NSString* equipment_image;
@property(strong,nonatomic)NSString* supplier_name;
@property(strong,nonatomic)NSString* renter_name;
@property(strong,nonatomic)UIImage* vehicleImage;
@property(strong,nonatomic)UIImage* renterImage;
@property(strong,nonatomic)UIImage* supplierImage;
@end
