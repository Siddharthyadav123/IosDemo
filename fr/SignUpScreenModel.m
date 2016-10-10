//
//  SignUpScreenModel.m
//  FleetRight
//
//  Created by test on 16/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "SignUpScreenModel.h"


@implementation SignUpScreenModel
-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self executeTask];
}

-(void)onPreTaskExecute{
  
    NSString *signInUrl = [URL_POST_REGISTRATION stringByAppendingString:@""];
    [httpRequestHandlerImpl setServiceURL:signInUrl];
      [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_POST];
    NSLog(@"URL_CHECK_SIGN_UP %@", signInUrl);
    
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

        [self parseSignUpDao:jsonData];
        
    }
}


/*
 * Method to post data in server
 */
-(void)requestData{
    NSString *post =[NSString stringWithFormat:@"username=%@&email=%@&password=%@&password_repeat=%@&contact_no=%@",self.signUpDo.userNameString,self.signUpDo.emailString,self.signUpDo.passwordString,self.signUpDo.conformPasswordString,self.signUpDo.contactNumberString];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    [httpRequestHandlerImpl setHeaders:@"Content-Length" value:postLength];
    
    [httpRequestHandlerImpl execute:postData];
    
}

/*Response
data = "You are registered successfully.Please check your mail to verify your mail.";
success = 1;*/

/*fAILURE
data = "Please Fill The Form Properly. Something Wrong Happened.";
success = 0;*/

/*
 * Method to parse response data
 */
-(void)parseSignUpDao : (NSDictionary*)jsonSignUpDictionary{


    NSLog(@"%@",[jsonSignUpDictionary valueForKey:@"success"]);
    @try {
        if([jsonSignUpDictionary valueForKey:@"success"]!=[NSNull null])
        {
            NSInteger *success=[[jsonSignUpDictionary valueForKey:@"success"]integerValue];
            
            if(success==1)
            {
                self.errorCode = -1;
                self.errorMessage = [jsonSignUpDictionary valueForKey:@"data"];
                
            }else{
                self.errorMessage = [jsonSignUpDictionary valueForKey:@"data"];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
  


}


@end
