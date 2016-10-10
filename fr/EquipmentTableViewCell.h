//
//  EquipmentTableViewCell.h
//  FleetRight
//
//  Created by Ranjit singh on 8/12/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeScreenViewController;

@interface EquipmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *equipmentUIImageView;
@property (weak, nonatomic) IBOutlet UILabel *ename;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *modelNum;
@property (weak, nonatomic) IBOutlet UILabel *hoursPerMile;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *daily;
@property (weak, nonatomic) IBOutlet UILabel *weekly;
@property (weak, nonatomic) IBOutlet UILabel *monthly;
@property (weak, nonatomic) IBOutlet UILabel *salePrice;
@property (weak, nonatomic) IBOutlet UILabel *salePriceLabel;
@property (strong, nonatomic) IBOutlet UIButton *viewDetailButton;
@property (weak, nonatomic) IBOutlet UIButton *onContactSupplierClick;
@property (weak, nonatomic) IBOutlet UILabel *notAvailForSaleLabel;
@property (strong,nonatomic) HomeScreenViewController *homeScreenViewController;

- (IBAction)onViewDetailsClick:(id)sender;
- (IBAction)contactSupplierButtonClicked:(id)sender;

@end
