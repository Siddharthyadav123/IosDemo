//
//  HttpRequestHandlerImpl.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/17/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "HttpRequestHandlerImpl.h"

@implementation HttpRequestHandlerImpl

/**
 * Execute the request with data body and returns the response.
 */
-(void) execute:(NSData*)requestData{
    [super execute:requestData];
}
-(void)initialize{
    [super initialize];
}
/**
 * Execute the request without data body.
 */
-(void) execute{
    [super execute];
}

//-(NSString*) getHttpHeaders{
//    NSString* headerString = nil;
//    if(headers!=nil){
//        //    headerString =  [[NSString alloc] initWithData:headers
//        //                                             encoding:NSUTF8StringEncoding];
//    }
//    return headerString;
//}
@end
