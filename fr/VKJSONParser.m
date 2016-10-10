//
//  VKJSONParser.m
//  DynamicParsingProject
//
//  Created by Ranjit singh on 5/24/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "VKJSONParser.h"

@implementation VKJSONParser


/*
 *Parse the server response and set to the respective model class.
 */
-(NSObject*)parseJSONData:(NSString*)className dictionary:(NSDictionary*)JsonDictionary
{
    id classObject = [[NSClassFromString(className) alloc] init];
    
    NSMutableArray *internalClassObjectArray = [[NSMutableArray alloc]init];
    
    NSDictionary *classMembersDictionary = [self getClassMembers:classObject];
    
    NSLog(@"List of Class Members is : %@",classMembersDictionary);
    
    NSArray *jsonKeys = [JsonDictionary allKeys];
    NSArray *classMemberKeys = [classMembersDictionary allKeys];
    NSLog(@"classMemberKeyis %@",classMemberKeys);
    NSLog(@"jsonKeys: %@",jsonKeys);
    
    [self checkTypeOfData:classObject andJsonKeys:jsonKeys andclassMemberKeys:classMemberKeys andJsonDictionary:JsonDictionary andClassMemberDictionary:classMembersDictionary andInternalClassObjectArray:internalClassObjectArray];
    
    return classObject;
}

/*
 * Check the json data is dictionary formate or array formate.
 */
-(void)checkTypeOfData:(id)classObject andJsonKeys:(NSArray *)jsonKeys andclassMemberKeys:(NSArray *)classMemberKeys  andJsonDictionary:(NSDictionary*)JsonDictionary andClassMemberDictionary:(NSDictionary*)classMembersDictionary andInternalClassObjectArray:(NSMutableArray *)internalClassObjectArray{
  
    if ([jsonKeys count] != 0)
    {
        //for (int ind=0; ind < jsonKeys.count && ind < classMemberKeys.count; ind++)
        for (int ind=0; ind < jsonKeys.count; ind++)
            
        {
            NSString *key = [jsonKeys objectAtIndex:ind];
            
            NSString *classMemberKey = [classMemberKeys objectAtIndex:ind] ;
            NSLog(@"classMemberKeyis %@",classMemberKey);
            
            NSLog(@"First key is %@",key);
            NSString *value = [JsonDictionary objectForKey:key];
            NSString *classType = [classMembersDictionary objectForKey:classMemberKey];
            NSLog(@"object values %@",value);
            NSLog(@"Class Type is %@",classType);
            
            //Logic to parse internal sub dictionary.
            if([value isKindOfClass:[NSDictionary class]])
            {
                if ([key isEqualToString:classMemberKey])
                {
                    [self parseNSDictionary:classObject andKey:key andVlaue:value andClassType:classType];
                    
                }
                
            }
            else if([value isKindOfClass:[NSArray class]])
            {
                NSLog(@"Data is kind of Array");
                if ([key isEqualToString:classMemberKey])
                {
                    [self parseNSArray:classObject andKey:key andVlaue:value andClassType:classType andInternalClassObjectArray:internalClassObjectArray];
                    
                }
                
            }
            
            else{
                [classObject setValue:value forKey:key];
            }
        }
        
    }
    [self checkClassTypeNSMutableArray:classObject andclassMemberKeys:classMemberKeys andClassMemberDictionary:classMembersDictionary andInternalClassObjectArray:internalClassObjectArray];
    

}
/*
 * Parse Dictionary data.
 */
-(void)parseNSDictionary:(id)classObject andKey:(NSString *)key andVlaue:(NSString *)value andClassType:(NSString*)classType
{
    NSMutableDictionary *subDictionary = [[NSMutableDictionary alloc]init];
    [subDictionary setObject:value forKey:key];
    
    NSDictionary* internalJSONDictionary =[subDictionary objectForKey:key];
    NSLog(@"internal JSON Dictionary %@ ",internalJSONDictionary);
    
    NSObject *internalClassObject = [self parseJSONData:classType dictionary:internalJSONDictionary];
    
    //NSLog(@" SUB CLASS OBJECT IS : %@",internalClassObject);
    [classObject setValue:internalClassObject forKey:key];

}
/*
 * Parse Array Data.
 */
