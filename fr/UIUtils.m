//
//  UIUtils.m
//  IosApplicationFrameworkProject
//
//  Created by test on 03/08/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils


/*
 * Creates the progress dialog & returns the instance.
 */
+ (UIAlertView *)createProgressDialog:(NSString *)title{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    indicator.center = CGPointMake(alertView.bounds.size.width / 2, alertView.bounds.size.height - 200);
    
    [indicator setFrame:CGRectMake(screenRect.size.width/2, screenRect.size.height/2,50,50)];
    
    [indicator startAnimating];
    
    [alertView setValue:indicator forKey:@"accessoryView"];
    
    return alertView;
}


/*
 * Display AlertDialog Box
 */
+(void)displayAlertDialog : (NSString*) errorMessage{
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Alert"
                              message:errorMessage
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
    [alertView show];
}


/*
 * Display AlertDialog Box
 */
+(void)displaySuccessAlertDialog : (NSString*) errorMessage{
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Success"
                              message:errorMessage
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
    [alertView show];
}

/*
 * Display alert dialog of two buttos
 */
+(UIAlertView*)createAlertDialog:(NSInteger)tag delegate:(id)delegate{
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@""
                              delegate:delegate
                              cancelButtonTitle:@"NO"
                              otherButtonTitles:@"YES", nil];
    alertView.tag = tag;
    return alertView;
}

@end
