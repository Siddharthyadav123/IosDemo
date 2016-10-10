//
//  LoginDo.h
//  FleetRight
//
//  Created by test on 16/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 * Dao to store Login data
 */
@interface LoginDo : NSObject

/*
 * Variable to store username text value
 */
@property (nonatomic,retain) NSString* userNameText;

/*
 * Variable to store password text value
 */
@property (nonatomic,retain) NSString* passwordText;
@end
