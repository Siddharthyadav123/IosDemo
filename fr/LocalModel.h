//
//  LocalModel.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef __LOCAL_MODEL_H__
#define __LOCAL_MODEL_H__

#import <Foundation/Foundation.h>
#import "IModel.h"

@class SignUpScreenModel;
@class SignInScreenModel;
@class EquipmentListServiceModel;
@class HomeScreenDataManager;
@class HomeScreenViewController;
@class EquipmentIndividualModel;
@class InventoryModel;
@class RenterContractModel;
@class RenterContractIndividualModel;

@interface LocalModel : NSObject<IModel>

@property NSInteger intValue;
@property (strong,nonatomic) SignUpScreenModel *signUpScreenModel;
@property (strong,nonatomic) SignInScreenModel *signInScreenModel;
@property (strong,nonatomic)EquipmentListServiceModel *equipmentListServiceModel;
@property (strong,nonatomic)HomeScreenDataManager *homeScreenDataTable;
@property (strong,nonatomic)HomeScreenViewController *homeScreenViewController;
@property (strong,nonatomic)EquipmentIndividualModel *equipmentIndividualModel;
@property (strong,nonatomic)InventoryModel* inventoryModel;
@property (strong,nonatomic)RenterContractModel* renterContractModel;
@property (strong,nonatomic)RenterContractIndividualModel *renterContractIndividualModel;

@property(nonatomic,strong) NSMutableArray *filterEquipmentCateoryList;
@property(nonatomic,strong) NSMutableArray *searchDataArray;

@end

#endif

