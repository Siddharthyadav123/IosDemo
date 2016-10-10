//
//  DashboardViewController.h
//  FleetRight
//
//  Created by test on 05/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DashboardCollectionViewCell.h"
#import "UserDefaultPreferences.h"

@interface DashboardViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *dashboardImagesArray;
    NSMutableArray *dashboardLabelArray;
    UserDefaultPreferences *userDefaultPreferences;
    NSString *role;
    
}
@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
