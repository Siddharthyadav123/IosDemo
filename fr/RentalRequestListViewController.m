//
//  RentalRequestListViewController.m
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "RentalRequestListViewController.h"

@interface RentalRequestListViewController ()

@end

@implementation RentalRequestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeInstance];
    [self getDataFromPreferences];
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
}

/*
 * Method to initialize views
 */
-(void)initializeInstance{
    [super initializeInstance];
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    userDefaultPreferences = [UserDefaultPreferences getInstance];
    [_activityIndicator startAnimating];
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    progressAlertView = [CustomAlertView createCustomProgressDialog:CUSTOM_ALERT_PROGRESS_TITLE delegate:self identifier:2];
    _renterRequestListModel = [[RenterRequestListModel alloc]init];
    [_renterRequestListModel registerview:self];
    [_renterRequestListModel initialize];
    
    _supplierRequestApprovalModel = [[SupplierRequestApprovalModel alloc]init];
    [_supplierRequestApprovalModel registerview:self];
    
}

-(void)update{
    [_activityIndicator stopAnimating];
    if (_renterRequestListModel.errorCode == SUCCESS_CODE) {
        [self.renterTableView reloadData];
    }
    else{
        if (![Utils isInternertConnectionAvailabel]) {
            [customAlertView setMessage:@"No Internet connection available"];
        }
        else{
            [customAlertView setMessage:_renterRequestListModel.errorMessage];
        }
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_renterRequestListModel.renterListArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RentalRequestTableViewCell";
    
    RentalRequestTableViewCell *cell = (RentalRequestTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RentalRequestTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.rentalRequestListViewController = self;
    cell.pendingButton.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setDataInCell:cell andIndex:indexPath];
    
    return cell;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"selected row index %i", indexPath.row);
    
    
    
    RenterRequestListDao *renterRequestListDao=[self.renterRequestListModel.renterListArray objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([loginType isEqual:LOGIN_TYPE_SUPPLIER]) {
            // If requesting persion is Supplier then open individual Supplier request screen
            [[ApplicationController getInstance]handleEvent:EVENT_ID_SUPPLIER_REQUEST_INDIVIDUAL_VIEW_SCREEN andeventObject:renterRequestListDao];
        }
        else{
            // If requesting persion is renter then open individual Renter request screen
            [[ApplicationController getInstance]handleEvent:EVENT_ID_RENTAL_REQUEST_INDIVIDUAL_VIEW_SCREEN andeventObject:renterRequestListDao];
        }
    });
    
}


/*
 * Method to get data from preferences
 */
-(void)getDataFromPreferences{
    NSString *prefRoleKey = PREF_KEY_ROLE;
    loginType = [userDefaultPreferences getString:prefRoleKey];
}

/*
 * Void method to set data in labels of cell
 */
-(void)setDataInCell:(RentalRequestTableViewCell*)cell andIndex:(NSIndexPath *)indexPath{
    @autoreleasepool {
        
        
        RenterRequestListDao *renterRequestListDao = [_renterRequestListModel.renterListArray objectAtIndex:indexPath.row];
        
        //Set any random colour to imageview background
        [cell.ownerImageView setBackgroundColor:[UIColor colorWithRed:0.8/[_renterRequestListModel.renterListArray count]*((double)indexPath.row)+0.2 green:0.8/indexPath.section*((double)indexPath.section)+0.2 blue:((double)(random()%1000))/1000.0 alpha:0.8]];
        
        if (renterRequestListDao.request_name!=nil) {
            cell.ownerNameLabel.text = renterRequestListDao.request_name;
        }
        else{
            cell.ownerNameLabel.text = @"N/A";
        }
        
        
        NSString* location;
        if (renterRequestListDao.job_location!=nil) {
            location = renterRequestListDao.job_location;
        }
        
        if (renterRequestListDao.province!=nil) {
            location = [location stringByAppendingFormat:@"\n %@",renterRequestListDao.province];
        }
        cell.jobLicationLabel.text = location;
        location = nil;
        
        
        
        if (renterRequestListDao.request_for!=nil) {
            cell.requestLabel.text = renterRequestListDao.request_for;
        }else{
            cell.requestLabel.text = @"N/A";
        }
        
        
        if (renterRequestListDao.status!=nil && ![renterRequestListDao.status isEqual:@""]) {
            [cell.pendingButton setTitle:renterRequestListDao.status forState:UIControlStateNormal];
        }
        
        
        NSString* duration;
        if (renterRequestListDao.from_date!=nil) {
            NSArray *itemsSplittedArray = [renterRequestListDao.from_date componentsSeparatedByString:@","];
            duration = [itemsSplittedArray objectAtIndex:0];
            itemsSplittedArray = nil;
        }
        
        if (renterRequestListDao.to_date!=nil) {
            NSArray *itemsSplittedArray = [renterRequestListDao.to_date componentsSeparatedByString:@","];
            duration = [duration stringByAppendingFormat:@" To %@",[itemsSplittedArray objectAtIndex:0]];
            itemsSplittedArray = nil;
        }
        
        cell.durationLabel.text =duration;
        duration = nil;
        
        
        if (renterRequestListDao.request_name !=nil) {
            //Get First Character of name
            NSString *firstLetter = [renterRequestListDao.request_name substringToIndex:1];
            cell.firstCharacterLabel.text = firstLetter;
            firstLetter = nil;
        }
        
    }
}

/*
 * Method gets called when click on Accept button
 */
-(void)onPendingButtonClicked:(int)clickedButtonIndex{
    RenterRequestListDao *renterRequestListDao = [_renterRequestListModel.renterListArray objectAtIndex:clickedButtonIndex];
    _supplierRequestApprovalModel.renterRequestListDao = renterRequestListDao;
    _supplierRequestApprovalModel.rentalRequestListViewController = self;
    _supplierRequestApprovalModel.buttonIndex = clickedButtonIndex;
    [_supplierRequestApprovalModel initialize];
    
}

/*
 * Method gets called on response of Status Approval
 */

-(void)onStatusApprovalResponse:(int)buttonIndex{
    
    if (_supplierRequestApprovalModel.errorCode == SUCCESS_CODE) {
        RenterRequestListDao *renterRequestListDao = [_renterRequestListModel.renterListArray objectAtIndex:buttonIndex];
        //        renterRequestListDao.status = @"Accepted";
        //        [self.renterTableView reloadData];
        [_activityIndicator startAnimating];
        [_renterRequestListModel initialize];
        
    }
    
    [customAlertView setMessage:_supplierRequestApprovalModel.errorMessage];
    
    [customAlertView show:self];
    
}

-(void)onAlertViewLeftButtonClicked:(int)identifier{
    
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}


@end
