//
//  ViewFactory.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "ViewFactory.h"
#import "ApplicationController.h"
#import "AbstractUIView.h"
#import "AbstractViewController.h"
#import "SplashScreenViewController.h"
#import "AppConstants.h"
#import "HomeScreenViewController.h"
#import "EquipmentDetailViewController.h"
#import "SearchViewController.h"

@implementation ViewFactory



/* Release the screen*/


/**
 * Release All Screen before exiting the application
 */
-(void)releaseAllScreen
{
    
}

-(id<AbstractViewController>) getAbstractUIViewController:(int)screenId eventObject:(NSObject *)eventObject
{
    switch (screenId) {
            
        case VF_SPLASH_SCREEN:
        {
            SplashScreenViewController *splashScreen =[SplashScreenViewController alloc];
            
            splashScreen.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return splashScreen;
        }
            
        case VF_LOGIN_SCREEN:
        {
            LoginScreenViewController *loginScreenViewController =[[LoginScreenViewController alloc]init];
            
            loginScreenViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return loginScreenViewController;
        }
            
        case VF_HOME_SCREEN:
        {
            HomeScreenViewController *homeScreenViewController =[[HomeScreenViewController alloc]init];
            homeScreenViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            LocalModel *localModel = [[[ApplicationController getInstance]getModelFacade]getLocalModel];
            localModel.homeScreenViewController = homeScreenViewController;
            return homeScreenViewController;
        }
            
        case VF_EQUIPMENT_DETAILS_SCREEN:
        {
            EquipmentDetailViewController *equipmentDetailsViewController =[[EquipmentDetailViewController alloc]init];
            
            equipmentDetailsViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            equipmentDetailsViewController.equipmentDo = (EquipmentDo*)eventObject;
            
            return equipmentDetailsViewController;
        }
            
        case VF_SIGNUP_SCREEN:
        {
            SignupScreenViewController *signupScreenViewController =[[SignupScreenViewController alloc]init];
            
            signupScreenViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return signupScreenViewController;
        }
        case VF_SEARCH_BAR_SCREEN:
        {
            SearchViewController *searchBarViewController =[[SearchViewController alloc]init];
            
            searchBarViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return searchBarViewController;
        }
            
        case VF_EQUIPMENT_MAP_VIEW_SCREEN:
        {
            EquipmentMapViewController *equipmentMapViewController =[[EquipmentMapViewController alloc]init];
            
            equipmentMapViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            equipmentMapViewController.equipmentDo = (EquipmentDo*)eventObject;
            
            return equipmentMapViewController;
        }
            
        case VF_EQUIPMENT_RENT_REQUEST_RENTER_VIEW_SCREEN:
        {
            EquipmentRentRequByRenterViewController *  equipmentRentRequByRenterViewController =[[EquipmentRentRequByRenterViewController alloc]init];
            
            equipmentRentRequByRenterViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            equipmentRentRequByRenterViewController.equipmentDo = (EquipmentDo*)eventObject;
            
            return equipmentRentRequByRenterViewController;
        }
            
        case VF_RENTAL_REQUEST_LIST_VIEW_SCREEN:
        {
            RentalRequestListViewController *  rentalRequestListViewController =[[RentalRequestListViewController alloc]init];
            
            rentalRequestListViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return rentalRequestListViewController;
        }
        case VF_RENTAL_REQUEST_INDIVIDUAL_VIEW_SCREEN:
        {
            RentalRequestIndividualViewController *  rentalRequestIndividualViewController =[[RentalRequestIndividualViewController alloc]init];
            
            rentalRequestIndividualViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            rentalRequestIndividualViewController.renterRequestListDao = (RenterRequestListDao*)eventObject;
            
            return rentalRequestIndividualViewController;
        }
            
            
        case VF_SUPPLIER_REQUEST_INDIVIDUAL_VIEW_SCREEN:
        {
            SupplierRequestIndividualViewController *  supplierRequestIndividualViewController =[[SupplierRequestIndividualViewController alloc]init];
            
            supplierRequestIndividualViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            supplierRequestIndividualViewController.renterRequestListDao = (RenterRequestListDao*)eventObject;
            
            return supplierRequestIndividualViewController;
        }
            
            
        case VF_DASHBOARD_VIEW_SCREEN:
        {
            DashboardViewController *  dashboardViewController =[[DashboardViewController alloc]init];
            
            dashboardViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return dashboardViewController;
        }
            
        case VF_INVENTORY_VIEW_SCREEN:
        {
            InventoryViewController *  inventoryViewController =[[InventoryViewController alloc]init];
            
            inventoryViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return inventoryViewController;
        }
            
            
        case VF_INDIVIDUAL_REQUEST_VIEW_SCREEN:
        {
            SupplierRequestViewController *  supplierRequestViewController =[[SupplierRequestViewController alloc]init];
            
            supplierRequestViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return supplierRequestViewController;
        }
            
        case VF_INDIVIDUAL_CONTRACT_VIEW_SCREEN:
        {
            IndividualContractViewController *  individualContractViewController =[[IndividualContractViewController alloc]init];
            
            individualContractViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return individualContractViewController;
        }
            
        case VF_CHAT_VIEW_SCREEN:
        {
            ChatViewController *  chatViewController =[[ChatViewController alloc]init];
            
            chatViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return chatViewController;
        }
            
        case VF_RENTAL_CONTRACT_LIST_VIEW_SCREEN:
        {
            RenterContractListViewController *  renterContractListViewController =[[RenterContractListViewController alloc]init];
            
            renterContractListViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
            return renterContractListViewController;
        }
            
            
        case VF_RENTAL_SUPPLIER_INDIVIDUAL_CONTRACT_VIEW_SCREEN:
        {
            RenterSupplierIndividualContractViewController *  renterSupplierIndividualContractViewController =[[RenterSupplierIndividualContractViewController alloc]init];
            
            renterSupplierIndividualContractViewController.viewControllerType = VCT_VIEW_CONTROLLER;
            
           // renterSupplierIndividualContractViewController.renterContractListDao = (RenterContractListDao*)eventObject;
            
            renterSupplierIndividualContractViewController.renterContractListDataDictionary = (NSMutableDictionary*)eventObject;

            
            return renterSupplierIndividualContractViewController;
        }
            
        case VF_JOB_LIST_CUSTOM_NAVIGATION_CONTROLLER_SCREEN:
        {
            _jobListCustomNavigationViewController =[[CustomNavigationViewController alloc]init];
            return _jobListCustomNavigationViewController;
        }
            
            
    }
    return nil;
}


@end
