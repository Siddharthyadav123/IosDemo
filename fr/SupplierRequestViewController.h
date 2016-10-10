//
//  IndividualRequestViewController.h
//  FleetRight
//
//  Created by test on 06/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "IndividualRequestTableViewCell.h"

@interface SupplierRequestViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (strong, nonatomic) IBOutlet UILabel *vehicleNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *notAvailableLabel;
@property (strong, nonatomic) IBOutlet UILabel *salePriceConstantLabel;
@property (strong, nonatomic) IBOutlet UILabel *salePriceValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *modelNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *cnnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *compactorLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UILabel *weekLabel;
@property (strong, nonatomic) IBOutlet UILabel *monthLabel;
@property (strong, nonatomic) IBOutlet UITableView *requestTableView;
- (IBAction)backButtonClicked:(id)sender;



@end
