//
//  SignInScreenModel.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/17/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//


#import "BaseModel.h"
#import "ApplicationController.h"
#import "LoginDo.h"


@interface SignInScreenModel : BaseModel
{
    bool finished;
}

@property (strong,nonatomic)NSString *username;
@property (strong,nonatomic) NSString *password;
@property (strong,nonatomic) LoginDo *loginDo;
@property (strong,nonatomic)  NSString *session_username;
@property (strong,nonatomic) NSString * session_email;
@property  int *session_id;
@property (strong,nonatomic)  NSString *role;

-(void)parseResponseData:(NSData*)responseData;


@end
