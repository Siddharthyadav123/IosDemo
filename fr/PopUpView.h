//
//  PopUpView.h
//  FleetRight
//
//  Created by test on 24/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDefaultPreferences.h"
#import "ApplicationController.h"

@class BaseViewController;


@interface PopUpView : UIView <UITableViewDelegate,UITableViewDataSource>
{
    UserDefaultPreferences *userDefaultPreferences;
}

@property (strong, nonatomic) IBOutlet UITableView *popUpTableView;
@property (strong, nonatomic) BaseViewController *baseViewController;

@end
