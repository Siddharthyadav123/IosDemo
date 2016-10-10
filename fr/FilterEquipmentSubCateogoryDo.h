//
//  FilterEquipmentSubCateogoryDo.h
//  FleetRight
//
//  Created by Ranjit singh on 8/22/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterEquipmentSubCateogoryDo : NSObject
@property  NSInteger id;
@property  NSInteger parent_id;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *desc;
@end
