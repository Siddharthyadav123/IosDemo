//
//  ChatViewController.h
//  FleetRight
//
//  Created by test on 12/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "ChatTableViewCell.h"
#import "ChatTableViewCellLeft.h"


@interface ChatViewController : BaseViewController<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextView* activeTextView;
    NSMutableArray *tempArray;
}
@property (strong, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) IBOutlet UITextView *typeMessageTextView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UITableView *chatTableView;


- (IBAction)onSendBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end
