//
//  RenterRequestListModel.m
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "RenterRequestListModel.h"

@implementation RenterRequestListModel
-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self getDataFromPreferences];
    [self executeTask];
}

-(void)onPreTaskExecute{
    NSString *url;
    //If login person is SUPPLIER then hit as per Supplier Request URL.
    if ([loginType isEqual:LOGIN_TYPE_SUPPLIER]) {
        url = [URL_GET_SUPPLIER_REQUEST_LIST stringByAppendingString:@""];
    }
    else{
        
        //If login person is RENTER then hit as per Renter Request URL.
        url = [URL_GET_RENTAL_REQUEST_LIST stringByAppendingString:@""];
    }
    [httpRequestHandlerImpl setServiceURL:url];
    [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_GET_RENTAL_REQUEST_LIST %@", url);
    
}

/*
 * Method to initializes instances
 */
-(void)initializeInstances{
    userDefaultPreferences = [UserDefaultPreferences getInstance];
    
}

/*
 * Method to get data from preferences
 */
-(void)getDataFromPreferences{
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
            self.renterListArray= [[NSMutableArray alloc]init];
            
            for(int i=0;i<[jsonResponse count];i++)
            {
                NSDictionary *item = [jsonResponse objectAtIndex:i];
                
                RenterRequestListDao *renterRequestListDao=[self parseRenterRequestList:item];
                
                [self.renterListArray addObject:renterRequestListDao];
                
            }
            
            self.errorCode = SUCCESS_CODE;
            
        }else{
            self.errorMessage=@"Error in parsing";
        }
        
        NSLog(@"error message :  %@",self.errorMessage);
        
    }
}


/*
 //Renter
 "equipment_id" = 58;
 "equipment_name" = Datalist;
 province = India;
 "from_date" = "01 Jul,16";
 "job_location" = Nagpur;
 status = Declined;
 "to_date" = "01 Jul,16";
 "request_for" = "Rent Request";
 "request_id" = 14;
 "request_name" = "New Request";
 
 //Supplier
 "equipment_id": 100
 "equipment_name": "White Ducati"
 "province": ""
 "job_location": ""
 "from_date": "15 Jul,16"
 "to_date": "15 Jul,16"
 "status": "Accepted"
 "request_id": 10
 "request_name": "Req"
 "request_for": "Sale Request"
 
 "plan": "Sale"
 "sale_or_rent_amt": "0"
 
 */


/**
 * Parsing Equipment
 **/
-(RenterRequestListDao*) parseRenterRequestList:(NSDictionary*) item
{
    @autoreleasepool {
        
        RenterRequestListDao *renterRequestListDao=[[RenterRequestListDao alloc]init];
        
        if([item objectForKey:@"request_id"]!=[NSNull null])
        {
            renterRequestListDao.request_id=[[item objectForKey:@"request_id"] integerValue];
        }
        
        if([item objectForKey:@"equipment_id"]!=[NSNull null])
        {
            renterRequestListDao.equipment_id=[[item objectForKey:@"equipment_id"] integerValue];
        }
        
        
        if([item objectForKey:@"equipment_name"]!=[NSNull null])
        {
            renterRequestListDao.equipment_name=[item objectForKey:@"equipment_name"];
            
        }
        
        if([item objectForKey:@"province"]!=[NSNull null])
        {
            renterRequestListDao.province=[item objectForKey:@"province"];
            
        }
        
        if([item objectForKey:@"job_location"]!=[NSNull null])
        {
            renterRequestListDao.job_location=[item objectForKey:@"job_location"];
            
        }
        
        if([item objectForKey:@"from_date"]!=[NSNull null])
        {
            renterRequestListDao.from_date=[item objectForKey:@"from_date"];
            
        }
        
        if([item objectForKey:@"to_date"]!=[NSNull null])
        {
            renterRequestListDao.to_date=[item objectForKey:@"to_date"];
            
        }
        
        if([item objectForKey:@"status"]!=[NSNull null])
        {
            renterRequestListDao.status=[item objectForKey:@"status"];
            
        }
        if([item objectForKey:@"request_for"]!=[NSNull null])
        {
            renterRequestListDao.request_for=[item objectForKey:@"request_for"];
            
        }
        if([item objectForKey:@"request_name"]!=[NSNull null])
        {
            renterRequestListDao.request_name=[item objectForKey:@"request_name"];
            
        }
        if([item objectForKey:@"plan"]!=[NSNull null])
        {
            renterRequestListDao.plan=[item objectForKey:@"plan"];
            
        }
        if([item objectForKey:@"sale_or_rent_amt"]!=[NSNull null])
        {
            renterRequestListDao.sale_or_rent_amt=[item objectForKey:@"sale_or_rent_amt"];
            
        }
        
        return renterRequestListDao;
        
    }
}



@end
