//
//  IController.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef __ICONTROLLER_H__
#define __ICONTROLLER_H__




@protocol IController <NSObject>

/**
 * To initialize the Views or Screens, Models
 *
 */
-(void) initialize;



//-(void) reInitialize;

/**
 * Destroy View and Model Data for the given Screen.
 *
 */
-(void)  destory;

/**
 * This function get called whenever AbstractView redisplay on device screen
 *
 */

-(void) enable;


/**
 * This function get called whenever AbstractView overlapped by another
 * AbstractView
 */

-(void) disbale;



/**
 * To notify the AbstarctView, that there is an interruption. So
 * AbstractView can handle all the required condition before going
 * application in background.
 *
 */

-(void) showNotify;

/**
 * To notify the AbstractView that application will be visible on the screen
 * after calling this method.
 */

-(void) hideNotify;
@end



#endif