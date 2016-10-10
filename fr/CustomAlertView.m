//
//  CustomAlertView.m
//  CustomAlertViewProject
//
//  Created by ranjit singh on 9/23/15.
//  Copyright (c) 2015 ranjit singh. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self createAlertInstance];
    }
    return self;
}

/*
 * Creates the alertview instance if it is below 8 else create alertviewcontroller.
 */
-(void)createAlertInstance{
    if(IS_OS_8_OR_LATER){
        //if it is 8.0 later
        _alertViewController = [[UIAlertController alloc]init];
        
    }else{
        //if below 8.0
        _alertView = [[UIAlertView alloc]init];
        _alertView.delegate = self;
    }
    
}


/*
 * Setter for AlertView message.
 */
-(void)setMessage:(NSString *)message{
    _message = message;
    if (_alertViewController!=nil) {
        
        //Set message for UIAlertView  Controller.
        
        [_alertViewController setMessage:[@"\n" stringByAppendingString:message]];
        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) {
            [self setMessageFont:18];
            
        }else{
            [self setMessageFont:12];
            
        }
        
        
    }else{
        
        //Set message for UIAlertView  .
        [_alertView setMessage:message];
    }
    
}


///*
// * Set style of alert view controller at center of screen.
// */
//-(void)setAlertViewControllerStyle{
//    _alertViewController = [UIAlertController alertControllerWithTitle:@" "
//                                                               message:@"\n\n\n"
//                                                        preferredStyle:UIAlertControllerStyleAlert];}


/*
 * Setter for AlertView title.
 */
-(void)setTitle:(NSString *)title{
    _title = title;
    if (_alertViewController!=nil) {
        
        //Set title for UIAlertView  Controller.
        [_alertViewController setTitle:title];
        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) {
            [self setTitleFont:20];
            
        }else{
            
            [self setTitleFont:15];
            
        }
    }else{
        
        //Set title for UIAlertView.
        [_alertView setTitle:title];
    }
}

/*
 * Show alert view.
 */

-(void) show:(UIViewController *)viewController{
    
    if(_alertViewController!=nil){
        
        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) {
            //Device is ipad, then using alert popover view to present as a alert view.
            UIPopoverPresentationController *alertPopoverPresentationController = _alertViewController.popoverPresentationController;
            
            alertPopoverPresentationController.sourceRect = CGRectMake(viewController.view.bounds.size.width / 2.0, viewController.view.bounds.size.height / 2.0, 1.0, 1.0);
            alertPopoverPresentationController.sourceView = viewController.view;
            alertPopoverPresentationController.permittedArrowDirections = 0;
            
            alertPopoverPresentationController = nil;
            
        }
        
        [viewController showViewController:_alertViewController sender:nil];
        
    }else{
        
        [_alertView show];
    }
}



/*
 * Method to create and return alert Action (Button).
 */
-(UIAlertAction*) getAlertAction:(NSString*)title alertViewTag:(int)tag{
    
    //Create UIAlertAction instance having default alertview style.
    UIAlertAction *alertAction = [UIAlertAction
                                  actionWithTitle:title
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction *action)
                                  {
                                      [self onAlertActionButtonClicked:tag];
                                  }];
    
    
    return alertAction;
    
}


/*
 * Method called from controller to create and display alertview or alertController as per the version of current device. It takes paramater like title to set title, message to set message to display in view, right and left button title, custom alertview delegate and an identifier to know from which dialog this method is called.
 */

+(CustomAlertView*) createCustomAlertView:(NSString*)title alertMessage:(NSString*)message leftButtonTitle:(NSString*)leftButtonTitle rightButtonTitle:(NSString*)rightButtonTitle delegate:(id <CustomAlertViewDelegate>) delegate identifier:(int)identifier{
    
    //create new instance for custom alert view
    CustomAlertView *customAlertView = [[CustomAlertView alloc]init];
    
    
    [customAlertView setTitle:title];
    [customAlertView setMessage:message];
    [customAlertView setDelegate:delegate];
    [customAlertView setIdentifier:identifier];
    [customAlertView addButtons:leftButtonTitle rightButtonTitle:rightButtonTitle];
    return customAlertView;
    
}

/*
 * Method called from controller to create and display alertview or alertController as per the version of current device.
 */
-(void)addButtons:(NSString*)leftButtonTitle rightButtonTitle:(NSString*)rightButtonTitle{
    
    if (_alertViewController!=nil) {
        
        //if user wants to add cancel button in alertview.
        if (leftButtonTitle != nil) {
            
            [_alertViewController addAction:[self getAlertAction:leftButtonTitle alertViewTag:LEFT_BUTTON_TAG]];
            
        }
        
        //if user wants to add second button in alertview.
        if (rightButtonTitle != nil) {
            
            [_alertViewController addAction:[self getAlertAction:rightButtonTitle alertViewTag:RIGHT_BUTTON_TAG]];
        }
        
    }
    else{
        
        //if user wants to add cancel button in alertview.
        if (leftButtonTitle != nil) {
            
            [_alertView addButtonWithTitle:leftButtonTitle];
            
            
        }
        
        //if user wants to add second button in alertview.
        if (rightButtonTitle != nil) {
            
            [_alertView addButtonWithTitle:rightButtonTitle];
            
            
        }
        
        
        
    }
}



