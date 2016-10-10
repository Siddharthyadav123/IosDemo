//
//  AbstractUIView.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/14/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractView.h"
@interface AbstractUIView : UIView<AbstractView>
{
    NSInteger screenId;
}

-(NSInteger) getScreenId;
-(void) setScreenId:(int)screenId;
@end
