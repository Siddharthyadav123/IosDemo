//
//  InventoryViewController.h
//  FleetRight
//
//  Created by test on 05/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "InventoryCollectionViewCell.h"
#import "InventoryModel.h"
#import "CustomAlertView.h"
#import "UserDefaultPreferences.h"
#import "AppConstants.h"

@interface InventoryViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,CustomAlertViewDelegate>
{
     CustomAlertView *customAlertView;
    BOOL isScreenLaunchFirst;
    UserDefaultPreferences *userDefaultPreferences;
    NSString* loginType;
}
@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) IBOutlet UICollectionView *equipmentOnRentCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *soldEquipmentCollectionView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic)InventoryModel* inventoryModel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *equipmentRentIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *soldEquipmentIndicator;
@property (strong, nonatomic) IBOutlet UIView *idleEquipmentView;
@property (strong, nonatomic) IBOutlet UICollectionView *idleEquipmentCollectionView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *idleEquipmentIndicator;

- (IBAction)backButtonClicked:(id)sender;
@end
