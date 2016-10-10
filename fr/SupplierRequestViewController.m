//
//  IndividualRequestViewController.m
//  FleetRight
//
//  Created by test on 06/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "SupplierRequestViewController.h"

@interface SupplierRequestViewController ()

@end

@implementation SupplierRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"IndividualRequestTableViewCell";
    
    IndividualRequestTableViewCell *cell = (IndividualRequestTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IndividualRequestTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [self setDataInCell:cell andIndex:indexPath];
    
    return cell;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    NSLog(@"selected row index %i", indexPath.row);
//    
//    EquipmentDo *equipmentDo=[self.equipmentListServiceModel.equipmentListArray objectAtIndex:indexPath.row];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        // your navigation controller action goes here
//        [[ApplicationController getInstance]handleEvent:EVENT_ID_EQUIPMENT_DETAILS_SCREEN andeventObject:equipmentDo];
//    });
    
}

/*
 * Void method to set data in labels of cell
 */
-(void)setDataInCell:(IndividualRequestTableViewCell*)cell andIndex:(NSIndexPath *)indexPath{
    @autoreleasepool {
        
//        EquipmentDo *equipmentDo=[self.equipmentListServiceModel.equipmentListArray objectAtIndex:indexPath.row];
//        
//        cell.ename.text=equipmentDo.ename;
//        cell.year.text= [NSString stringWithFormat:@"Year- %li",(long)(equipmentDo.year)];
//        cell.modelNum.text=equipmentDo.mdname;
//        cell.hoursPerMile.text=[NSString stringWithFormat:@"Hours- %li",(long)(equipmentDo.hour_per_miles)];
//        cell.status.text=equipmentDo.status;
//        cell.daily.text=equipmentDo.daily;
//        cell.weekly.text=equipmentDo.weekly;
//        cell.monthly.text=equipmentDo.monthly;
//        
//        // set default user image while image is being downloaded
//        cell.equipmentUIImageView.image = [UIImage imageNamed:@"icon_logo.png"];
//        
//        if (equipmentDo.vehicleImage!=nil ) {
//            [cell.equipmentUIImageView setImage:equipmentDo.vehicleImage];
//        }
//        
//        if([equipmentDo.sale_price isEqual:@"0"])
//        {   cell.salePriceLabel.hidden=YES;
//            cell.salePrice.hidden=YES;
//            cell.notAvailForSaleLabel.hidden=NO;
//        }else{
//            cell.salePrice.text=equipmentDo.sale_price;
//            cell.salePriceLabel.hidden=NO;
//            cell.salePrice.hidden=NO;
//            cell.notAvailForSaleLabel.hidden=YES;
//        }
//        
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
}


- (IBAction)backButtonClicked:(id)sender {
     [[ApplicationController getInstance]handleEvent:EVENT_ID_FINISH_SCREEN];
}
@end
