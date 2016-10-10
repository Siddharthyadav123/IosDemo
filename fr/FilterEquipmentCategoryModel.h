//
//  FilterEquipmentCategoryModel.h
//  FleetRight
//
//  Created by Ranjit singh on 8/22/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "AppConstants.h"
#import "LocalModel.h"
#import "ApplicationController.h"
#import "FilterEquipmentCategoryDo.h"
#import "FilterEquipmentSubCateogoryDo.h"
#import "ModelFacde.h"

@interface FilterEquipmentCategoryModel : BaseModel
{
     LocalModel *localModel;
}

@property(nonatomic,strong) NSMutableArray *filterEquipmentCateoryList;

@end
