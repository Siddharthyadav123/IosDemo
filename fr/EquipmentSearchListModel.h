//
//  EquipmentSearchListModel.h
//  FleetRight
//
//  Created by Ranjit singh on 8/30/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "EquipmentDo.h"
#import "ApplicationController.h"
#import "AsyncImageDownloaderModel.h"
#import "HomeScreenDataManager.h"

@interface EquipmentSearchListModel : BaseModel
{
    LocalModel *localModel;
}

@property (nonatomic,retain) NSMutableArray *searchEquipmentListArray;
@property (nonatomic,retain) NSString *searchText;
-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded;

@end
