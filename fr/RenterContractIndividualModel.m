//
//  RenterContractIndividualModel.m
//  FleetRight
//
//  Created by test on 21/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "RenterContractIndividualModel.h"
#import "RenterSupplierIndividualContractViewController.h"

@implementation RenterContractIndividualModel
//http://alkurn.net/clients/fleetright/api/web/v1/contracts/renter-contracts-for-rent?renter_id=51&contract_id=1
//http://alkurn.net/clients/fleetright/api/web/v1/contracts/renter-contracts-for-sold?renter_id=51&contract_id=5
//http://alkurn.net/clients/fleetright/api/web/v1/contracts/supplier-contracts-for-rent?supplier_id=46&contract_id=1
//http://alkurn.net/clients/fleetright/api/web/v1/contracts/supplier-contracts-for-sold?supplier_id=46&contract_id=5

-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self getDataFromPreferences];
    [self getDataFromDictionary];
    [self executeTask];
}

-(void)onPreTaskExecute{
    
    NSString*  parameter = [NSString stringWithFormat:@"contract_id=%ld",(long)renterContractListDao.contract_id];
    NSString *url=nil;
    
    if (renterContractListDao!=nil) {
        //Request for rent equipment
        if ([CONTRACT_INDIVIDUAL_REQUEST_TYPE_IDENTIFIER isEqual: RENTER_CONTRACT_RENT_REQUEST ]) {
            
            //Login user is supplier.
            if ([loginType isEqual:LOGIN_TYPE_SUPPLIER]) {
                
                url = [URL_GET_SUPPLIER_INDIVIDUAL_CONTRACT_RENT_EQUIPMENT stringByAppendingString:parameter];
            }
            else{
                //Login user is renter.
                url = [URL_GET_RENTER_INDIVIDUAL_CONTRACT_RENT_EQUIPMENT stringByAppendingString:parameter];
            }
        }
        
        //Request for purchase equipment
        else if([CONTRACT_INDIVIDUAL_REQUEST_TYPE_IDENTIFIER isEqual: RENTER_CONTRACT_PURCHASE_REQUEST]){
            
            //Login user is supplier.
            if ([loginType isEqual:LOGIN_TYPE_SUPPLIER]) {
                url = [URL_GET_SUPPLIER_INDIVIDUAL_CONTRACT_SOLD_EQUIPMENT stringByAppendingString:parameter];
            }
            else{
                //Login user is renter.
                url = [URL_GET_RENTER_INDIVIDUAL_CONTRACT_SOLD_EQUIPMENT stringByAppendingString:parameter];
            }
        }
        
        [httpRequestHandlerImpl setServiceURL:url];
        [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
        [httpRequestHandlerImpl setMethodType:HTTP_GET];
        NSLog(@"URL_GET_RENTAL_REQUEST_Individual %@", url);
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
 * Method to get deo and Request type from dictionary
 */
-(void)getDataFromDictionary{
    renterContractListDao = [self.renterContractListDataDict objectForKey:@"Dao_Key"];
    CONTRACT_INDIVIDUAL_REQUEST_TYPE_IDENTIFIER = [self.renterContractListDataDict objectForKey:@"Request_Type_Key"];
}

/*
 * Method to initializes instances
 */
-(void)initializeInstances{
    _renterContractIndividualDao = [[RenterContractListDao alloc]init];
    
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
        [self parseEquipmentDetailResponse:jsonData];
        //Request to download image for renter
        [self initializeImageDownloadManager:IMAGE_DOWNLOAD_REQUEST_FOR_RENTER];
        
        //Request to download image for supplier
        [self initializeImageDownloadManager:IMAGE_DOWNLOAD_REQUEST_FOR_SUPPLIER];
        
        //Request to download image for vehicle
        [self initializeImageDownloadManager:IMAGE_REQUEST_FROM_INDIVIDUAL_CONTRACT];
        self.errorCode = SUCCESS_CODE;
        
    }else{
        self.errorMessage=@"Error in parsing";
    }
    
    NSLog(@"error message :  %@",self.errorMessage);
}

/*
 Renter
 "contract_id": 10
 "equipment_name": "Planer Honda"
 "request_name": "Alkurn111"
 "job_location": "okokokok"
 "from_date": "01 Aug,16"
 "to_date": "30 Aug,16"
 "equipment_status": "Rented"
 "plan": "Month"
 "price": "$150"
 "supplier_image": "/home1/alkurnte/public_html/clients/fleetright/uploads/avatar/profile_user-1474117232.jpg"
 "renter_image": "/home1/alkurnte/public_html/clients/fleetright/uploads/avatar/michael-wilson-1474117162.jpg"
 "equipment_image": "http://fleetright.alkurn.net/uploads/default.jpg"
 "supplier_name": "Yogesh Dangre"
 "renter_name": "Sankalp Bhoyar"
 */


-(void)
parseEquipmentDetailResponse:(NSDictionary*)item{
    
    @autoreleasepool {
        
        if([item objectForKey:@"contract_id"]!=[NSNull null])
        {
            _renterContractIndividualDao.contract_id=[[item objectForKey:@"contract_id"] integerValue];
        }
        
        if([item objectForKey:@"equipment_name"]!=[NSNull null])
        {
            _renterContractIndividualDao.equipment_name=[item objectForKey:@"equipment_name"];
            
        }
        
        if([item objectForKey:@"request_name"]!=[NSNull null])
        {
            _renterContractIndividualDao.request_name=[item objectForKey:@"request_name"];
            
        }
        
        if([item objectForKey:@"job_location"]!=[NSNull null])
        {
            _renterContractIndividualDao.job_location=[item objectForKey:@"job_location"];
            
        }
        
        if([item objectForKey:@"from_date"]!=[NSNull null])
        {
            _renterContractIndividualDao.from_date=[item objectForKey:@"from_date"];
            
        }
        
        if([item objectForKey:@"to_date"]!=[NSNull null])
        {
            _renterContractIndividualDao.to_date=[item objectForKey:@"to_date"];
            
        }
        
        if([item objectForKey:@"equipment_status"]!=[NSNull null])
        {
            _renterContractIndividualDao.equipment_status=[item objectForKey:@"equipment_status"];
            
        }
        if([item objectForKey:@"plan"]!=[NSNull null])
        {
            _renterContractIndividualDao.plan=[item objectForKey:@"plan"];
            
        }
        if([item objectForKey:@"price"]!=[NSNull null])
        {
            _renterContractIndividualDao.price=[item objectForKey:@"price"];
            
        }
        if([item objectForKey:@"supplier_image"]!=[NSNull null])
        {
            _renterContractIndividualDao.supplier_image=[item objectForKey:@"supplier_image"];
            
        }
        if([item objectForKey:@"renter_image"]!=[NSNull null])
        {
            _renterContractIndividualDao.renter_image=[item objectForKey:@"renter_image"];
            
        }
        if([item objectForKey:@"equipment_image"]!=[NSNull null])
        {
            _renterContractIndividualDao.equipment_image=[item objectForKey:@"equipment_image"];
            
        }
        if([item objectForKey:@"supplier_name"]!=[NSNull null])
        {
            _renterContractIndividualDao.supplier_name=[item objectForKey:@"supplier_name"];
            
        }
        if([item objectForKey:@"renter_name"]!=[NSNull null])
        {
            _renterContractIndividualDao.renter_name=[item objectForKey:@"renter_name"];
            
        }
        
    }
}


-(void)initializeImageDownloadManager:(NSString*)imageDownloadIdentifier{
    
    @autoreleasepool {
        
        NSString *url=nil;
        //Download image of Renter
        if ([imageDownloadIdentifier isEqual:IMAGE_DOWNLOAD_REQUEST_FOR_RENTER]) {
            if([_renterContractIndividualDao.renter_image containsString:@" "])
            {
                url = [_renterContractIndividualDao.renter_image stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                
            }else{
                url=_renterContractIndividualDao.renter_image;
            }
            
        }
        
        //Download image of Supplier
        else if ([imageDownloadIdentifier isEqual:IMAGE_DOWNLOAD_REQUEST_FOR_SUPPLIER]) {
            if([_renterContractIndividualDao.supplier_image containsString:@" "])
            {
                url = [_renterContractIndividualDao.supplier_image stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                
            }else{
                url=_renterContractIndividualDao.supplier_image;
            }
            
        }
        
        //Download image of Vehicle
        else if ([imageDownloadIdentifier isEqual:IMAGE_REQUEST_FROM_INDIVIDUAL_CONTRACT]){
            if([_renterContractIndividualDao.equipment_image containsString:@" "])
            {
                url = [_renterContractIndividualDao.equipment_image stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                
            }else{
                url=_renterContractIndividualDao.equipment_image;
            }
            
        }
        
        NSURL *imageURL = [NSURL URLWithString:url];
        
        AsyncImageDownloaderModel *asyncImageDownloaderModel = [[AsyncImageDownloaderModel alloc]init];
        asyncImageDownloaderModel.imageIndex = 1;
        asyncImageDownloaderModel.imageURL =imageURL;
        asyncImageDownloaderModel.imageRequestIdentifier = imageDownloadIdentifier;
        asyncImageDownloaderModel.renterContractIndividualModel = self;
        [asyncImageDownloaderModel initialize];
        
        imageURL = nil;
        
    }
}


-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded identifier:(NSString*)imageDownloadIdentifier{
    @autoreleasepool {
        if (succeeded) {
            if ([imageDownloadIdentifier isEqual:IMAGE_DOWNLOAD_REQUEST_FOR_RENTER]) {
                //Downloaded Renter Image
                [_renterContractIndividualDao setRenterImage:image];
            }
            
            else if ([imageDownloadIdentifier isEqual:IMAGE_DOWNLOAD_REQUEST_FOR_SUPPLIER]) {
                //Downloaded Supplier Image
                [_renterContractIndividualDao setSupplierImage:image];
            }
            
            else if ([imageDownloadIdentifier isEqual:IMAGE_REQUEST_FROM_INDIVIDUAL_CONTRACT]) {
                //Downloaded Vehicle Image
                [_renterContractIndividualDao setVehicleImage:image];
            }
            
        }
        
        [self.renterSupplierIndividualContractViewController onImageDownloadResponse:imageDownloadIdentifier];
    }
    
}




@end
