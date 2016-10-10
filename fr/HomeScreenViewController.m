//
//  HomeScreenViewController.m
//  FleetRight
//
//  Created by Ranjit singh on 8/12/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "EquipmentTableViewCell.h"
#import "EquipmentDo.h"
#import "EquipmentDetailViewController.h"


@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeInstance];
    [super requestFilterEquimentCateogries];
    [self requestEquimentList];
    [self checkForInternet];
    
}

-(void)mapMembersToParent
{
    super.tableView=self.tableView;
    super.progressBar=self.progressBar;
}


/*
 * Method to check internet connection
 */
-(void)checkForInternet{
    if (![Utils isInternertConnectionAvailabel]) {
        [self getDataFromDataBase];
        [self getVehicleImageData];
    }
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
    
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    //initializing equipment list service moodel
    self.equipmentListServiceModel=[[EquipmentListServiceModel alloc]init];
    [self.equipmentListServiceModel registerview:self];
    
    //adding actionbar view
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    
    dataFromDBArray = [[NSMutableArray alloc]init];
    vehicleImageLocalDataArray = [[NSMutableArray alloc]init];
}

-(void) requestEquimentList{
    //show table view
    if(self.tableView!=nil)
    {
        self.tableView.hidden=true;
    }
    //show loading
    [self showInnerLoading];
    
    //go for equipment list
    [self.equipmentListServiceModel initialize ];
}


-(void) update{
    
    [super hideInnerLoading];
    self.tableView.hidden=false;
    
    if (self.equipmentListServiceModel.errorCode == SUCCESS_CODE) {
        [self.tableView reloadData];
        // NSLog(@">> Success")
        
    }
    else{
        
        if (customAlertView.message!=nil && ![customAlertView.message isEqualToString:@""]) {
            [customAlertView setMessage:self.equipmentListServiceModel.errorMessage];
            [customAlertView show:self];
            
        }
    }
    
    [self.tableView reloadData];
    self.filterView.filterEquipmentCateoryList=[[[ApplicationController getInstance] getModelFacade]getLocalModel].filterEquipmentCateoryList;
    [self.filterView.tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataFromDBArray!=nil && [dataFromDBArray count]>0) {
        return [dataFromDBArray count];
    }
    
    if(self.equipmentListServiceModel!=nil && self.equipmentListServiceModel.equipmentListArray!=nil)
    {
        return [self.equipmentListServiceModel.equipmentListArray count];
    }
    
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"EquipmentTableViewCell";
    
    EquipmentTableViewCell *cell = (EquipmentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EquipmentTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.homeScreenViewController = self;
    cell.viewDetailButton.tag = indexPath.row;
    [self setDataInCell:cell andIndex:indexPath];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self launchEquipmentDetailScreen:indexPath.row];
}

/*
 * Method called from cell, on click of
 */
-(void)onViewDetailButtonClicked:(int)buttonIndex{
    [self launchEquipmentDetailScreen:buttonIndex];
    
}

/*
 * Method to launch EquipmentDetailScreen
 */
-(void)launchEquipmentDetailScreen:(int)index{
    EquipmentDo *equipmentDo;
    
    //If no internet, then pass Equipment Dao of dataFromDBArray.
    if (![Utils isInternertConnectionAvailabel]) {
        if (dataFromDBArray!=nil && [dataFromDBArray count]>0) {
            equipmentDo=[dataFromDBArray objectAtIndex:index];
            
        }
    }
    
    else{
        equipmentDo=[self.equipmentListServiceModel.equipmentListArray objectAtIndex:index];
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // your navigation controller action goes here
        [[ApplicationController getInstance]handleEvent:EVENT_ID_EQUIPMENT_DETAILS_SCREEN andeventObject:equipmentDo];
    });
}


/*
 * Void method to set data in labels of cell
 */
