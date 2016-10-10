//
//  EquipmentDo.h
//  FleetRight
//
//  Created by Ranjit singh on 8/12/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//{
//"id": 48,
//  "ename": "Ducati",
//  "mnf_id": 1,
//  "mnfname": "Tata",
//  "mdname": "E100",
//  "cname": "Crusher",
//   "year": 2016,
//  "hour_per_miles": 30,
//   "daily": "$125",
//   "weekly": "$1250",
//  "monthly": "$12500",
//  "sale_price": "0",
//   "status": "Available",
//   "url": "http://alkurn.net/clients/fleetright/frontend/web/uploads/default.jpg"
//}
@interface EquipmentDo : NSObject

@property  NSInteger id;
@property (nonatomic,retain) NSString *ename;
@property NSInteger mnf_id;
@property (nonatomic,retain) NSString *mnfname;
@property (nonatomic,retain) NSString *mdname;
@property (nonatomic,retain) NSString *cname;
@property NSInteger year;
@property  NSInteger hour_per_miles;
@property (nonatomic,retain) NSString *daily;
@property (nonatomic,retain) NSString *weekly;
@property (nonatomic,retain) NSString *monthly;
@property (nonatomic,retain) NSString *sale_price;
@property (nonatomic,retain) NSString *status;
@property (nonatomic,retain) NSString *url;
@property (nonatomic,retain) NSData* imageData;
@property (nonatomic,retain) UIImage* vehicleImage;
@property (nonatomic,strong) NSString *desc;
@end

