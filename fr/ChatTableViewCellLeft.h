//
//  ChatTableViewCellLeft.h
//  FleetRight
//
//  Created by Ranjit singh on 9/21/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCellLeft : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *chatImageView;
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UITextView *chatTextLabel;

@end
