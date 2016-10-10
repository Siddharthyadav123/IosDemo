//
//  ActionBarView.m
//  FleetRight
//
//  Created by test on 16/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "ActionBarView.h"
#import "BaseViewController.h"


#import "DemoTableController.h"

@implementation ActionBarView

- (id)init
{
    self = [super init];
    if (self) {
        [self initializeInstances];
    }
    return self;
}


-(void)initializeInstances{
    NSLog(@"In ACtion Bar View");
}

- (IBAction)notificationButtonClicked:(id)sender {
    
}

- (IBAction)messageButtonClicked:(id)sender {
      [[ApplicationController getInstance]handleEvent:EVENT_ID_CHAT_VIEW_SCREEN];
}

- (IBAction)moreButtonClicked:(id)sender {
    self.baseViewController.clickedButtonIndex = (int)self.moreButton.tag;
    [self.baseViewController showMoreMenuPopUp];
    
}

- (IBAction)showFilterButtonClicked:(id)sender {
    self.baseViewController.clickedButtonIndex = (int)self.showFilterButton.tag;
    [self.baseViewController showOrHideFilterView];
    
}

- (IBAction)homeScreenLogoButtonClicked:(id)sender {
    [self.baseViewController animateClose:YES];
    [self.baseViewController closeMoreMenuPopUp];
    [self.baseViewController dismissCurrentScreen];
    
}

- (IBAction)searchButtonClicked:(id)sender {
    [self.baseViewController animateClose:YES];
    [self.baseViewController closeMoreMenuPopUp];
    [[ApplicationController getInstance]handleEvent:EVENT_ID_SEARCH_BAR_SCREEN];
    
}




@end
