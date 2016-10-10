//
//  Controller.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef __CONTROLLER_H__
#define __CONTROLLER_H__



#import <Foundation/Foundation.h>
#import "IController.h"


@interface Controller : NSObject<IController>


-(void) handleEvent:(int)eventid;

-(void) handleEvents:(int) eventId AndEventJoin:(NSObject *) eventObject;


@end

#endif