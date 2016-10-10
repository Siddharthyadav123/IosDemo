//
//  Model.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//
#ifndef __MODEL_H__
#define __MODEL_H__

#import <Foundation/Foundation.h>
#import "IModel.h"
#import "AbstractViewController.h"

@interface Model : NSObject<IModel>
{
    NSMutableArray *abstractView;
}
@property (nonatomic, retain) NSMutableArray *abstractView;
@end

#endif
