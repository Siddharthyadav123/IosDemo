//
//  DemoTableControllerViewController.h
//  FPPopoverDemo
//
//  Created by Alvise Susmel on 4/13/12.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionBarView.h"

@interface DemoTableController : UITableViewController

@property(nonatomic,assign) ActionBarView *delegate;

@end
