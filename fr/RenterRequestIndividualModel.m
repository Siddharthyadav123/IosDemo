//
//  RenterRequestIndividualModel.m
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "RenterRequestIndividualModel.h"


//Renter http://alkurn.net/clients/fleetright/api/web/v1/requests/rent-requests?renter_id=51&request_id=14

@implementation RenterRequestIndividualModel
-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self executeTask];
}

-(void)onPreTaskExecute{
 
    //If login person is RENTER then hit as per Renter Request URL.
    NSString*  parameter = [NSString stringWithFormat:@"&request_id=%ld",(long)_renterRequestListDao.request_id];
    NSString *url = [URL_GET_RENTAL_REQUEST_LIST stringByAppendingString:parameter];
    [httpRequestHandlerImpl setServiceURL:url];
    [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_GET_RENTAL_REQUEST_Individual %@", url);
    
}



/*
 * Method to initializes instances
 */
-(void)initializeInstances{
    _renterRequestIndividualDao = [[RenterRequestIndividualDao alloc]init];
    
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
        self.errorCode = SUCCESS_CODE;
        
    }else{
        self.errorMessage=@"Error in parsing";
    }
    
    NSLog(@"error message :  %@",self.errorMessage);
}

/*
 Renter
 "equipment_id" = 48;
 "equipment_name" = Ducati;
 "from_date" = "01 Jul,16";
 "to_date" = "30 Jul,16";
 "job_location" = Nagpur;
 province = india;
 "request_for" = "Rent Request";
 "request_id" = 16;
 "request_name" = "Mye  New Request";
 status = "";
 
 
 */


-(void)
parseEquipmentDetailResponse:(NSDictionary*)item{
    
    @autoreleasepool {
        
        if([item objectForKey:@"equipment_id"]!=[NSNull null])
        {
            _renterRequestIndividualDao.equipment_id=[[item objectForKey:@"equipment_id"] integerValue];
        }
        
        if([item objectForKey:@"equipment_name"]!=[NSNull null])
        {
            _renterRequestIndividualDao.equipment_name=[item objectForKey:@"equipment_name"];
            
        }
        if([item objectForKey:@"from_date"]!=[NSNull null])
        {
            _renterRequestIndividualDao.from_date=[item objectForKey:@"from_date"];
            
        }
        if([item objectForKey:@"to_date"]!=[NSNull null])
        {
            _renterRequestIndividualDao.to_date=[item objectForKey:@"to_date"];
            
        }
        if([item objectForKey:@"province"]!=[NSNull null])
        {
            _renterRequestIndividualDao.province=[item objectForKey:@"province"];
            
        }
        if([item objectForKey:@"job_location"]!=[NSNull null])
        {
            _renterRequestIndividualDao.job_location=[item objectForKey:@"job_location"];
            
        }
        
        if([item objectForKey:@"request_for"]!=[NSNull null])
        {
            _renterRequestIndividualDao.request_for=[item objectForKey:@"request_for"];
            
        }
        if([item objectForKey:@"request_id"]!=[NSNull null])
        {
            _renterRequestIndividualDao.request_id=[[item objectForKey:@"request_id"]integerValue];
            
        }
        
        if([item objectForKey:@"request_name"]!=[NSNull null])
        {
            _renterRequestIndividualDao.request_name=[item objectForKey:@"request_name"];
            
        }
        
        if([item objectForKey:@"status"]!=[NSNull null])
        {
            _renterRequestIndividualDao.status=[item objectForKey:@"status"];
            
        }
        
    }
}




@end
