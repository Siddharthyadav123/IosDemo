//
//  INetworkHandler.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/17/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef IosApplicationFrameworkProject_INetworkHandler_h
#define IosApplicationFrameworkProject_INetworkHandler_h

@protocol INetworkHandler <NSObject>

/**
 * Initializing necessary data
 */
- (void) initialize;

/**
 * To Destroy Other data.
 */
- (void)  destroy;

///**
// * To Open Connection
// */
//public HttpURLConnection openConnection() throws Exception;

/**
 * To Close Connection
 */
-(void) closeConnection;

@end

#endif
