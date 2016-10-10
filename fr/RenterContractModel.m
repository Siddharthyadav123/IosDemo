//
//  RenterContractModel.m
//  FleetRight
//
//  Created by test on 21/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "RenterContractModel.h"

@implementation RenterContractModel
-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self getDataFromPreferences];
    [self executeTask];
}

-(void)onPreTaskExecute{
    NSString *url;
    
    //Request for rent equipment
    if ([self.CONTRACT_REQUEST_TYPE_IDENTIFIER isEqual: RENTER_CONTRACT_RENT_REQUEST ]) {
        
        //Login user is supplier.
        if ([loginType isEqual:LOGIN_TYPE_SUPPLIER]) {
            
            url = [URL_GET_SUPPLIER_CONTRACT_RENT_EQUIPMENT stringByAppendingString:@""];
        }
        else{
            //Login user is renter.
            url = [URL_GET_RENTER_CONTRACT_RENT_EQUIPMENT stringByAppendingString:@""];
        }
    }
    
    //Request for purchase equipment
    else if([self.CONTRACT_REQUEST_TYPE_IDENTIFIER isEqual: RENTER_CONTRACT_PURCHASE_REQUEST]){
        //Login user is supplier.
        if ([loginType isEqual:LOGIN_TYPE_SUPPLIER]) {
             url = [URL_GET_SUPPLIER_CONTRACT_SOLD_EQUIPMENT stringByAppendingString:@""];
        }
        else{
            //Login user is renter.
            url = [URL_GET_RENTER_CONTRACT_SOLD_EQUIPMENT stringByAppendingString:@""];
        }
    }
    
    
    [httpRequestHandlerImpl setServiceURL:url];
    [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_GET_RENTER_CONTRACT_RENT_EQUIPMENT: %@", url);
    
}

/*
 * Method to initializes instances
 */
-(void)initializeInstances{
    
    
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
    NSArray* jsonData = [NSJSONSerialization
                         JSONObjectWithData:responseData
                         options:kNilOptions
                         error:&error];
    NSLog(@"jsonData: %@", jsonData);
    
    if(jsonData!=nil){
        [self parseResponse:jsonData];
        
    }
}


-(void)parseResponse :(NSArray*)jsonResponse{
    @autoreleasepool {
        if(jsonResponse!=nil && [jsonResponse count]>0)
        {
            self.renterContractRentEquipmentArray = [[NSMutableArray alloc]init];
            
            for(int i=0;i<[jsonResponse count];i++)
            {
                NSDictionary *item = [jsonResponse objectAtIndex:i];
                
                RenterContractListDao *renterContractListDao=[self parseRenterContractList:item];
                
                [self.renterContractRentEquipmentArray addObject:renterContractListDao];
                
            }
            
            self.errorCode = SUCCESS_CODE;
            
        }else{
            self.errorMessage=@"Error in parsing";
        }
        
        NSLog(@"error message :  %@",self.errorMessage);
        
    }
}


/*
 //Rent and  //Purchase
 "contract_id": 11
 "equipment_name": "Dankker Koti"
 "request_name": "Alkurn111"
 "job_location": "Nagpur"
 "from_date": "01 Aug,16"
 "to_date": "01 Aug,16"
 "equipment_status": "Sold"
 "plan": ""
 "price": "$150"
 "supplier_image": "/home1/alkurnte/public_html/clients/fleetright/uploads/avatar/profile_user-1474117232.jpg"
 "renter_image": "/home1/alkurnte/public_html/clients/fleetright/uploads/avatar/michael-wilson-1474117162.jpg"
 "equipment_image": "http://fleetright.alkurn.net/uploads/default.jpg"
 "supplier_name": "Yogesh Dangre"
 "renter_name": "Sankalp Bhoyar"
 
 
 
 
 */


/**
 * Parsing Equipment
 **/
-(RenterContractListDao*) parseRenterContractList:(NSDictionary*) item
{
    @autoreleasepool {
        
        RenterContractListDao *renterContractListDao=[[RenterContractListDao alloc]init];
        
        if([item objectForKey:@"contract_id"]!=[NSNull null])
        {
            renterContractListDao.contract_id=[[item objectForKey:@"contract_id"] integerValue];
        }
        
        if([item objectForKey:@"equipment_name"]!=[NSNull null])
        {
            renterContractListDao.equipment_name=[item objectForKey:@"equipment_name"];
            
        }
        
        if([item objectForKey:@"request_name"]!=[NSNull null])
        {
            renterContractListDao.request_name=[item objectForKey:@"request_name"];
            
        }
        
        if([item objectForKey:@"job_location"]!=[NSNull null])
        {
            renterContractListDao.job_location=[item objectForKey:@"job_location"];
            
        }
        
        if([item objectForKey:@"from_date"]!=[NSNull null])
        {
            renterContractListDao.from_date=[item objectForKey:@"from_date"];
            
        }
        
        if([item objectForKey:@"to_date"]!=[NSNull null])
        {
            renterContractListDao.to_date=[item objectForKey:@"to_date"];
            
        }
        
        if([item objectForKey:@"equipment_status"]!=[NSNull null])
        {
            renterContractListDao.equipment_status=[item objectForKey:@"equipment_status"];
            
        }
        if([item objectForKey:@"plan"]!=[NSNull null])
        {
            renterContractListDao.plan=[item objectForKey:@"plan"];
            
        }
        if([item objectForKey:@"price"]!=[NSNull null])
        {
            renterContractListDao.price=[item objectForKey:@"price"];
            
        }
        if([item objectForKey:@"supplier_image"]!=[NSNull null])
        {
            renterContractListDao.supplier_image=[item objectForKey:@"supplier_image"];
            
        }
        if([item objectForKey:@"renter_image"]!=[NSNull null])
        {
            renterContractListDao.renter_image=[item objectForKey:@"renter_image"];
            
        }
        if([item objectForKey:@"equipment_image"]!=[NSNull null])
        {
            renterContractListDao.equipment_image=[item objectForKey:@"equipment_image"];
            
        }
        if([item objectForKey:@"supplier_name"]!=[NSNull null])
        {
            renterContractListDao.supplier_name=[item objectForKey:@"supplier_name"];
            
        }
        if([item objectForKey:@"renter_name"]!=[NSNull null])
        {
            renterContractListDao.renter_name=[item objectForKey:@"renter_name"];
            
        }
        
        return renterContractListDao;
        
    }
}



@end
