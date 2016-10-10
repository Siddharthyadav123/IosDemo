//
//  SignUpDo.h
//  FleetRight
//
//  Created by test on 16/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 * Dao to store sign Up (Registration) data
 */
@interface SignUpDo : NSObject

/*
 * Variable to store username text value
 */
@property (nonatomic,retain) NSString* userNameString;

/*
 * Variable to store email text value
 */
@property (nonatomic,retain) NSString* emailString;

/*
 * Variable to store password text value
 */
@property (nonatomic,retain) NSString* passwordString;

/*
 * Variable to store conform Password text value
 */
@property (nonatomic,retain) NSString* conformPasswordString;

/*
 * Variable to store contact number text value
 */
@property (nonatomic,retain) NSString* contactNumberString;

@end
