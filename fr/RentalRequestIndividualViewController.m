//
//  RentalRequestIndividualViewController.m
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "RentalRequestIndividualViewController.h"

@interface RentalRequestIndividualViewController ()

@end

@implementation RentalRequestIndividualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Method to load custom action bar on each viewcontroller
 */
-(UIView*)loadActionBarView{
    // ActionBarView *actionBarView = [[ActionBarView alloc]init];
    self.actionBarView = [[[NSBundle mainBundle] loadNibNamed:@"ActionBarView"
                                                        owner:self options:nil]objectAtIndex:0];
    [self.actionBarView setBaseViewController:self];
    return self.actionBarView;
}


//loading filter after view shown
-(void) viewDidAppear:(BOOL)animated
{
    if (!isScreenLaunchFirst) {
        [self initFilterView];
        [self initializeModel];
        isScreenLaunchFirst = true;
    }
}

/*
 * Method to initialize views
 */
-(void)initializeInstance{
    [super initializeInstance];
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    progressAlertView = [CustomAlertView createCustomProgressDialog:CUSTOM_ALERT_PROGRESS_TITLE delegate:self identifier:2];
    
    
}

/*
 * Method to initialize RenterRequestIndividualModel
 */
-(void)initializeModel{
    [progressAlertView show:self];
    self.renterRequestIndividualModel = [[RenterRequestIndividualModel alloc]init];
    [self.renterRequestIndividualModel registerview:self];
    self.renterRequestIndividualModel.renterRequestListDao = self.renterRequestListDao;
    [self.renterRequestIndividualModel initialize];
}

-(void)update{
    
    [progressAlertView dismissCustomProgressDialog:^{[self onResponse];}];
    
}

-(void)onResponse{
    if (_renterRequestIndividualModel.errorCode == SUCCESS_CODE) {
        [self setDataInLabels];
    }
    else{
        if (![Utils isInternertConnectionAvailabel]) {
            [customAlertView setMessage:@"No Internet connection available"];
        }
        else{
            [customAlertView setMessage:@"Error in Response"];
           
        }
         [customAlertView show:self];
    }
}

/*
 * Void method to set data in labels of cell
 */
-(void)setDataInLabels{
    @autoreleasepool {
        
        if (_renterRequestIndividualModel!=nil) {
            
            RenterRequestIndividualDao *renterRequestIndividualDao = _renterRequestIndividualModel.renterRequestIndividualDao;
            
            if (renterRequestIndividualDao.equipment_name!=nil) {
                self.enameLabel.text = renterRequestIndividualDao.equipment_name;
            }
            else{
                self.enameLabel.text = @"N/A";
            }
            
            if (renterRequestIndividualDao.province!=nil) {
                self.provinceLabel.text = renterRequestIndividualDao.province;
            }
            else{
                self.provinceLabel.text = @"N/A";
            }
            if (renterRequestIndividualDao.job_location!=nil) {
                self.jobLocationLabel.text = renterRequestIndividualDao.job_location;
            }
            else{
                self.jobLocationLabel.text = @"N/A";
            }
            if (renterRequestIndividualDao.from_date!=nil) {
                self.fromDateLabel.text = renterRequestIndividualDao.from_date;
            }
            else{
                self.fromDateLabel.text = @"N/A";
            }
            if (renterRequestIndividualDao.to_date!=nil) {
                self.toDateLabel.text = renterRequestIndividualDao.to_date;
            }
            else{
                self.toDateLabel.text = @"N/A";
            }
            if (renterRequestIndividualDao.request_for!=nil) {
                self.requestFor.text = renterRequestIndividualDao.request_for;
            }
            else{
                self.requestFor.text = @"N/A";
            }
            if (renterRequestIndividualDao.request_name!=nil) {
                self.requestName.text = renterRequestIndividualDao.request_name;
            }
            else{
                self.requestName.text = @"N/A";
            }
            if (renterRequestIndividualDao.status!=nil) {
                self.statusLabel.text = renterRequestIndividualDao.status;
            }
            else{
                self.statusLabel.text = @"N/A";
            }
            
        }
        
    }
}

-(void)onAlertViewLeftButtonClicked:(int)identifier{
    
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}

@end
