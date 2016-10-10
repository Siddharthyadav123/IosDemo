//
//  EquipmentTableViewCell.m
//  FleetRight
//
//  Created by Ranjit singh on 8/12/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "EquipmentTableViewCell.h"
#import "HomeScreenViewController.h"

@implementation EquipmentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onViewDetailsClick:(id)sender {
    [self.homeScreenViewController onViewDetailButtonClicked:self.viewDetailButton.tag];
}

- (IBAction)contactSupplierButtonClicked:(id)sender {
     [[ApplicationController getInstance]handleEvent:EVENT_ID_CHAT_VIEW_SCREEN];
}
@end
