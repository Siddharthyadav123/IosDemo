//
//  RenterContractIndividualModel.h
//  FleetRight
//
//  Created by test on 21/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "RenterContractListDao.h"
#import "UserDefaultPreferences.h"
#import "AsyncImageDownloaderModel.h"

@class RenterSupplierIndividualContractViewController;

@interface RenterContractIndividualModel : BaseModel
{
    UserDefaultPreferences *userDefaultPreferences;
    NSString *loginType;
    RenterContractListDao *renterContractListDao;
    NSString* CONTRACT_INDIVIDUAL_REQUEST_TYPE_IDENTIFIER;
}
@property(strong,nonatomic)NSMutableDictionary *renterContractListDataDict;
@property(strong,nonatomic)RenterContractListDao *renterContractIndividualDao;
@property(strong,nonatomic)RenterSupplierIndividualContractViewController *renterSupplierIndividualContractViewController;
-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded identifier:(NSString*)imageDownloadIdentifier;

@end
