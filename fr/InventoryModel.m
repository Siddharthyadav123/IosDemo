//
//  InventoryModel.m
//  FleetRight
//
//  Created by test on 07/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "InventoryModel.h"

@implementation InventoryModel



-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self getDataFromPreferences];
    [self executeTask];
}

-(void)onPreTaskExecute{
    
    NSString *url;
    if ([loginType isEqual:LOGIN_TYPE_SUPPLIER]) {
        url= [URL_GET_SUPPLIER_INVENTORY stringByAppendingString:@""];
    }
    else{
        url= [URL_GET_RENTER_INVENTORY stringByAppendingString:@""];
    }
    
    [httpRequestHandlerImpl setServiceURL:url];
    [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_GET_RENTER_INVENTORY %@", url);
    url = nil;
    
}

/*
 * Method to initializes instances
 */
-(void)initializeInstances{
    self.rentEquipmentArray = [[NSMutableArray alloc]init];
    self.soldEquipmentArray = [[NSMutableArray alloc]init];
    self.idleEquipmentArray = [[NSMutableArray alloc]init];
}

/*
 * Method to get data from preferences
 */
-(void)getDataFromPreferences{
    userDefaultPreferences = [UserDefaultPreferences getInstance];
    NSString *prefRoleKey = PREF_KEY_ROLE;
    loginType = [userDefaultPreferences getString:prefRoleKey];
}


-(void)doInBackGround{
    
    [self requestData];
}

-(void)onTaskStopExecution{
    
}

/*
 * Method to post data in server
 */
-(void)requestData{
    [httpRequestHandlerImpl execute];
    
}

-(void)onResponse:(NSData *)responseData{
    NSLog(@"On Response: %@",responseData);
    if(responseData!=nil){
        [self parseResponseData:responseData];
    }
    [self informView];
}

/*
 * Parse the response data here.
 */
-(void)parseResponseData:(NSData*)responseData{
    NSError* error;
    NSDictionary* jsonData = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:kNilOptions
                              error:&error];
    NSLog(@"jsonData: %@", jsonData);
    NSLog(@"JSONERROR: %@",error);
    
    if(jsonData!=nil){
        [self parseDictionaryResponse:jsonData];
        [self informView];
        
    }else{
        self.errorMessage=@"Error in parsing";
    }
    
    NSLog(@"error message :  %@",self.errorMessage);
}


-(void)parseDictionaryResponse :(NSDictionary*)jsonResponse{
    @autoreleasepool {
        
        //Parsing logic of "equipments_on_rent" key
        if([jsonResponse objectForKey:@"equipments_on_rent"]!=[NSNull null])
        {
            NSArray *tempRentEquipmentArray=[jsonResponse objectForKey:@"equipments_on_rent"];
            
            if (tempRentEquipmentArray!=nil && [tempRentEquipmentArray count]>0) {
                for(int i=0;i<[tempRentEquipmentArray count];i++)
                {
                    NSDictionary *item = [tempRentEquipmentArray objectAtIndex:i];
                    
                    InventoryDao *inventoryDao=[self parseRentEquipmentResponse:item];
                    
                    [self.rentEquipmentArray addObject:inventoryDao];
                    
                }
                if ([self.rentEquipmentArray count]>0) {
                    
                    [self initializeImageDownloadManager:IMAGE_REQUEST_FROM_RENT];
                    self.errorCode = SUCCESS_CODE;
                }
                
                tempRentEquipmentArray = nil;
                
            }
            
            else{
                self.errorMessage=@"Error";
            }
            
        }
        
        
        //Parsing logic of "equipments_sold" key
        if([jsonResponse objectForKey:@"equipments_sold"]!=[NSNull null])
        {
            NSArray *tempSoldEquipmentArray=[jsonResponse objectForKey:@"equipments_sold"];
            
            if (tempSoldEquipmentArray!=nil && [tempSoldEquipmentArray count]>0) {
                for(int i=0;i<[tempSoldEquipmentArray count];i++)
                {
                    NSDictionary *item = [tempSoldEquipmentArray objectAtIndex:i];
                    
                    InventoryDao *inventoryDao=[self parseRentEquipmentResponse:item];
                    
                    [self.soldEquipmentArray addObject:inventoryDao];
                    
                }
                if ([self.soldEquipmentArray count]>0) {
                   
                    [self initializeImageDownloadManager:IMAGE_REQUEST_FROM_SOLD];
                    self.errorCode = SUCCESS_CODE;
                }
                tempSoldEquipmentArray = nil;
                
            }
            
            else{
                self.errorMessage=@"Error";
            }
            
            
        }
        
        
        //Parsing logic of "equipments_idle" key
        if([jsonResponse objectForKey:@"equipments_idle"]!=[NSNull null])
        {
            NSArray *tempIdleEquipmentArray=[jsonResponse objectForKey:@"equipments_idle"];
            
            if (tempIdleEquipmentArray!=nil && [tempIdleEquipmentArray count]>0) {
                for(int i=0;i<[tempIdleEquipmentArray count];i++)
                {
                    NSDictionary *item = [tempIdleEquipmentArray objectAtIndex:i];
                    
                    InventoryDao *inventoryDao=[self parseRentEquipmentResponse:item];
                    
                    [self.idleEquipmentArray addObject:inventoryDao];
                    
                }
                if ([self.idleEquipmentArray count]>0) {
                
                    [self initializeImageDownloadManager:IMAGE_REQUEST_FROM_IDLE];
                    self.errorCode = SUCCESS_CODE;
                }
                tempIdleEquipmentArray = nil;
                
            }
            
            else{
                self.errorMessage=@"Error";
            }
            
            
        }
        
        
        
    }
}


