//
//  RentalRequestTableViewCell.m
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "RentalRequestTableViewCell.h"
#import "RentalRequestListViewController.h"

@implementation RentalRequestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self createRoundImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)pendingButtonClicked:(id)sender {
   // [_rentalRequestListViewController onPendingButtonClicked:(int)self.pendingButton.tag];
}

/*
 * Method to create round imageview
 */
-(void)createRoundImageView{
    self.ownerImageView.layer.cornerRadius =  self.ownerImageView.frame.size.width/2;
}
@end
