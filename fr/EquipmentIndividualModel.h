//
//  EquipmentIndividualModel.h
//  FleetRight
//
//  Created by test on 26/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "EquipmentDo.h"
#import "AsyncImageDownloaderModel.h"


@interface EquipmentIndividualModel : BaseModel

@property(strong,nonatomic)EquipmentDo *equipmentDo;
@property int selectedVehicleID;
-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded;
@end
