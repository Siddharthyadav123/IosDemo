//
//  AbstractViewController.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 3/4/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef IosApplicationFrameworkProject_AbstractViewController_h
#define IosApplicationFrameworkProject_AbstractViewController_h



@protocol AbstractViewController

/*
 * Variable to hold type of view controller's.
 */
@property int viewControllerType;

/**
 * To initialize the Views or Screens, Models
 *
 */
//-(void) initialize;


/**
 * To reinitialize the View or Screen. This is for some cases when user
 * implement freeResource to optimize memory issue.
 */


//-(void) reInitialize;

/**
 * To free only View releated stuff.
 *
 */
//-(void) freeResources;

/**
 * Destroy View and Model Data for the given Screen.
 *
 */
-(void) destroy;

/**
 * This function get called whenever AbstractView redisplay on device screen
 *
 */

//-(void) enable;


/**
 * This function get called whenever AbstractView overlapped by another
 * AbstractView
 */

//-(void) disbale;



/**
 * To notify the AbstarctView, that there is an interruption. So
 * AbstractView can handle all the required condition before going
 * application in background.
 *
 */

//-(void) showNotify;

/**
 * To notify the AbstractView that application will be visible on the screen
 * after calling this method.
 */

//-(void) hideNotify;

/**
 * To update a view
 */

-(void) update;


/**
 * method calls when screen poped up from stack and dismissed from UI.
 */

-(void) onScreenPopedUp;

/*
 * Method calls when go back to previous screen due to top screen is finished
 */
-(void)onTopScreenFinished;

/*
 * Method calls when response from server comes. It override update method.
 */
-(void)update:(int)identifier;



@end



#endif
