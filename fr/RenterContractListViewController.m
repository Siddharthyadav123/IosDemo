//
//  RenterContractListViewController.m
//  FleetRight
//
//  Created by test on 21/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "RenterContractListViewController.h"
#import "RenterSupplierIndividualContractViewController.h"


@interface RenterContractListViewController ()

@end

@implementation RenterContractListViewController

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
    if (!isScreenLaunchFirst) {
        [self initFilterView];
        [self initializeModel];
        isScreenLaunchFirst = true;
    }
    
}


/*
 * Method to initialize Instances
 */
-(void)initializeInstance{
    [super initializeInstance];
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    progressAlertView = [CustomAlertView createCustomProgressDialog:CUSTOM_ALERT_PROGRESS_TITLE delegate:self identifier:2];
    
    _renterContractModel = [[RenterContractModel alloc]init];
    self.localModel.renterContractModel = _renterContractModel;
    _renterContractModel.CONTRACT_REQUEST_TYPE_IDENTIFIER = RENTER_CONTRACT_RENT_REQUEST;
    [_renterContractModel registerview:self];
    
}

/*
 * Method to initialize views
 */
-(void)initializeViews{
    [self setBorderColourToView:self.labelView colour:[UIColor blackColor]];
    [self.rentalEquipmentButton setBackgroundColor:[UIColor blueColor]];
    [self.rentalEquipmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

/*
 * Method to set border colour to view.
 */
-(void)setBorderColourToView:(UIView*)view colour:(UIColor*)colour{
    view.layer.borderColor = colour.CGColor; // set color as you want.
    view.layer.borderWidth = 1.0;
}


/*
 * Method to initialize RenterContractModel
 */
-(void)initializeModel{
    [progressAlertView show:self];
    [_renterContractModel initialize];
}


-(void)update{
    
    [progressAlertView dismissCustomProgressDialog:^{[self onResponse];}];
    
}

-(void)onResponse{
    if (_renterContractModel.errorCode == SUCCESS_CODE) {
        [self.contractTableView reloadData];
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
    
    return [_renterContractModel.renterContractRentEquipmentArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RenterContractTableViewCell";
    
    RenterContractTableViewCell *cell = (RenterContractTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RenterContractTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setDataInCell:cell andIndex:indexPath];
    
    return cell;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"selected row index %i", indexPath.row);
    RenterContractListDao *renterContractListDao = [_renterContractModel.renterContractRentEquipmentArray objectAtIndex:indexPath.row];

    NSMutableDictionary *detailDictionary = [[NSMutableDictionary alloc]init];
    [detailDictionary setObject:renterContractListDao forKey:@"Dao_Key"];
    [detailDictionary setObject:self.renterContractModel.CONTRACT_REQUEST_TYPE_IDENTIFIER forKey:@"Request_Type_Key"];
    
    [[ApplicationController getInstance]handleEvent:EVENT_ID_RENTAL_SUPPLIER_INDIVIDUAL_CONTRACT_VIEW_SCREEN andeventObject:detailDictionary];
    
    
}



/*
 * Void method to set data in labels of cell
 */
-(void)setDataInCell:(RenterContractTableViewCell*)cell andIndex:(NSIndexPath *)indexPath{
    @autoreleasepool {
        RenterContractListDao *renterContractListDao = [_renterContractModel.renterContractRentEquipmentArray objectAtIndex:indexPath.row];
        if (renterContractListDao.renter_name!=nil) {
            cell.renterNameLabel.text = renterContractListDao.renter_name;
        }
        else{
            cell.renterNameLabel.text = @"N/A";
        }
        
        if (renterContractListDao.equipment_name!=nil) {
            cell.equipmentNameLabel.text = renterContractListDao.equipment_name;
        }
        else{
            cell.equipmentNameLabel.text = @"N/A";
        }
        
        if (renterContractListDao.price!=nil) {
            cell.priceLabel.text = renterContractListDao.price;
        }
        else{
            cell.priceLabel.text = @"N/A";
        }
        
        NSString* date=nil;
        if (renterContractListDao.to_date!=nil) {
            date = renterContractListDao.to_date;
        }
        if (renterContractListDao.from_date!=nil) {
            date = [date stringByAppendingFormat:@" To %@",renterContractListDao.from_date];
        }
        cell.dateLabel.text = date;
        
    }
}

-(void)onAlertViewLeftButtonClicked:(int)identifier{
    
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}

- (IBAction)backButtonClicked:(id)sender {
    [[ApplicationController getInstance]handleEvent:EVENT_ID_FINISH_SCREEN];
}

- (IBAction)rentalEquipmentButtonClicked:(id)sender {
    //Set selected button colour as blue
    [self.rentalEquipmentButton setBackgroundColor:[UIColor blueColor]];
    [self.rentalEquipmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //Deselected other button colour with clear colour
    [self.purchaseEquipmentButton setBackgroundColor:[UIColor clearColor]];
    [self.purchaseEquipmentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.renterContractModel.CONTRACT_REQUEST_TYPE_IDENTIFIER = RENTER_CONTRACT_RENT_REQUEST;
    
    //Initialize model for Rent Request-Response
    [self initializeModel];
}

- (IBAction)purchaseEquipmentButtonClicked:(id)sender {
    //Set selected button colour as blue
    [self.purchaseEquipmentButton setBackgroundColor:[UIColor blueColor]];
    [self.purchaseEquipmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //Deselected other button colour with clear colour
    [self.rentalEquipmentButton setBackgroundColor:[UIColor clearColor]];
    [self.rentalEquipmentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.renterContractModel.CONTRACT_REQUEST_TYPE_IDENTIFIER = RENTER_CONTRACT_PURCHASE_REQUEST;
    
    //Initialize model for Purchase Request-Response
    [self initializeModel];
}
@end
