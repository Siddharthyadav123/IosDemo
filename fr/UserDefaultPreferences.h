//
//  UserDefaultPreferences.h
//  UserDefaultSampleProject
//
//  Created by Ranjit singh on 8/31/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Key for login data
 */
#define PREF_KEY_LOGIN_JSON_RESPONSE @"pref_login_response_json_data";

/*
 * Key for truck data
 */
#define PREF_KEY_TRUCK_DETAILS_SAVE_JSON_RESPONSE @"pref_truck_response_json_data";

/*
 * Key for truck data
 */
#define PREF_KEY_USERNAME @"pref_username_data";

/*
 * Key for truck data
 */
#define PREF_KEY_PASSWORD   @"pref_password_data";

/*
 * Key for role data
 */
#define PREF_KEY_ROLE   @"pref_role_data";

#define PREF_KEY_EMAIL   @"pref_email_data";
#define PREF_KEY_SESSION_ID   @"pref_session_id_data";

@interface UserDefaultPreferences : NSObject


@property (nonatomic,retain) NSUserDefaults *preferences;

+(UserDefaultPreferences *)getInstance;

-(void) saveString:(NSString*) key stringValue:(NSString*)value;
-(NSString*) getString:(NSString*) key;

-(void) saveNSData:(NSString*) key stringValue:(NSData*)value;
-(NSData*) getNSData:(NSString*) key;


-(void)setBool:(BOOL)value forKey:(NSString*) key;
-(BOOL) getBooleanData:(NSString*) key;




@end
