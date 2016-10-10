//
//  UIUtils.h
//  IosApplicationFrameworkProject
//
//  Created by test on 03/08/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIUtils : NSObject<UIAlertViewDelegate>

+ (UIAlertView *)createProgressDialog:(NSString *)title;

+(void)displayAlertDialog : (NSString*) errorMessage;

+(void)displaySuccessAlertDialog : (NSString*) errorMessage;

+(UIAlertView*)createAlertDialog:(NSInteger)tag delegate:(id)delegate;

@end