-(void)parseNSArray:(id)classObject andKey:(NSString *)key andVlaue:(NSString *)value andClassType:(NSString *)classType andInternalClassObjectArray:(NSMutableArray *)internalClassObjectArray
{
    NSMutableDictionary *subDictionary = [[NSMutableDictionary alloc]init];
    [subDictionary setObject:value forKey:key];
    
    NSArray *subArray=[subDictionary objectForKey:key];
    NSLog(@"Sub Dictionary is : %@ ",subArray);
    for (int i=0; i<subArray.count; i++)
    {
        NSDictionary* resultData = subArray[i];
        NSLog(@"Result Data of Array is %@",resultData);
        
        NSObject *internalClassObject = [self parseJSONData:classType dictionary:resultData];
        NSLog(@"Phone Number Object is : %@ ",internalClassObject);
        [classObject setValue:internalClassObject forKey:key];
        
        [internalClassObjectArray addObject:internalClassObject];
    }
 
}

/*
 * Check Class Type is NSMutableArray.
 */
-(void)checkClassTypeNSMutableArray:(id)classObject andclassMemberKeys:(NSArray *)classMemberKeys andClassMemberDictionary:(NSDictionary*)classMembersDictionary andInternalClassObjectArray:(NSArray*)internalClassObjectArray
{
    if ([classMemberKeys count] != 0)
    {
        for (int ind=0; ind < classMemberKeys.count; ind++)
        {
            NSString *classMemberKey = [classMemberKeys objectAtIndex:ind] ;
            NSString *classType = [classMembersDictionary objectForKey:classMemberKey];
            if([classType isEqualToString:@"NSMutableArray"])
            {
                NSLog(@"is kind of NSMutableArray %@",classType);
                [classObject setValue:internalClassObjectArray forKey:classMemberKey];
                
            }
        }
    }

    
}

/*
 * Get to know the type of member variables.
 */
-(NSDictionary*)getClassMembers:(id)classObject
{
    NSMutableDictionary *classMemberDictionary = [[NSMutableDictionary  alloc]init];
    unsigned int count;
    objc_property_t* props = class_copyPropertyList([classObject class], &count);
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = props[i];
        const char * name = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        const char * type = property_getAttributes(property);
        NSString *attr = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        NSString * typeString = [NSString stringWithUTF8String:type];
        NSArray * attributes = [typeString componentsSeparatedByString:@","];
        NSString * typeAttribute = [attributes objectAtIndex:0];
        NSString * propertyType = [typeAttribute substringFromIndex:1];
        const char * rawPropertyType = [propertyType UTF8String];
        //NSString *rawPropertyTypeName = [NSString stringWithCString:rawPropertyType encoding:NSUTF8StringEncoding];
        
        if (strcmp(rawPropertyType, @encode(float)) == 0) {
            //it's a float
            [self floatType:classMemberDictionary andPropertyType:propertyType andPropertyName:propertyName];
            
        }
        else if (strcmp(rawPropertyType, @encode(int)) == 0) {
            //it's an int
            [self intType:classMemberDictionary andPropertyType:propertyType andPropertyName:propertyName];
            
        } else if (strcmp(rawPropertyType, @encode(id)) == 0) {
            //it's some sort of object
            [classMemberDictionary setObject:propertyType forKey:propertyName];
        }
        
        else if (strcmp(rawPropertyType, @encode(BOOL)) == 0) {
            //it's some sort of object
            NSString* boolPropertyType = [propertyType stringByAppendingString:@"OOL"];
            [classMemberDictionary setObject:boolPropertyType forKey:propertyName];
        }
        
        else if (strcmp(rawPropertyType, @encode(double)) == 0) {
            //it's an double
            NSString* doublePropertyType = [propertyType stringByAppendingString:@"ouble"];
            [classMemberDictionary setObject:doublePropertyType forKey:propertyName];
        }
        
        else {
            // According to Apples Documentation you can determine the corresponding encoding values
        }
        
        if ([typeAttribute hasPrefix:@"T@"]) {
            //turns @"NSDate" into NSData
            NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];
            Class typeClass = NSClassFromString(typeClassName);
            
            if (typeClass != nil) {
                
                [classMemberDictionary setObject:typeClassName forKey:propertyName];
                NSLog(@"Type Class Name %@",typeClassName);
            }
        }
    }
    free(props);
    return  classMemberDictionary;
}
/*
 * Property type is "Float".
 */
-(void)floatType:(NSMutableDictionary*)classMemberDictionary andPropertyType:(NSString*)propertyType andPropertyName:(NSString*)propertyName
{
    NSString* floatPropertyType = [propertyType stringByAppendingString:@"loat"];
    [classMemberDictionary setObject:floatPropertyType forKey:propertyName];
}
/*
 *
 */
-(void)intType:(NSMutableDictionary*)classMemberDictionary andPropertyType:(NSString*)propertyType andPropertyName:(NSString*)propertyName
{
    NSString* intPropertyType = [propertyType stringByAppendingString:@"nt"];
    [classMemberDictionary setObject:intPropertyType forKey:propertyName];
}
@end
