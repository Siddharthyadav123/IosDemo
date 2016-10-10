//
//  RenterContractTableViewCell.h
//  FleetRight
//
//  Created by test on 21/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RenterContractTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *parentCellView;
@property (strong, nonatomic) IBOutlet UILabel *renterNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *equipmentNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end
