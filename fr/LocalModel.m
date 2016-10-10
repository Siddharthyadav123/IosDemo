//
//  LocalModel.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "LocalModel.h"
#import "SignUpScreenModel.h"
#import "SignInScreenModel.h"
#import "HomeScreenDataManager.h"
#import "HomeScreenViewController.h"
#import "EquipmentIndividualModel.h"
#import "InventoryModel.h"
#import "RenterContractModel.h"
#import "RenterContractIndividualModel.h"


@implementation LocalModel


- (id)init
{
    self = [super init];
    if (self) {
        //<#statements#>
    }
    return self;
}

-(void)initialize
{
  
}

/*
 * Destroy instance of all models
 */

-(void) destory{

}


-(void) informView
{
    
}

-(void)registerview:(NSObject<AbstractView> *)view
{
    // TODO Auto-generated method stub
}

-(void)unregisterview:(NSObject<AbstractView> *)view

{
    // TODO Auto-generated method stub
}
@end
