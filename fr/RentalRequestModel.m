//
//  RentalRequestModel.m
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "RentalRequestModel.h"
#import "RentalRequestDao.h"
#import "LocalModel.h"

@implementation RentalRequestModel
-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self getDataFromPreferences];
    [self executeTask];
}

-(void)onPreTaskExecute{
    
    NSString *signInUrl = [URL_POST_RENTAL_REQUEST stringByAppendingString:@""];
    [httpRequestHandlerImpl setServiceURL:signInUrl];
    [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_POST];
    NSLog(@"URL_POST_RENTAL_REQUEST %@", signInUrl);
    
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
     "name: varchar (Manadatory),
     email: varchar (Manadatory),
     contact_no: varchar (Manadatory),
     job_location: varchar (Manadatory),
     province: varchar (Manadatory),
     rent: varchar (Manadatory),
     from_date: Date (Manadatory),
     to_date: Date (Manadatory),
     comment: varchar (Optional),
     equipment_id: integer (Manadatory),
     session_id: integerManadatory),
     "
     */
    
    NSString *post =[NSString stringWithFormat:@"name=%@&email=%@&contact_no=%@&job_location=%@&province=%@&rent=%@&from_date=%@&to_date=%@&comment=%@&equipment_id=%d&session_id=%d",self.rentalRequestDao.name,self.rentalRequestDao.emailAddress,self.rentalRequestDao.contactNumber,self.rentalRequestDao.jobLocation,self.rentalRequestDao.province,self.rentalRequestDao.rentDay,self.rentalRequestDao.fromDate,self.rentalRequestDao.toDate,self.rentalRequestDao.comment,_equipment_id,session_id];
    NSLog(@"Renter Request Post Data %@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [httpRequestHandlerImpl setHeaders:@"Content-Length" value:postLength];
    
    [httpRequestHandlerImpl execute:postData];
    
}

/*
 * Method to get data from preferences
 */
-(void)getDataFromPreferences{
    userDefaultPreferences =  [UserDefaultPreferences getInstance];
    NSString *prefSessionIdKey = PREF_KEY_SESSION_ID;
    session_id = [[userDefaultPreferences getString:prefSessionIdKey]integerValue];
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
 data = "User not found";
 success = 0;
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



@end
