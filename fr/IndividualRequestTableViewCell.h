//
//  IndividualRequestTableViewCell.h
//  FleetRight
//
//  Created by test on 06/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndividualRequestTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *supplierImageView;
@property (strong, nonatomic) IBOutlet UILabel *supplierNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *rentalStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *acceptButton;
@property (strong, nonatomic) IBOutlet UIButton *rejectButton;
- (IBAction)acceptButtonClicked:(id)sender;
- (IBAction)rejectButtonClicked:(id)sender;

@end
