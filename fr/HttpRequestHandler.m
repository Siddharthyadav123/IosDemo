//
//  HttpRequestHandler.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/17/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "HttpRequestHandler.h"
#import <UIKit/UIKit.h>

@implementation HttpRequestHandler


/**
 * Constant for communicating with server with standard HTTP GET Method
 */

NSString* const HTTP_GET = @"GET";

/**
 * Constant for communicating with server with standard HTTP POST Method
 */
NSString* const HTTP_POST= @"POST";

/**
 * Constant for communicating with server with standard HTTP DELETE Method
 */


NSString* const HTTP_DELETE= @"DELETE";

/**
 * Constant for communicating with server with standard HTTP PUT Method
 */


NSString* const HTTP_PUT= @"PUT";

/**
 * Possible MAX Redirection
 */
NSInteger* const MAX_REDIERCTION = 2;

/**
 * Request Count to handle request if any error occur for connection
 */
//protected int requestCount = 0;

/**
 * Max Request Count, If there is an error to communicate with server this
 * class will retry the connection till MAX_REQUEST
 */
NSInteger* const MAX_REQUEST = 5;
/**
 * Maximum buffer size for reading data in one chunk
 */
NSInteger* const MAX_BUFFER = 1024 * 16;// in KB

// Below added by Gaurav

/**
 * maximum time should be taken to connect to the server
 */
double const CONNECTION_TIMEOUT = 40.0; // 10 sec

/**
 * maximum time should be taken to read from server
 */

double const READ_TIMEOUT = 20000; // 20 sec


-(void)setMethodType:(NSString*) type {
    self->methodType = type;
}

-(NSString*)getMethodType {
    return self->methodType;
}

/**
 * To set headers parameter before creating connection
 *
 * @param key
 *            To set key for header
 * @param value
 *            To set value for given key in header
 */
-(void)setHeaders:(NSString*)key value:(NSString*)value {
    if(setHeaders!=nil){
        [setHeaders setValue:value forKey:key];
    }
}

/**
 * To set headers parameter before creating connection
 *
 * @param key
 *            To set key for header
 * @param value
 *            To set value for given key in header
 */
-(void)addHeader:(NSString*)key value:(NSString*)value {
    if(addHeaders!=nil){
        [addHeaders setValue:value forKey:key];
    }
}

-(NSMutableDictionary*) getHeaders{
    return self->setHeaders;
}

/**
 * Cancel Server Communication Request
 */
-(void)cancelRequest {
    self-> cancelRequest = NO;
    [self closeConnection];
}

/**
 * Server url to request
 *
 * @param url
 */
-(void) setServiceURL:(NSString*) url {
    serviceURL = url;
}


/**
 * Initializing necessary data
 */
- (void) initialize{
    
    setHeaders = [[NSMutableDictionary alloc]init];
    addHeaders = [[NSMutableDictionary alloc]init];
    
}


/**
 * Execute the request with data body and returns the response.
 */
-(void) execute:(NSData*)requestData{
    request = [self openConnection];
    
    [request setHTTPBody:requestData];
    
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:_connectionDelegate];
    NSLog(@"Connection: %@",connection);
    
}


/**
 * Execute the request without data body and returns the response.
 */
-(void)execute{
    request = [self openConnection];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:_connectionDelegate];
    
}

/**
 * To Destroy Other data.
 */
- (void)  destroy{
    if(setHeaders!=nil){
        [setHeaders removeAllObjects];
        setHeaders = nil;
    }
    if(addHeaders!=nil){
        [addHeaders removeAllObjects];
        addHeaders = nil;
    }
    serviceURL = nil;
    methodType = nil;
    requestCount = nil;
    request = nil;
    httpUrlResponse = nil;
    serverError = nil;
    result = nil;
    
}

/**
 * To Open Connection and create the request by setting the url and headers.
 */
-(NSMutableURLRequest*)openConnection{
    NSURL *url = [NSURL URLWithString:serviceURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:methodType];
    //sets the headers here.
    [self setHeadersTorequest:request];
    request.timeoutInterval = CONNECTION_TIMEOUT;
    return request;
    
}

/*
 * Here, sets & adds the headers tot the request if any.
 */
-(void)setHeadersTorequest:(NSMutableURLRequest*) request{
    //first check for setting set headers.
    if(setHeaders!=nil){
        NSArray *headesrsKeys = [setHeaders allKeys];
        if(headesrsKeys!=nil){
            for (NSString *key in headesrsKeys) {
                NSLog(@"set Header>> Key : %@, Value: %@",key,[setHeaders objectForKey:key]);
                [request setValue:[setHeaders objectForKey:key] forHTTPHeaderField:key];
                //            NSLog(@"From Headers: %@",[request ])
            }
        }
    }
    
    //then if any headers those need to be added to the request,
    if(addHeaders!=nil){
        NSArray *headesrsKeys = [addHeaders allKeys];
        if(headesrsKeys!=nil){
            for (NSString *key in headesrsKeys) {
                NSLog(@"add Header>> Key : %@, Value: %@",key,[addHeaders objectForKey:key]);
                [request addValue:[addHeaders objectForKey:key] forHTTPHeaderField:key];
                //            NSLog(@"From Headers: %@",[request ])
            }
        }
    }
}
/**
 * To Close Connection
 */
-(void) closeConnection{
    
}

@end
