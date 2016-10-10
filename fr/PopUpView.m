//
//  PopUpView.m
//  FleetRight
//
//  Created by test on 24/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "PopUpView.h"
#import "BaseViewController.h"

@implementation PopUpView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"In numberOfRowsInSection");
    return [_baseViewController.popUpArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"In cellForRowAtIndexPath");
    
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Set up the cell...
    // cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.textLabel.text = [_baseViewController.popUpArray objectAtIndex:[indexPath row]];
    
    return cell;
}


#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [[ApplicationController getInstance]handleEvent:EVENT_ID_DASHBOARD_VIEW_SCREEN];
    }
    
    else if (indexPath.row == 2) {
        //Delete all data from preferences
        userDefaultPreferences = [UserDefaultPreferences getInstance];
        NSString *prefUserNameKey = PREF_KEY_USERNAME;
        NSString *prefPasswordKey = PREF_KEY_PASSWORD;
        [userDefaultPreferences saveString:prefUserNameKey stringValue:@""];
        [userDefaultPreferences saveString:prefPasswordKey stringValue:@""];
        prefUserNameKey = nil;
        prefPasswordKey = nil;
        
        [[ApplicationController getInstance] handleEvent:EVENT_ID_LOGIN_SCREEN];
    }
    
    [self.baseViewController animateClose:YES];
    [self.baseViewController closeMoreMenuPopUp];
}
@end
