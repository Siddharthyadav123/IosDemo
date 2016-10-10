//
//  BaseModel.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/17/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "Model.h"
#import "ITaskListener.h"
#import "HttpRequestHandlerImpl.h"


@interface BaseModel : Model<ITaskListener,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    /*
     * The HttpHandlerImpl instance to perform server related operation.
     */
    HttpRequestHandlerImpl *httpRequestHandlerImpl;
    
    /*
     * Request Data to be send with request.
     */
    NSData *requestData;
    
    /*
     * Maintains the execution thread.
     */
    NSThread *executionThread;
    
    /*
     * Is thread execution task is finished or not.
     */
    bool isTaskFinished;
    
   
    
}

/*
 * Respose that comes from server.
 */

@property NSMutableData *responseData;


/*
 * The methos to be called from the Thread.
 */
- (void) run;

/*
 * Starts the executing task to run execution from thread.
 */
-(void) executeTask;


/*
 * sets the error code here.
 */
@property NSInteger errorCode;

/*
 * Maintains the error message here.
 */
@property(nonatomic,strong) NSString *errorMessage;
-(void)runOnUIThread:(void(^)(void))block;

@end
