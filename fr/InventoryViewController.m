//
//  InventoryViewController.m
//  FleetRight
//
//  Created by test on 05/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "InventoryViewController.h"

@interface InventoryViewController ()

@end

@implementation InventoryViewController

static NSString *simpleTableIdentifier = @"InventoryCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromPreferences];
    [self initializeInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    if (!isScreenLaunchFirst) {
        [self initFilterView];
        [self initializeModel];
        isScreenLaunchFirst = YES;
    }
    
}

/*
 * Method to get data from preferences
 */
-(void)getDataFromPreferences{
    userDefaultPreferences = [UserDefaultPreferences getInstance];
    NSString *prefRoleKey = PREF_KEY_ROLE;
    loginType = [userDefaultPreferences getString:prefRoleKey];
}

/*
 * Method to initialize views
 */
-(void)initializeInstance{
    [super initializeInstance];
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    
    [self.equipmentOnRentCollectionView registerNib:[UINib nibWithNibName:@"InventoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:simpleTableIdentifier];
    [self.soldEquipmentCollectionView registerNib:[UINib nibWithNibName:@"InventoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:simpleTableIdentifier];
    [self.idleEquipmentCollectionView registerNib:[UINib nibWithNibName:@"InventoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:simpleTableIdentifier];
    
    [_scrollView setContentSize:CGSizeMake(_parentView.frame.size.width, _parentView.frame.size.height)];
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    
}


-(void)initializeModel{
    [self.equipmentRentIndicator startAnimating];
    [self.soldEquipmentIndicator startAnimating];
    [self.idleEquipmentIndicator startAnimating];

    
    //If login person is supplier then display idle equipment Cell and animate indicator
    if ([loginType isEqual:LOGIN_TYPE_SUPPLIER]) {
        [self.idleEquipmentView setHidden:NO];
        //[self.idleEquipmentIndicator startAnimating];
    }
    
    self.inventoryModel = [[InventoryModel alloc]init];
    self.localModel.inventoryModel =  self.inventoryModel;
    [ self.inventoryModel registerview:self];
    [ self.inventoryModel initialize];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
     //Rent Equipment tag is 1
    if(collectionView.tag == 1)
    {
        return [self.inventoryModel.rentEquipmentArray count];
    }
    
    //Sold Equipment tag is 2
    else if (collectionView.tag == 2){
        return [self.inventoryModel.soldEquipmentArray count];
    }
    
    //Idle Equipment tag is 3
    else if (collectionView.tag == 3){
        if ( [self.inventoryModel.idleEquipmentArray count]>0) {
            return [self.inventoryModel.idleEquipmentArray count];
        }
        
    }
    return 1;
}




-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    InventoryCollectionViewCell *cell = (InventoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        [collectionView registerNib:[UINib nibWithNibName:@"InventoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:simpleTableIdentifier];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        
    }
    
    int ind = indexPath.row;
    [self setDataToInventoryCell:cell index:ind collectionView:collectionView];
    
    
    return cell;
    
}



/*
 * Here sets the data to each item cell.
 */
-(void) setDataToInventoryCell:(InventoryCollectionViewCell*) inventoryCollectionViewCell index:(int) index collectionView:(UICollectionView*)collectionView{
    @autoreleasepool {
        
        inventoryCollectionViewCell.collectionCellImageView.image = [UIImage imageNamed:@"icon_logo.png"];
        
        //Set Data of Rent Equipment
        if (collectionView.tag == 1) {
            if (self.inventoryModel.rentEquipmentArray!=nil &&[self.inventoryModel.rentEquipmentArray count]>0) {
                InventoryDao *inventoryDao = [self.inventoryModel.rentEquipmentArray objectAtIndex:index];
                
                if (inventoryDao.vehicleImage!=nil) {
                    [  inventoryCollectionViewCell.collectionCellImageView setImage:inventoryDao.vehicleImage];
                }
                if (inventoryDao.equipment_name!=nil) {
                    inventoryCollectionViewCell.collectionCellLabel.text = inventoryDao.equipment_name;
                }
                inventoryDao = nil;
                
            }
            
        }
        
         //Set Data of Sold Equipment
        else if (collectionView.tag == 2) {
            if (self.inventoryModel.soldEquipmentArray!=nil &&[self.inventoryModel.soldEquipmentArray count]>0) {
                InventoryDao *inventoryDao = [self.inventoryModel.soldEquipmentArray objectAtIndex:index];
                
                if (inventoryDao.vehicleImage!=nil) {
                    [  inventoryCollectionViewCell.collectionCellImageView setImage:inventoryDao.vehicleImage];
                }
                if (inventoryDao.equipment_name!=nil) {
                    inventoryCollectionViewCell.collectionCellLabel.text = inventoryDao.equipment_name;
                }
                inventoryDao = nil;
            }
            
        }
        
         //Set Data of Idle Equipment
        else if (collectionView.tag == 3) {
            if (self.inventoryModel.idleEquipmentArray!=nil &&[self.inventoryModel.idleEquipmentArray count]>0) {
                InventoryDao *inventoryDao = [self.inventoryModel.idleEquipmentArray objectAtIndex:index];
                
                if (inventoryDao.vehicleImage!=nil) {
                    [  inventoryCollectionViewCell.collectionCellImageView setImage:inventoryDao.vehicleImage];
                }
                if (inventoryDao.equipment_name!=nil) {
                    inventoryCollectionViewCell.collectionCellLabel.text = inventoryDao.equipment_name;
                }
                inventoryDao = nil;
            }
            
        }
        
        
    }
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (IBAction)backButtonClicked:(id)sender {
    [[ApplicationController getInstance]handleEvent:EVENT_ID_FINISH_SCREEN];
}

-(void)update{
    [self.equipmentRentIndicator stopAnimating];
    [self.soldEquipmentIndicator stopAnimating];
    
    if ([self.idleEquipmentIndicator isAnimating]) {
        [self.idleEquipmentIndicator stopAnimating];
    }
    
    if (self.inventoryModel.errorCode == SUCCESS_CODE) {
        [self.equipmentOnRentCollectionView reloadData];
        [self.soldEquipmentCollectionView reloadData];
        [self.idleEquipmentCollectionView reloadData];
    }
    else{
        [customAlertView setMessage:self.inventoryModel.errorMessage];
        [customAlertView show:self];
    }
    
}

-(void)onAlertViewLeftButtonClicked:(int)identifier{
    
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}

-(void)destroy{
    _actionBarHeaderView = nil;
    _equipmentOnRentCollectionView= nil;
    _soldEquipmentCollectionView= nil;
    _idleEquipmentCollectionView = nil;
    _scrollView= nil;
    _parentView= nil;
    _inventoryModel= nil;
    _equipmentRentIndicator= nil;
    _soldEquipmentIndicator= nil;
    customAlertView = nil;
    
}
@end
