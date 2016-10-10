//
//  HttpRequestHandler.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/17/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "INetworkHandler.h"
/**
 * Constant for communicating with server with standard HTTP GET Method
 */

extern NSString* const HTTP_GET;

/**
 * Constant for communicating with server with standard HTTP POST Method
 */
extern NSString* const HTTP_POST;

/**
 * Constant for communicating with server with standard HTTP DELETE Method
 */


extern NSString* const HTTP_DELETE;

/**
 * Constant for communicating with server with standard HTTP PUT Method
 */


extern NSString* const HTTP_PUT;


/**
 * Possible MAX Redirection
 */

extern NSInteger* const MAX_REDIRECTION;

/**
 * Max Request Count, If there is an error to communicate with server this
 * class will retry the connection till MAX_REQUEST
 */
extern NSInteger* const MAX_REQUEST;

/**
 * Maximum buffer size for reading data in one chunk
 */
extern NSInteger* const MAX_BUFFER;


// Below added by Gaurav

/**
 * maximum time should be taken to connect to the server
 */

extern double const CONNECTION_TIMEOUT;

/**
 * maximum time should be taken to read from server
 */

extern double const READ_TIMEOUT;

@interface HttpRequestHandler : NSObject<INetworkHandler>
{
    /**
     * Dictionary to set headers parameters in request.
     */
    NSMutableDictionary *setHeaders;
    /**
     * Dictionary to add headers parameters in request
     */
    NSMutableDictionary *addHeaders;
    //protected Hashtable<Object, Object> hashtable = new Hashtable<Object, Object>();
    
    /**
     * The URL to connect to the server
     */
    NSString *serviceURL;
    
    /**
     * Method type to establish HTTP Connection Default is GET Method
     */
    NSString *methodType;
    
    /**
     * Request Count to handle request if any error occur for connection
     */
    NSInteger *requestCount;
    /**
     * Cancel Request Variable to handle connection cancellation
     */
    bool cancelRequest;
    /*
     * Request body to be provided for requesting server.
     */
    NSMutableURLRequest *request;
    
    /*
     * HTTPURL Response comes from the server.
     */
    NSHTTPURLResponse *httpUrlResponse;
    /*
     * Error if any comes from server side.
     */
    NSError *serverError;
    /*
     * Response data comes from server.
     *
     */
    NSData *result;
    
    
}
@property(nonatomic,strong)NSString *methodType;

/*
 * Connection Delegete to receive server response.
 */
@property(nonatomic,strong)id connectionDelegate;

-(void)setMethodType:(NSString*) type;
-(NSString*)getMethodType;
-(void)setHeaders:(NSString*)key value:(NSString*)value;
/**
 * To set headers parameter before creating connection
 *
 * @param key
 *            To set key for header
 * @param value
 *            To set value for given key in header
 */
-(void)addHeader:(NSString*)key value:(NSString*)value;
-(NSHashTable*)getHeaders;
/**
 * Execute the request and returns the response.
 */
-(void) execute:(NSData*)requestData;
/**
 * Execute the request and returns the response.
 */
-(void)execute;
-(void) setServiceURL:(NSString*) url;
-(void)cancelRequest;

@end
