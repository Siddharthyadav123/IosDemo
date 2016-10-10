//
//  UserDefaultPreferences.m
//  UserDefaultSampleProject
//
//  Created by Ranjit singh on 8/31/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "UserDefaultPreferences.h"

@implementation UserDefaultPreferences

+(UserDefaultPreferences *)getInstance
{
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    //static id sharedObject = nil;  //if you're not using ARC
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
        //sharedObject = [[[self alloc] init] retain]; // if you're not using ARC
    });
    return sharedObject;
}



/**
 * Constructor of ApplicationController
 */
- (id)init
{
    self = [super init];
    if (self) {
      _preferences   = [NSUserDefaults standardUserDefaults];
        NSLog(@"modelfacade Object Created");
    }
    return self;
}

/*
 * Save data in form of string
 */
-(void) saveString:(NSString*) key stringValue:(NSString*)value{
    [_preferences setObject:value forKey:key];
    BOOL didSave = [_preferences synchronize];
//    NSLog(@"Did save data: %@",didSave);
}

/*
 * Save data in form of NSdata
 */
-(void) saveNSData:(NSString*) key stringValue:(NSData*)value{
    [_preferences setObject:value forKey:key];
    BOOL didSave = [_preferences synchronize];
//    NSLog(@"Did save data: %@",didSave);
}

/*
 * Get data in form of NSString
 */
-(NSData*) getNSData:(NSString*) key{
    id value =  [_preferences objectForKey:key];
    NSLog(@"Get saved data: %@",value);
    if(value!=nil){
        return (NSData*)value;
    }
    return nil;
}

/*
 * Get data in form of string
 */
-(NSString*) getString:(NSString*) key{
   id value =  [_preferences objectForKey:key];
    NSLog(@"Get saved data: %@",value);
    if(value!=nil){
        return (NSString*)value;
    }
    return nil;
}

/*
 * Save data in form of boolean
 */
-(void)setBool:(BOOL)value forKey:(NSString*) key{
    [_preferences setBool:value forKey:key];
    BOOL didSave = [_preferences synchronize];
}

/*
 * Get data in form of boolean
 */
-(BOOL) getBooleanData:(NSString*) key{
    BOOL value =  [_preferences boolForKey:key];
    return value;
}
@end
