//
//  InventoryModel.h
//  FleetRight
//
//  Created by test on 07/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "InventoryDao.h"
#import "AsyncImageDownloaderModel.h"
#import "UserDefaultPreferences.h"


@interface InventoryModel : BaseModel
{
     UserDefaultPreferences *userDefaultPreferences;
    NSString* loginType;
}
@property(strong,nonatomic)NSMutableArray *rentEquipmentArray;
@property(strong,nonatomic)NSMutableArray *soldEquipmentArray;
@property(strong,nonatomic)NSMutableArray *idleEquipmentArray;
//@property (strong,nonatomic)NSString *identifier;

-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded identifier:(NSString*)identifier;
@end
