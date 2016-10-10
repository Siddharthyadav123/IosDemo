//
//  SignInScreenModel.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/17/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "SignInScreenModel.h"
#import "Utils.h"

@implementation SignInScreenModel
@synthesize username,password;

-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self executeTask];
}

-(void)onPreTaskExecute{
    
    NSString *signInUrl = [URL_POST_LOGIN stringByAppendingString:@""];
    [httpRequestHandlerImpl setServiceURL:signInUrl];
    [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_POST];
    NSLog(@"URL_CHECK_SIGN_IN %@", signInUrl);
    
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
    //    NSData *jsonData = [self createJsonData];
    
    NSString *post =[NSString stringWithFormat:@"username=%@&password=%@",self.loginDo.userNameText,self.loginDo.passwordText];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
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
 * Method to parse error message
 
 
 Success
 {
 password = "$2y$13$.tZR0yhmCAFKH7NGoZSSg.AI/uC0.RY./KVZBgGseaDN/.IcdfOpa";
 role = Renter;
 "session_email" = "manthan112233@gmail.com";
 "session_id" = 77;
 "session_username" = manthan;
 }
 
 Failure
 jsonData: {
 password = "";
 "session_email" = "";
 "session_id" = 0;
 "session_username" = "Incorect Username";
 }
 */
-(void)parseLoginDao :(NSDictionary*)jsonResponse{
    
    password=[jsonResponse valueForKey:@"password"];
    _session_username=[jsonResponse valueForKey:@"session_username"];
    _session_email=[jsonResponse valueForKey:@"session_email"];
    _session_id=[[jsonResponse valueForKey:@"session_id"]intValue];
    _role=[jsonResponse valueForKey:@"role"];
    
    if(_session_id != 0)
    {
        self.errorCode = -1;
        
    }else{
        if (password!=nil && ![password isEqualToString:@""]) {
            self.errorMessage = [jsonResponse valueForKey:@"password"];
        }
        else if (_session_username!=nil && ![_session_username isEqualToString:@""]){
            self.errorMessage = [jsonResponse valueForKey:@"session_username"];
        }
    }
}




/*
 * Forms the auth token & returns it.
 */
-(NSString*) getAuthToken{
    NSString *authString = @"";
    authString = [authString stringByAppendingFormat:@"%@:%@",username,password];
    NSString *base64AuthValue = [Utils toBase64String:authString];
    NSString *authValue = [@"Basic " stringByAppendingString:base64AuthValue];
    return  authValue;
}

@end

