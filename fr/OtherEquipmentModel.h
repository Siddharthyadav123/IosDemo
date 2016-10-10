//
//  OtherEquipmentModel.h
//  FleetRight
//
//  Created by test on 29/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "EquipmentDo.h"
#import "AsyncImageDownloaderModel.h"

@class EquipmentDetailViewController;

@interface OtherEquipmentModel : BaseModel

//@property(strong,nonatomic)EquipmentDo *otherRelatedEquipmentDao;

@property(strong,nonatomic) NSMutableArray *otherRelatedEquipmrntArray;
@property int equipment_id;
@property int mnf_id;
-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded;

@end
