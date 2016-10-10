//
//  IndividualRequestTableViewCell.m
//  FleetRight
//
//  Created by test on 06/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "IndividualRequestTableViewCell.h"
#import "Utils.h"

@implementation IndividualRequestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeInstance];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)initializeInstance{
    [self setBorderColourToView:self.acceptButton colour:[UIColor blueColor] ];
    [self setBorderColourToView:self.rejectButton colour:[UIColor blueColor] ];
}

/*
 * Method to set border colour to view.
 */
-(void)setBorderColourToView:(UIView*)view colour:(UIColor*)colour{
    
   // view.layer.cornerRadius = 5.0f; // set as you want.
    view.layer.borderColor = colour.CGColor; // set color as you want.
    view.layer.borderWidth = 1.0;
}


- (IBAction)acceptButtonClicked:(id)sender {
    
}

- (IBAction)rejectButtonClicked:(id)sender {
    
}
@end
