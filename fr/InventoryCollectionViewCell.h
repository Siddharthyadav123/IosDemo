//
//  InventoryCollectionViewCell.h
//  FleetRight
//
//  Created by test on 05/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InventoryCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UIImageView *collectionCellImageView;
@property (strong, nonatomic) IBOutlet UILabel *collectionCellLabel;

@end
