//
//  DashboardViewController.m
//  FleetRight
//
//  Created by test on 05/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
// blue colour: 43A6D6

#import "DashboardViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

static NSString *simpleTableIdentifier = @"DashboardCollectionViewCell";

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
    [self initFilterView];
}

/*
 * Method to initialize views
 */
-(void)initializeInstance{
    [super initializeInstance];
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DashboardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:simpleTableIdentifier];
    
    dashboardImagesArray = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"inventory.png"],
                            [UIImage imageNamed:@"ic_billings.png"],
                            [UIImage imageNamed:@"ic_request.png"],
                            [UIImage imageNamed:@"contracts.png"],
                            nil];
    dashboardLabelArray = [[NSMutableArray alloc]initWithObjects:@"My Equipments",@"Billings & Payments", @"Request", @"Contracts", nil];
    
    
    if ([role isEqual:LOGIN_TYPE_SUPPLIER]) {
        //TO Do change my equipment to Inventory if login person is Supplier
        [dashboardLabelArray replaceObjectAtIndex:0 withObject:@"Inventory"];
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [dashboardLabelArray count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.collectionView.frame.size.width/2)-2, (collectionView.frame.size.height/2)-10);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DashboardCollectionViewCell *cell = (DashboardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        [collectionView registerNib:[UINib nibWithNibName:@"DashboardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:simpleTableIdentifier];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        
    }
    
    int ind = indexPath.row;
    [self setDataToOtherEquipmentCell:cell index:ind];
    
    
    return cell;
    
}


/*
 * Here sets the data to each item cell.
 */
-(void) setDataToOtherEquipmentCell:(DashboardCollectionViewCell*) dashboardCollectionViewCell index:(int) index{
    @autoreleasepool {
        
        
        dashboardCollectionViewCell.dashboardCellImageview.image = [dashboardImagesArray objectAtIndex:index];
        
        dashboardCollectionViewCell.dashboardCellLabel.text = [dashboardLabelArray objectAtIndex:index];
        
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [[ApplicationController getInstance]handleEvent:EVENT_ID_INVENTORY_VIEW_SCREEN];
    }
    else if(indexPath.row==2){
        //[[ApplicationController getInstance]handleEvent:EVENT_ID_INDIVIDUAL_REQUEST_VIEW_SCREEN];
        [[ApplicationController getInstance]handleEvent:EVENT_ID_RENTAL_REQUEST_LIST_VIEW_SCREEN];
    }
    else if(indexPath.row==3){
      
        [[ApplicationController getInstance]handleEvent:EVENT_ID_RENTAL_CONTRACT_LIST_VIEW_SCREEN];
    }
    
    
}

/*
 * Method to get data from preferences
 */
-(void)getDataFromPreferences{
    userDefaultPreferences = [UserDefaultPreferences getInstance];
    NSString *prefRoleKey = PREF_KEY_ROLE;
    role = [userDefaultPreferences getString:prefRoleKey];
}

@end
