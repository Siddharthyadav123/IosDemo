//
//  EquipmentListServiceModel.h
//  FleetRight
//
//  Created by Ranjit singh on 8/12/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "EquipmentDo.h"
#import "ApplicationController.h"
#import "AsyncImageDownloaderModel.h"
#import "HomeScreenDataManager.h"

@class LocalModel;
@interface EquipmentListServiceModel : BaseModel
{
    LocalModel *localModel;
}

@property (nonatomic,retain) NSMutableArray *equipmentListArray;
@property(strong,nonatomic) HomeScreenDataManager *homeScreenDataManager;
@property(strong,nonatomic)NSString *folderPath;


-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded;
-(NSString*)createFolderForImages;

@end