/*
 {
 "equipments_on_rent": [3]
 0:  {
 "contract_id": 1
 "equipment_id": 58
 "equipment_name": "Datalist"
 "equipment_image": "http://fleetright.dev/uploads/maxresdefault.jpg"
 }
 1:  {
 "contract_id": 2
 "equipment_id": 48
 "equipment_name": "Ducati"
 "equipment_image": "http://fleetright.alkurn.net/uploads/default.jpg"
 }
 2:  {
 "contract_id": 4
 "equipment_id": 49
 "equipment_name": "Dicor"
 "equipment_image": "http://fleetright.dev/uploads/maxresdefault.jpg"
 }
 
 "equipments_sold": [1]
 0:  {
 "contract_id": 5
 "equipment_id": 50
 "equipment_name": "Titanium"
 "equipment_image": "http://fleetright.dev/uploads/maxresdefault.jpg"
 }
 
 }
 
 Failure
 {
 "equipments_on_rent": [0]
 "equipments_sold": [0]
 }
 */
-(InventoryDao*)parseRentEquipmentResponse:(NSDictionary*) item
{
    @autoreleasepool {
        
        InventoryDao *inventoryDao=[[InventoryDao alloc]init];
        if([item objectForKey:@"contract_id"]!=[NSNull null])
        {
            inventoryDao.contract_id=[[item objectForKey:@"contract_id"] integerValue];
        }
        
        if([item objectForKey:@"equipment_id"]!=[NSNull null])
        {
            inventoryDao.equipment_id=[[item objectForKey:@"equipment_id"] integerValue];
        }
        
        if([item objectForKey:@"equipment_name"]!=[NSNull null])
        {
            inventoryDao.equipment_name=[item objectForKey:@"equipment_name"];
            
        }
        if([item objectForKey:@"equipment_image"]!=[NSNull null])
        {
            inventoryDao.equipment_image_URL=[item objectForKey:@"equipment_image"];
            
        }
        
        return inventoryDao;
        
    }
}


-(void)initializeImageDownloadManager:(NSString*)identifier{
    
    @autoreleasepool {
        NSMutableArray *vehicleImageArray ;
        if ([identifier isEqual:IMAGE_REQUEST_FROM_RENT]) {
            vehicleImageArray = self.rentEquipmentArray;
        }
        else if ([identifier isEqual:IMAGE_REQUEST_FROM_SOLD]){
            vehicleImageArray = self.soldEquipmentArray;
        }
        else if ([identifier isEqual:IMAGE_REQUEST_FROM_IDLE]){
            vehicleImageArray = self.idleEquipmentArray;
        }
        
        
        int vehicleImageCount= (int)[vehicleImageArray count];
        
        for (int i=0; i<vehicleImageCount; i++) {
            
            InventoryDao *inventoryDao = [vehicleImageArray objectAtIndex:i];
            
            NSString *url=nil;
            if([inventoryDao.equipment_image_URL containsString:@" "])
            {
                url = [inventoryDao.equipment_image_URL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
            }else{
                url=inventoryDao.equipment_image_URL;
            }
            
         
            
            NSURL *imageURL = [NSURL URLWithString:url];
            
            AsyncImageDownloaderModel *asyncImageDownloaderModel = [[AsyncImageDownloaderModel alloc]init];
            asyncImageDownloaderModel.imageIndex = i;
            asyncImageDownloaderModel.imageURL =imageURL;
            asyncImageDownloaderModel.imageRequestIdentifier = identifier;
            asyncImageDownloaderModel.inventoryModel = self;
            [asyncImageDownloaderModel initialize];
            
           
            
        }
    }
    
}


-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded identifier:(NSString*)identifier{
    
        @autoreleasepool {
        if (succeeded) {
            InventoryDao *inventoryDao;
            if ([identifier isEqual:IMAGE_REQUEST_FROM_RENT]) {
                inventoryDao = [self.rentEquipmentArray objectAtIndex:index];
                
            }
            else if ([identifier isEqual:IMAGE_REQUEST_FROM_SOLD]){
                inventoryDao = [self.soldEquipmentArray objectAtIndex:index];
                
            }
            else if ([identifier isEqual:IMAGE_REQUEST_FROM_IDLE]){
                inventoryDao = [self.idleEquipmentArray objectAtIndex:index];
                
            }
            [inventoryDao setVehicleImage:image];
            [self informView];
        }
    }
    
}

@end
