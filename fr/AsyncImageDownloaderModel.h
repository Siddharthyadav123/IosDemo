//
//  AsyncImageDownloaderModel.h
//  FleetRight
//
//  Created by test on 22/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class EquipmentListServiceModel;
@class EquipmentIndividualModel;
@class OtherEquipmentModel;
@class InventoryModel;
@class RenterContractIndividualModel;


@interface AsyncImageDownloaderModel : NSObject

@property int imageIndex;
@property (strong,nonatomic)NSURL *imageURL;
@property (strong,nonatomic)EquipmentListServiceModel *equipmentListServiceModel;
@property (strong,nonatomic)NSString *imageRequestIdentifier;
@property (strong,nonatomic)EquipmentIndividualModel *equipmentIndividualModel;
@property (strong,nonatomic)OtherEquipmentModel *otherEquipmentModel;
@property (strong,nonatomic)InventoryModel *inventoryModel;
@property (strong,nonatomic)RenterContractIndividualModel *renterContractIndividualModel;


-(void)initialize;
@end
