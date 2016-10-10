//
//  FilterEquipmentCategoryDo.h
//  FleetRight
//
//  Created by Ranjit singh on 8/22/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterEquipmentCategoryDo : NSObject
@property  NSInteger id;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSMutableArray *subcategory;

@end
