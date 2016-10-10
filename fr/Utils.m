//
//  Utils.m
//  IosApplicationFrameworkProject
//
//  Created by test on 16/07/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "Utils.h"
#import "AppConstants.h"
#import <QuartzCore/QuartzCore.h>


@implementation Utils

/*
 * Method to convert interger hexadecimal value in UIColor format.
 */
+ (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}


/*
 * Method which works as helper method to convert String Hexadecimal Value into Interger format.
 */
+ (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}


/**
 * Method to give shadow to view.
 **/
+ (void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset view:(UIView *)containerView
{
    
    if (value)
    {
        [containerView.layer setCornerRadius:4];
        [containerView.layer setShadowColor:[UIColor blackColor].CGColor];
        [containerView.layer setShadowOpacity:0.8];
        [containerView.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    }
    else
    {
        [containerView.layer setCornerRadius:0.0f];
        [containerView.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}


+ (NSString *)toBase64String:(NSString *)string {
    NSData *nsdata = [string
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    NSLog(@"BASE 64: %@",base64Encoded);
    return base64Encoded;
}

//+ (NSString *)fromBase64String:(NSString *)string {
//    NSData  *base64Data = [NSStringUtil base64DataFromString:string];
//
//    NSString* decryptedStr = [[NSString alloc] initWithData:base64Data encoding:NSUnicodeStringEncoding];
//
//    return [decryptedStr autorelease];
//}

/*
 * Validates the address part, if it is returns true else false.
 */
+ (BOOL) isValidAddressPart:(NSString*)tempAddress{
    if((tempAddress!=nil) && (tempAddress.length!=0) && (![tempAddress isEqualToString:@"0"])){
        return true;
    }
    else return false;
}

/*
 * Method to set border to view.
 */
+(void)setBorderToView:(UIView*)view{
    
    view.layer.cornerRadius = 5.0f; // set as you want.
    //    view.layer.borderColor = [UIColor darkGrayColor].CGColor; // set color as you want.
    //    view.layer.borderWidth = 1.0;
}

/*
 * Method to set border colour to view.
 */
+(void)setBorderColourToView:(UIView*)view colour:(UIColor*)colour{
    
    view.layer.cornerRadius = 5.0f; // set as you want.
    view.layer.borderColor = colour.CGColor; // set color as you want.
    view.layer.borderWidth = 1.0;
}

/*
 * Method to round corners of button
 */
+(void)roundButtonCorner:(UIButton*)button{
    button.layer.cornerRadius = button.frame.size.height/2;
    button.clipsToBounds = YES;
    
    
}

/*
 * Method to change colour of placeholde (Hint)
 */
+(void)changePlaceHolderColour:(UITextField*)textView{
    [textView setValue:[UIColor colorWithRed:120.0/255.0 green:116.0/255.0 blue:115.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
}

/*
 * Validation for email id
 */

+(BOOL)isValidateEmail:(NSString *)emailString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z??]{2,4})$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailString];
    
    
}

/*
 * Validate Mobile Number
 */

+(BOOL)isValidateMobileNumber:(NSString*)number
{
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:number] == YES)
        return TRUE;
    else
        return FALSE;
}

/*
 * convert server ISO time into GMT format i.e it will add indian GMT time - 5.30 to respective input.
 */
+(NSString*)convertISOTimeIntoGMTTime:(NSString*)reportingTime{
    //"reporting_time" = "2015-11-23T11:21:00.000Z";
    NSString *inputDateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    NSString *outputDateFormat = @"dd/MM/yyyy'T'hh:mm:ss a";
    
    NSTimeZone *inputTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    [inputDateFormatter setTimeZone:inputTimeZone];
    [inputDateFormatter setDateFormat:inputDateFormat];
    
    NSDate *date = [inputDateFormatter dateFromString:reportingTime];
    
    NSTimeZone *outputTimeZone = [NSTimeZone localTimeZone];
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
    [outputDateFormatter setTimeZone:outputTimeZone];
    [outputDateFormatter setDateFormat:outputDateFormat];
    NSString *outputString = [outputDateFormatter stringFromDate:date];
    NSString *outputFormat = [outputString uppercaseString];
    
    //NSLog(@"date = %@", outputFormat);
    
    
    return outputFormat;
    
}

/*
 * Round off values to 3 digits
 */
+(double)roundOffValueToThreeDigits:(double)value{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    [format setRoundingMode:NSNumberFormatterRoundHalfUp];
    [format setMaximumFractionDigits:3];
    NSString *temp = [format stringFromNumber:[NSNumber numberWithFloat:value]];
    // NSLog(@"%@",temp);
    double roundOffValue = [temp doubleValue];
    return roundOffValue;
}


/*
 * Method to convert string into camel case.
 */
+(NSString *)camelCaseFromString:(NSString *)input{
    
    return[input capitalizedString];
}

/*
 * Method to check internet connection
 */
+ (BOOL)isInternertConnectionAvailabel
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}




@end
