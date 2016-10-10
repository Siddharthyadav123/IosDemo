//
//  SupplierRequestApprovalModel.m
//  FleetRight
//
//  Created by test on 22/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "SupplierRequestApprovalModel.h"
#import "RentalRequestListViewController.h"

@implementation SupplierRequestApprovalModel
-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self executeTask];
}

-(void)onPreTaskExecute{
    
    NSString *signInUrl = [URL_POST_SUPPLIER_REQUEST_APPROVAL stringByAppendingString:@""];
    [httpRequestHandlerImpl setServiceURL:signInUrl];
    [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_POST];
    NSLog(@"URL_POST_SUPPLIER_REQUEST_APPROVAL %@", signInUrl);
    
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
    /*
     request_id, status
     */
    
    NSString *post =[NSString stringWithFormat:@"request_id=%ld&status=%@",(long)self.renterRequestListDao.request_id,self.renterRequestListDao.status];
    NSLog(@"Post Data %@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [httpRequestHandlerImpl setHeaders:@"Content-Length" value:postLength];
    
    [httpRequestHandlerImpl execute:postData];
    
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
        [self parseLoginDao:jsonData];
    }
}

/*
 "On Success:
 {
 ""success"": 1,
 ""data"": ""Request updated successfully""
 }"
 */


-(void)parseLoginDao :(NSDictionary*)jsonResponse{
    
    NSString *data=[jsonResponse valueForKey:@"data"];
    NSInteger success =[[jsonResponse valueForKey:@"success"]integerValue];
    
    if(success == 0)
    {
        self.errorMessage = [jsonResponse valueForKey:@"data"];
    }
    else {
        self.errorCode = SUCCESS_CODE;
        self.errorMessage = [jsonResponse valueForKey:@"data"];
        
    }
}


/*
 * Override informview method to call onImageUploadDataResponse method of viewcontroller instead of update method.
 */
-(void) informView{
    
    if (abstractView !=nil) {
        for (int i=0; i<abstractView.count; i++) {
            
            RentalRequestListViewController *rentalRequestListViewController = [abstractView objectAtIndex:i];
            
            [rentalRequestListViewController onStatusApprovalResponse:self.buttonIndex];
            
            
            
        }
    }
    
}


@end
