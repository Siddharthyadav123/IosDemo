//
//  BaseModel.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/17/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "BaseModel.h"


@implementation BaseModel

/**
 * Initializing Model Data
 */

-(void) initialize{
    
    [super initialize];
    _responseData = [[NSMutableData alloc]init];
    isTaskFinished = NO;
    httpRequestHandlerImpl = [HttpRequestHandlerImpl alloc];
    httpRequestHandlerImpl.connectionDelegate = self;
    [httpRequestHandlerImpl initialize];
    //here initializes the thread
    executionThread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    
}


-(void) executeTask{
    
    //first method is to call onPreExecute.
    [self onPreTaskExecute];
    //start thread
    [executionThread start];
}

- (void) run{
    NSLog(@"run Method");
    //here calls the callback method so that the execution of the server communication functionality can be done from thread.
    [self doInBackGround];
    while(!self->isTaskFinished){
        //This line below is the magic!
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //...
    if(response!=nil){
        self.errorCode = [((NSHTTPURLResponse*)response) statusCode];
        self.errorMessage = [NSHTTPURLResponse localizedStringForStatusCode:self.errorCode];
    }
    //NSLog(@"didReceiveResponse %@",response);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //...
    // NSLog(@"didReceiveData %@",data);
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
   // NSLog(@"Response in string %@",string);
    // Append the new data to receivedData.
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //...
    NSLog(@"didFailWithError %@",error);
    //    NSData* data = [@"Error" dataUsingEncoding:NSUTF8StringEncoding];
    self.errorCode = [error code];
    NSLog(@"Did fail with error code %ld",(long)self.errorCode);
    self.errorMessage = [error localizedDescription];
    [self runOnUIThread:(^{[self onResponse:nil];})];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //...
    //NSLog(@"didReceiveData %@",_responseData);
    NSString *string = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
  //  NSLog(@"Response in string %@",string);
    [self runOnUIThread:(^{[self onResponse:_responseData];})];
    // NSLog(@"connectionDidFinishLoading");
    self->isTaskFinished = YES;
}

/*
 *Executes the provided block in UI i.e. Main method.
 */
-(void)runOnUIThread:(void(^)(void))block{
    dispatch_async(dispatch_get_main_queue(), block);
}



//////////
/**
 * To Destroy Model data.
 */
-(void) destory{
    [super destory];
    
}


/**
 * To Register AbstaractView with model
 */
- (void) registerview:(id <AbstractViewController>)view{
    [super registerview:view];
    
}

/**
 * To UnRegister a AbstractView
 */
-(void) unregisterview:(id <AbstractViewController>) view{
    [super unregisterview:view];
    
}



@end