/*
 * UIAlertViewDelegate method to get call back of button click.
 */
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self onAlertActionButtonClicked:buttonIndex];
    
}


/*
 * Method to call viewcontroller's method after clicking on alertview button.
 */
-(void)onAlertActionButtonClicked:(NSInteger)buttonTag{
    
    if (buttonTag == LEFT_BUTTON_TAG) {
        
        NSLog(@"Cancel Button Click");
        
        //CustomAlertViewDelegate Method.
        [self.delegate onAlertViewLeftButtonClicked:_identifier];
        
    } else if(buttonTag == RIGHT_BUTTON_TAG){
        
        NSLog(@"Other Button Click");
        
        //CustomAlertViewDelegate Method.
        [self.delegate onAlertViewRightButtonClicked:_identifier];
        
    }
}

/*
 * Set font of title
 */
-(void)setTitleFont:(int) size{
    NSMutableAttributedString *textString = [self setFontToText:_title textSize:size];
    [_alertViewController setValue:textString forKey:@"attributedTitle"];
    
}
/*
 * Set text for message and title and also set its size.
 */
-(NSMutableAttributedString*)setFontToText:(NSString*) text textSize:(int)textSize {
    if (text!=nil) {
        
        NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:text];
        [textString addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:textSize]
                           range:NSMakeRange(0, [textString length])];
        return textString;
        
    }
    return @"";
    //    _alertViewController.view.tintColor = [UIColor blueColor];
}

/*
 * Set font of message
 */
-(void)setMessageFont:(int) size{
    NSMutableAttributedString *textString = [self setFontToText:_alertViewController.message textSize:size];
    [_alertViewController setValue:textString forKey:@"attributedMessage"];
}

/*
 * Method called from controller to create and display progress dialog as per the version of current device. It takes paramater like title to set title, custom alertview delegate and an identifier to know from which dialog this method is called.
 */
+(CustomAlertView*) createCustomProgressDialog:(NSString*)title delegate:(id <CustomAlertViewDelegate>) delegate identifier:(int)identifier{
    
    //create new instance for custom alert view
    CustomAlertView *customAlertView = [[CustomAlertView alloc]init];
    
    
    [customAlertView setTitle:title];
    [customAlertView setMessage:@""];
    [customAlertView setDelegate:delegate];
    [customAlertView setIdentifier:identifier];
    
    //Create Custom alert controller Progress Dialog for ios version 8 or above
    if (customAlertView.alertViewController!=nil) {
        
        [customAlertView setMessage:@"\n\n\n"];
        
        //Create Activity Indicator View.
        UIActivityIndicatorView *loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

        //Set Activity Indicator View to center.
        loader.center =customAlertView.alertViewController.view.center;
        
        //Set Activity Indicator View color to black.∂
        loader.color = [UIColor blackColor];
        
        loader.translatesAutoresizingMaskIntoConstraints=NO;
        
        //Add Activity Indicator View to alertController's view.
        [customAlertView.alertViewController.view addSubview:loader];
        
        NSDictionary * views = @{@"pending" : customAlertView.alertViewController.view, @"indicator" : loader};
        
        NSArray * constraintsVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[indicator]-(20)-|" options:0 metrics:nil views:views];
        NSArray * constraintsHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[indicator]|" options:0 metrics:nil views:views];
        NSArray * constraints = [constraintsVertical arrayByAddingObjectsFromArray:constraintsHorizontal];
        [customAlertView.alertViewController.view addConstraints:constraints];
        [loader setUserInteractionEnabled:NO];
        
        //To start Animation of Activity Indicator View.
        [loader startAnimating];
        
         }else{
        
        //Create Custom alert view Progress Dialog for ios below version 8
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        indicator.center = CGPointMake(customAlertView.alertView.bounds.size.width / 2, customAlertView.alertView.bounds.size.height - 200);
        
        [indicator setFrame:CGRectMake(screenRect.size.width/2, screenRect.size.height/2,50,50)];
        
        [indicator startAnimating];
        
        [customAlertView.alertView setValue:indicator forKey:@"accessoryView"];
        
 
    }
    
    return customAlertView;
    
}




/*
 * Method to dismiss progress dialog.
 */
-(void)dismissCustomProgressDialog:(void(^)(void))completion{
    
    if (_alertViewController!=nil) {
        
        [_alertViewController dismissViewControllerAnimated:YES completion:completion];
        
    }else{
        
        [_alertView dismissWithClickedButtonIndex:NO animated:nil];
        
        if (completion == nil) {
            completion = ^{};
            completion();
        }
        else{
            completion();
        }
    }
    
    
}


@end
