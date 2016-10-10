//
//  InventoryDao.h
//  FleetRight
//
//  Created by test on 07/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InventoryDao : NSObject

/*
 "contract_id": 5
"equipment_id": 50
"equipment_name": "Titanium"
"equipment_image": "http://fleetright.alkurn.net/uploads/default.jpg"
 */

@property int contract_id;
@property int equipment_id;
@property(strong,nonatomic)NSString* equipment_name;
@property(strong,nonatomic)NSString* equipment_image_URL;
@property(strong,nonatomic)UIImage* vehicleImage;

@end
