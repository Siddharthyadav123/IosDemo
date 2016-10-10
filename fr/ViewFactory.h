//
//  ViewFactory.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef __VIEW_FACTORY_H__
#define __VIEW_FACTORY_H__


#import <Foundation/Foundation.h>
#import "AppConstants.h"
#import "CustomNavigationViewController.h"
#import "LoginScreenViewController.h"
#import "SignupScreenViewController.h"
#import "EquipmentMapViewController.h"
#import "EquipmentRentRequByRenterViewController.h"
#import "RentalRequestListViewController.h"
#import "RentalRequestIndividualViewController.h"
#import "DashboardViewController.h"
#import "InventoryViewController.h"
#import "SupplierRequestViewController.h"
#import "IndividualContractViewController.h"
#import "ChatViewController.h"
#import "SupplierRequestIndividualViewController.h"
#import "RenterContractListViewController.h"
#import "RenterSupplierIndividualContractViewController.h"


@interface ViewFactory : NSObject

@property CustomNavigationViewController *jobListCustomNavigationViewController;

-(void)releaseAllScreen;
-(id<AbstractViewController>) getAbstractUIViewController:(int)screenId eventObject:(NSObject *)eventObject;


@end



#endif