//
//  RentalRequestTableViewCell.h
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RentalRequestListViewController;

@interface RentalRequestTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (strong, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobLicationLabel;
@property (strong, nonatomic) IBOutlet UILabel *requestLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *chargeLabel;
@property (strong, nonatomic) IBOutlet UIButton *pendingButton;
- (IBAction)pendingButtonClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *firstCharacterLabel;
@property (strong, nonatomic)RentalRequestListViewController *rentalRequestListViewController;
@end
