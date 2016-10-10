//
//  DashboardCollectionViewCell.h
//  FleetRight
//
//  Created by test on 05/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

@interface DashboardCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *dashboardCellImageview;
@property (strong, nonatomic) IBOutlet UILabel *dashboardCellLabel;
@property (strong, nonatomic) IBOutlet UIView *parentView;

@end