-(void)setDataInCell:(EquipmentTableViewCell*)cell andIndex:(NSIndexPath *)indexPath{
    @autoreleasepool {
        
        EquipmentDo *equipmentDo;
        if (![Utils isInternertConnectionAvailabel]) {
            [self setVehicleImageFromLocal:indexPath.row];
        }
        
        if (dataFromDBArray!=nil && [dataFromDBArray count]>0) {
            equipmentDo=[dataFromDBArray objectAtIndex:indexPath.row];
            
        }
        
        if (self.equipmentListServiceModel.equipmentListArray!=nil && [self.equipmentListServiceModel.equipmentListArray count]>0) {
            equipmentDo=[self.equipmentListServiceModel.equipmentListArray objectAtIndex:indexPath.row];
            
        }
        
        if (equipmentDo.ename!=nil) {
            cell.ename.text=equipmentDo.ename;
        }
        else{
            cell.ename.text=@"N/A";
        }
        
        
        if (equipmentDo.year!=0) {
            cell.year.text= [NSString stringWithFormat:@"Year- %li",(long)(equipmentDo.year)];
        }
        else{
            cell.year.text= 0;
        }
        
        
        if (equipmentDo.mdname!=nil) {
            cell.modelNum.text=equipmentDo.mdname;
        }
        else{
            cell.modelNum.text=@"N/A";
        }
        
        
        if (equipmentDo.hour_per_miles!=0) {
            cell.hoursPerMile.text=[NSString stringWithFormat:@"Hours- %li",(long)(equipmentDo.hour_per_miles)];
        }
        else{
            cell.hoursPerMile.text=0;
        }
        
        
        if (equipmentDo.daily!=nil) {
            cell.daily.text=equipmentDo.daily;
            
        }
        else{
            cell.daily.text=@"N/A";
            
        }
        
        if (equipmentDo.weekly!=nil) {
            cell.weekly.text=equipmentDo.weekly;
        }
        else{
            cell.weekly.text=@"N/A";
        }
        
        
        if (equipmentDo.monthly!=nil) {
            cell.monthly.text=equipmentDo.monthly;
        }
        else{
            cell.monthly.text=@"N/A";
        }
        
        //cell.status.text=equipmentDo.status;
        
        // set default user image while image is being downloaded
        cell.equipmentUIImageView.image = [UIImage imageNamed:@"icon_logo.png"];
        
        if (equipmentDo.vehicleImage!=nil ) {
            [cell.equipmentUIImageView setImage:equipmentDo.vehicleImage];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
}


/*
 * Method to set vehicle image in image view which get from Local Directory.
 */

-(void)setVehicleImageFromLocal:(int)index{
    
    @try {
        NSString *filePathName = [vehicleImageLocalDataArray objectAtIndex:index];
        
        if (filePathName!=nil) {
            
            ///var/mobile/Containers/Data/Application/4C178C64-4E15-462E-881A-AEFCCC4E85AA/Documents/Home_Screen_Vehicle_Image/home_screen_vehicle_image_027_index.png
            
            //trim file name to get last 10 digits of name
            NSString* trimStr = [filePathName substringToIndex:[filePathName length] - 10];
            
            //trim file name to get last 2 digits of name
            trimStr = [trimStr substringFromIndex: [trimStr length] - 2];
            
            NSInteger indexOfImage = [trimStr integerValue];
            
            //NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePathName];
            
            NSData *data = [NSData dataWithContentsOfFile:filePathName];
            
            UIImage *image = [[UIImage alloc] initWithData:data];
            
            if ([dataFromDBArray count]>0) {
                
                EquipmentDo *equipmentDo=[dataFromDBArray objectAtIndex:indexOfImage];
                
                [equipmentDo setVehicleImage:image];
                
            }
            
            filePathName = nil;
            data = nil;
            image = nil;
        }
        
        
        
    } @catch (NSException *exception) {
        NSLog(@"Ecception %@",exception);
    }
}


/*
 * Method to get Data From DataBase
 */
-(NSMutableArray*)getDataFromDataBase{
    
    HomeScreenDataManager *homeScreenDataManager = self.localModel.homeScreenDataTable;
    
    NSArray *dataArray = [homeScreenDataManager getData];
    if ([dataArray count]>0) {
        
        NSLog(@"Get Data Array count %lu",(unsigned long)[dataArray count]);
        
        int count = (int)[dataArray count];
        
        if ([dataFromDBArray count]!=0) {
            [dataFromDBArray removeAllObjects];
        }
        
        for (int i=0; i<count; i++) {
            
            EquipmentDo* equipmentDo = [dataArray objectAtIndex:i];
            NSLog(@"getDataFromDataBase %@ at an index %d",equipmentDo,i);
            [dataFromDBArray addObject:equipmentDo];
            
        }
        
        return  dataFromDBArray;
        
    }
    
    
    return  nil;
    
}

/*
 * Method to get vehicle imahe data from local memory storage
 */
-(void)getVehicleImageData{
    
    NSString* folderPath = [self.equipmentListServiceModel createFolderForImages];
    
    if (folderPath!=nil) {
        NSArray* filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath: folderPath  error:nil];
        
        NSLog(@"files array %@", filePathsArray);
        
        if ([filePathsArray count]>0) {
            
            int count = (int)[filePathsArray count];
            
            for (int i=0; i<count; i++) {
                
                NSString *filePath = [folderPath stringByAppendingPathComponent:[filePathsArray objectAtIndex:i]];
                
                NSLog(@"Retrive data %@",filePath);
                
                
                [vehicleImageLocalDataArray addObject:filePath];
                
                filePath = nil;
                //data = nil;
                
            }
            filePathsArray = nil;
            folderPath = nil;
            
            
        }
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)destroy{
    self.progressBar = nil;
    
}

-(void)onAlertViewLeftButtonClicked:(int)identifier{
    
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}

@end
