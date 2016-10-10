//
//  Utils.h
//  IosApplicationFrameworkProject
//
//  Created by test on 16/07/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIUtils.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>


@interface Utils : NSObject


#pragma METHODS TO CONVERT HEXADECIMAL VALUE TO UICOLOR.
+ (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
+ (unsigned int)intFromHexString:(NSString *)hexStr;
+ (void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset view:(UIView *)containerView;
+ (NSString *)toBase64String:(NSString *)string;
+ (BOOL)isValidAddressPart:(NSString*)tempAddress;
+(void)setBorderToView:(UIView*)view;
+(BOOL)isValidateEmail:(NSString *)emailString;
+(BOOL)isValidateMobileNumber:(NSString*)number;
+(NSString*)convertISOTimeIntoGMTTime:(NSString*)reportingTime;
+(double)roundOffValueToThreeDigits:(double)value;
+(NSString *)camelCaseFromString:(NSString *)input;
+(void)roundButtonCorner:(UIButton*)button;
+(void)changePlaceHolderColour:(UITextField*)textView;
+(void)setBorderColourToView:(UIView*)view colour:(UIColor*)colour;
+ (BOOL)isInternertConnectionAvailabel;
@end
