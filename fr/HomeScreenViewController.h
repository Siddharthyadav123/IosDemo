//
//  HomeScreenViewController.h
//  FleetRight
//
//  Created by Ranjit singh on 8/12/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EquipmentListServiceModel.h"
#import "FilterEquipmentCategoryModel.h"
#import "HomeScreenDataManager.h"
#import "Utils.h"
#import "CustomAlertView.h"

@interface HomeScreenViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource,CustomAlertViewDelegate>
{
//    UIImage *vehicleImage;
    NSMutableArray *dataFromDBArray;
     CustomAlertView *customAlertView;
    NSMutableArray *vehicleImageLocalDataArray;
}

@property (weak, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (nonatomic,retain) EquipmentListServiceModel *equipmentListServiceModel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void)onImageDownloadResponse:(UIImage *)image andVehicleImageURL:(NSString*)imageURL;
-(void)onViewDetailButtonClicked:(int)buttonIndex;
-(void)onViewDetailButtonClicked:(int)buttonIndex;
@end
