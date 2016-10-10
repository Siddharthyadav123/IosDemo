//
//  RenterSupplierIndividualContractViewController.m
//  FleetRight
//
//  Created by test on 22/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "RenterSupplierIndividualContractViewController.h"

@interface RenterSupplierIndividualContractViewController ()

@end

@implementation RenterSupplierIndividualContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeInstance];
    [self initializeViews];
    
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
    [self initFilterView];
    [self initializeModel];
    
}

/*
 * Method to initialize Instances
 */
-(void)initializeInstance{
    [super initializeInstance];
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    [_scrollView setContentSize:CGSizeMake(_parentScrollView.frame.size.width, _parentScrollView.frame.size.height)];
    
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    progressAlertView = [CustomAlertView createCustomProgressDialog:CUSTOM_ALERT_PROGRESS_TITLE delegate:self identifier:2];
    
    _renterContractIndividualModel = [[RenterContractIndividualModel alloc]init];
    self.localModel.renterContractIndividualModel = _renterContractIndividualModel;
    _renterContractIndividualModel.renterContractListDataDict = self.renterContractListDataDictionary;
    _renterContractIndividualModel.renterSupplierIndividualContractViewController = self;
    [_renterContractIndividualModel registerview:self];
    
}

/*
 * Method to initialize views
 */
-(void)initializeViews{
    
    
}

/*
 * Method to initialize RenterContractModel
 */
-(void)initializeModel{
    
    [self.vehicleImageView startAnimating];
    [self.renterIndicator startAnimating];
    [self.supplierImageView startAnimating];
    
    [progressAlertView show:self];
    [_renterContractIndividualModel initialize];
}


-(void)update{
    [progressAlertView dismissCustomProgressDialog:^{[self onResponse];}];
    
}

-(void)onResponse{
    
    if (_renterContractIndividualModel.errorCode == SUCCESS_CODE) {
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


- (IBAction)backButtonClicked:(id)sender {
    
    [[ApplicationController getInstance]handleEvent:EVENT_ID_FINISH_SCREEN];
}

/*
 * Method to set response data in labels
 */
-(void)setDataInLabels{
    
    RenterContractListDao *renterContractIndividualDao = _renterContractIndividualModel.renterContractIndividualDao;
    
    if (renterContractIndividualDao!=nil) {
        if (renterContractIndividualDao.equipment_name!=nil) {
            self.vehicleNameLabel.text = renterContractIndividualDao.equipment_name;
        }
        else{
            self.vehicleNameLabel.text = @"N/A";
        }
        
        if (renterContractIndividualDao.job_location!=nil) {
            self.locationNameLabel.text = renterContractIndividualDao.job_location;
        }
        else{
            self.locationNameLabel.text = @"N/A";
        }
        
        if (renterContractIndividualDao.price!=nil) {
            self.perDayChargesLabel.text = renterContractIndividualDao.price;
        }
        else{
            self.perDayChargesLabel.text = @"N/A";
        }
        
        if (renterContractIndividualDao.request_name!=nil) {
            self.lendToDataLabel.text = renterContractIndividualDao.request_name;
        }
        else{
            self.lendToDataLabel.text = @"N/A";
        }
        
        if (renterContractIndividualDao.renter_name!=nil) {
            self.renterDataNameLabel.text = renterContractIndividualDao.renter_name;
        }
        else{
            self.renterDataNameLabel.text = @"N/A";
        }
        
        if (renterContractIndividualDao.supplier_name!=nil) {
            self.supplierDataNameLabel.text = renterContractIndividualDao.supplier_name;
        }
        else{
            self.supplierDataNameLabel.text = @"N/A";
        }
        
        if (renterContractIndividualDao.from_date!=nil) {
            self.fromDateLabel.text = renterContractIndividualDao.from_date;
        }
        
        if (renterContractIndividualDao.to_date!=nil) {
            self.toDateLabel.text = renterContractIndividualDao.to_date;
        }
              
    }
}

/*
 * Method gets called  when image downloade response comes
 */
-(void)onImageDownloadResponse:(NSString*)identifier{
    RenterContractListDao *renterContractIndividualDao = _renterContractIndividualModel.renterContractIndividualDao;
    
    if ([identifier isEqual:IMAGE_DOWNLOAD_REQUEST_FOR_RENTER]) {
        //Downloaded Renter Image
        [self.renterIndicator stopAnimating];
        if (renterContractIndividualDao.renterImage!=nil) {
            [self.renterImageView setImage:renterContractIndividualDao.renterImage];
        }
    }
    
    else if ([identifier isEqual:IMAGE_DOWNLOAD_REQUEST_FOR_SUPPLIER]) {
        //Downloaded Supplier Image
        [self.supplierImageView stopAnimating];
        if (renterContractIndividualDao.supplierImage!=nil) {
            [self.supplierImageView setImage:renterContractIndividualDao.supplierImage];
        }
    }
    
    else if ([identifier isEqual:IMAGE_REQUEST_FROM_INDIVIDUAL_CONTRACT]) {
        //Downloaded Vehicle Image
        [self.vehicleImageView stopAnimating];
        if (renterContractIndividualDao.vehicleImage!=nil) {
            [self.vehicleImageView setImage:renterContractIndividualDao.vehicleImage];
        }
        
    }
    
}

@end
