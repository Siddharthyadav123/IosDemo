//
//  SupplierRequestIndividualModel.m
//  FleetRight
//
//  Created by test on 20/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//
//Supplier http://alkurn.net/clients/fleetright/api/web/v1/requests/supplier-requests?supplier_id=46&equipment_id=48

#import "SupplierRequestIndividualModel.h"

@implementation SupplierRequestIndividualModel
-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self executeTask];
}

-(void)onPreTaskExecute{
    
    //If login person is SUPPLIER then hit as per Supplier Request URL.
    
    NSString* parameter = [NSString stringWithFormat:@"&equipment_id=%ld",(long)_renterRequestListDao.equipment_id];
    NSString *url = [URL_GET_SUPPLIER_REQUEST_LIST stringByAppendingString:parameter];
    [httpRequestHandlerImpl setServiceURL:url];
    [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_GET_RENTAL_REQUEST_Individual %@", url);
    
}



/*
 * Method to initializes instances
 */
-(void)initializeInstances{
    
    
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
            self.supplierRequestIndivListArray= [[NSMutableArray alloc]init];
            
            for(int i=0;i<[jsonResponse count];i++)
            {
                NSDictionary *item = [jsonResponse objectAtIndex:i];
                
                RenterRequestIndividualDao *renterRequestIndividualDao=[self parseSupplierIndividualResponse:item];
                
                [self.supplierRequestIndivListArray addObject:renterRequestIndividualDao];
                
            }
            
            self.errorCode = SUCCESS_CODE;
            
        }else{
            self.errorMessage=@"Error in parsing";
        }
        
        NSLog(@"error message :  %@",self.errorMessage);
        
    }
}


/*
 
 Supplier
 "equipment_id" = 100;
 "equipment_name" = "White Ducati";
 "from_date" = "01 Jul,16";
 "to_date" = "01 Jul,16";
 "job_location" = Nagpur;
 province = india;
 "request_for" = "Rent Request";
 "request_id" = 11;
 "request_name" = "Request 1";
 status = Accepted;
 
 plan = Monthly;
 "sale_or_rent_amt" = 0;
 
 
 
 */


-(RenterRequestIndividualDao*)parseSupplierIndividualResponse:(NSDictionary*)item{
    
    @autoreleasepool {
        
        RenterRequestIndividualDao *renterRequestIndividualDao=[[RenterRequestIndividualDao alloc]init];
        
        
        if([item objectForKey:@"equipment_id"]!=[NSNull null])
        {
            renterRequestIndividualDao.equipment_id=[[item objectForKey:@"equipment_id"] integerValue];
        }
        
        if([item objectForKey:@"equipment_name"]!=[NSNull null])
        {
            renterRequestIndividualDao.equipment_name=[item objectForKey:@"equipment_name"];
            
        }
        if([item objectForKey:@"from_date"]!=[NSNull null])
        {
            renterRequestIndividualDao.from_date=[item objectForKey:@"from_date"];
            
        }
        if([item objectForKey:@"to_date"]!=[NSNull null])
        {
            renterRequestIndividualDao.to_date=[item objectForKey:@"to_date"];
            
        }
        if([item objectForKey:@"province"]!=[NSNull null])
        {
            renterRequestIndividualDao.province=[item objectForKey:@"province"];
            
        }
        if([item objectForKey:@"job_location"]!=[NSNull null])
        {
            renterRequestIndividualDao.job_location=[item objectForKey:@"job_location"];
            
        }
        
        if([item objectForKey:@"request_for"]!=[NSNull null])
        {
            renterRequestIndividualDao.request_for=[item objectForKey:@"request_for"];
            
        }
        if([item objectForKey:@"request_id"]!=[NSNull null])
        {
            renterRequestIndividualDao.request_id=[[item objectForKey:@"request_id"]integerValue];
            
        }
        
        if([item objectForKey:@"request_name"]!=[NSNull null])
        {
            renterRequestIndividualDao.request_name=[item objectForKey:@"request_name"];
            
        }
        
        if([item objectForKey:@"status"]!=[NSNull null])
        {
            renterRequestIndividualDao.status=[item objectForKey:@"status"];
            
        }
        if([item objectForKey:@"plan"]!=[NSNull null])
        {
            renterRequestIndividualDao.plan=[item objectForKey:@"plan"];
            
        }
        if([item objectForKey:@"sale_or_rent_amt"]!=[NSNull null])
        {
            renterRequestIndividualDao.sale_or_rent_amt=[item objectForKey:@"sale_or_rent_amt"];
            
        }
        return renterRequestIndividualDao;
    }
    
}



@end
