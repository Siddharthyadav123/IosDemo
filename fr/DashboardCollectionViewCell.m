//
//  DashboardCollectionViewCell.m
//  FleetRight
//
//  Created by test on 05/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "DashboardCollectionViewCell.h"

@implementation DashboardCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

-(void)initialize{
      [Utils setBorderColourToView:self.parentView colour:[UIColor colorWithRed:0 green:204 blue:204 alpha:1] ];
}

@end
