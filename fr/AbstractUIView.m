//
//  AbstractUIView.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/14/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "AbstractUIView.h"

@implementation AbstractUIView


-(id) init{
    self = [super init];
    if (self) {
        //default screen id.
        screenId = -99;
    }
    return self;
}

-(NSInteger) getScreenId{
    return screenId;
}

-(void) setScreenId:(int)screenId{
    self->screenId = screenId;
}
/**
 * To initialize the Views or Screens, Models
 *
 */
-(void) initialize
{
    
}


/**
 * To reinitialize the View or Screen. This is for some cases when user
 * implement freeResource to optimize memory issue.
 */


-(void) reInitialize{
    
}

/**
 * To free only View releated stuff.
 *
 */
-(void) freeResources
{
    
}

/**
 * Destroy View and Model Data for the given Screen.
 *
 */
-(void) destory
{
    
}

/**
 * This function get called whenever AbstractView redisplay on device screen
 *
 */

-(void) enable
{
    
}


/**
 * This function get called whenever AbstractView overlapped by another
 * AbstractView
 */

-(void) disbale
{
    
}



/**
 * To notify the AbstarctView, that there is an interruption. So
 * AbstractView can handle all the required condition before going
 * application in background.
 *
 */

-(void) showNotify{
    
}

/**
 * To notify the AbstractView that application will be visible on the screen
 * after calling this method.
 */

-(void) hideNotify
{
    
}

/**
 * To update a view
 */

-(void) update
{
    
}


@end
