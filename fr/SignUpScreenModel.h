//
//  SignUpScreenModel.h
//  FleetRight
//
//  Created by test on 16/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseModel.h"
#import "AppConstants.h"
#import "SignUpDo.h"
#import "LocalModel.h"
#import "ApplicationController.h"
#import "SignUpDo.h"

@interface SignUpScreenModel : BaseModel
{
    LocalModel *localModel;
   
}

@property(strong,nonatomic) SignUpDo *signUpDo;
@end
