//
//  VKJSONParser.h
//  DynamicParsingProject
//
//  Created by Ranjit singh on 5/24/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface VKJSONParser : NSObject

-(NSObject*)parseJSONData:(NSString*)className dictionary:(NSDictionary*)JsonDictionary;
-(NSDictionary*)getClassMembers:(id)classObject;

@end
