//
//  FilterMenuView.h
//  FleetRight
//
//  Created by Ranjit singh on 8/22/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseViewController;
@interface FilterMenuView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BaseViewController *baseViewController;
@property(nonatomic,strong) NSMutableArray *filterEquipmentCateoryList;

-(NSInteger)getTableHeight;
@end
