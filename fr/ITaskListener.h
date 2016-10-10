//
//  ITaskListener.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 7/17/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef IosApplicationFrameworkProject_ITaskListener_h
#define IosApplicationFrameworkProject_ITaskListener_h

/*
 * Protocol to define callbacks to be called from different stages of the Task execution i.e. While communicating with the server for data.
 */
@protocol ITaskListener <NSObject>

/*
 * Method gets call just before the thread starts to communicate with server.
 * Some intialization process can be done, such as setting Url,headers.
 */
-(void)onPreTaskExecute;

/*
 * This method will be called from the separate thread, so do here the require functionality.
 Such as requesting the server.
 */
-(void)doInBackGround;

/*
 * The method gets call when thread completes its execution.
 */
-(void)onTaskStopExecution;

/*
 * This methods gets call on responce came from server.
 */
-(void)onResponse:(NSData *)responseData;
@end
#endif
