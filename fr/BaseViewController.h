//
//  BaseViewController.h
//  IosApplicationFrameworkProject
//
//  Created by test on 11/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"
#import "ApplicationController.h"
#import "LocalModel.h"
#import "ActionBarView.h"
#import "FilterMenuView.h"
#import "PopUpView.h"
#import "EquipmentListServiceModel.h"
#import "FilterEquipmentCategoryModel.h"
#import "AppDelegate.h"
#import "EquipmentSearchListModel.h"


@class LoginScreenViewController;
@class RootUIViewController;
@class EquipmentDetailViewController;

@interface BaseViewController : UIViewController<AbstractViewController>
{
    int viewControllerType;
    UIView* popUpCustomView;
    PopUpView *popUpTableView;
    BOOL iSPopUpViewOpen;
   
}

@property int viewControllerType;
@property (strong,nonatomic)LocalModel *localModel;

@property (strong,nonatomic)FilterMenuView *filterView ;
@property (strong,nonatomic)UIView *shadowView ;
@property (strong,nonatomic)ActionBarView* actionBarView ;
@property (strong,nonatomic)  NSArray *popUpArray;;
@property int clickedButtonIndex;


@property (nonatomic,retain) FilterEquipmentCategoryModel *filterEquipmentCategoryModel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



-(void)initializeInstance;
-(UIView*)loadActionBarView;

-(void)initFilterView;
-(void)showOrHideFilterView;
-(void)animateOpen:(BOOL)isFullOpen;
-(void)animateClose:(BOOL)isFullClose;

-(void)showMoreMenuPopUp;
-(void)closeMoreMenuPopUp;

-(void)requestFilterEquimentCateogries;
-(void) showInnerLoading;
-(void) hideInnerLoading;
-(void)dismissCurrentScreen;


@end
