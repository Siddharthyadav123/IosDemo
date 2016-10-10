//
//  SupplierRequestIndividualViewController.m
//  FleetRight
//
//  Created by test on 20/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "SupplierRequestIndividualViewController.h"

@interface SupplierRequestIndividualViewController ()

@end

@implementation SupplierRequestIndividualViewController

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
    self.supplierRequestIndividualModel = [[SupplierRequestIndividualModel alloc]init];
    [self.supplierRequestIndividualModel registerview:self];
    self.supplierRequestIndividualModel.renterRequestListDao = self.renterRequestListDao;
    [self.supplierRequestIndividualModel initialize];
}

-(void)update{
    
    [progressAlertView dismissCustomProgressDialog:^{[self onResponse];}];
    
}

-(void)onResponse{
    if (_supplierRequestIndividualModel.errorCode == SUCCESS_CODE) {
        [self.supplierTableView reloadData];
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_supplierRequestIndividualModel.supplierRequestIndivListArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SupplierRequestIndividualCell";
    
    SupplierRequestIndividualCell *cell = (SupplierRequestIndividualCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SupplierRequestIndividualCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [self setDataInCell:cell andIndex:indexPath];
    
    return cell;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"selected row index %i", indexPath.row);
    
    
}



/*
 * Void method to set data in labels of cell
 */
-(void)setDataInCell:(SupplierRequestIndividualCell*)cell andIndex:(NSIndexPath *)indexPath{
    @autoreleasepool {
        
        if ([_supplierRequestIndividualModel.supplierRequestIndivListArray count]!=0) {
            RenterRequestIndividualDao *renterRequestIndividualDao = [_supplierRequestIndividualModel.supplierRequestIndivListArray objectAtIndex:indexPath.row];
            
            cell.dataDisplayTextView.text = [NSString stringWithFormat:@"Request ID: %d,\nRequest Name: %@,\nEquipment ID: %d,\nEquipment Name: %@,\nProvince  : %@,\nJob Location: %@,\nFrom Date: %@,\nTo Date: %@,\nStatus: %@,\nRequest For: %@,\nPlan: %@,\nSale Or Rent Amt: %@ ",renterRequestIndividualDao.request_id,renterRequestIndividualDao.request_name,renterRequestIndividualDao.equipment_id,renterRequestIndividualDao.equipment_name,renterRequestIndividualDao.province,renterRequestIndividualDao.job_location,renterRequestIndividualDao.from_date,renterRequestIndividualDao.to_date,renterRequestIndividualDao.status,renterRequestIndividualDao.request_for,renterRequestIndividualDao.plan,renterRequestIndividualDao.sale_or_rent_amt];
            
        }
        
        
    }
}

-(void)onAlertViewLeftButtonClicked:(int)identifier{
    
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}


@end
