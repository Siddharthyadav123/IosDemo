//
//  IModel.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef __IMODEL_H__
#define __IMODEL_H__



#import "AbstractView.h"

@protocol IModel <NSObject>


/**
 * Initializing Model Data
 */

-(void) initialize;

/**
 * To Destroy Model data.
 */
-(void) destory;


/**
 * To Register AbstaractView with model
 */
- (void) registerview:(NSObject<AbstractView> *)view;

/**
 * To UnRegister a AbstractView
 */
-(void) unregisterview:(NSObject<AbstractView> *) view;


/**
 * To Inform AbtractViews about any update in model
 */
-(void) informView;



@end


#endif