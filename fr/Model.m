//
//  Model.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "Model.h"
#import "AbstractView.h"

@interface Model()


@end

@implementation Model

@synthesize abstractView;

- (id)init
{
    self = [super init];
    if (self) {
        
        abstractView=[[NSMutableArray alloc]init];
    }
    return self;
}

-(void)initialize
{
    
}

-(void)destory
{
    
    
}

-(void)registerview:(id <AbstractViewController>)view
{
    if (abstractView != nil && view != nil)
    {
        
        [abstractView addObject:view];
    }
}

-(void)unregisterview:(id <AbstractViewController>)view
{
    if (abstractView !=nil && view !=nil) {
       
        [abstractView removeObject:view];
    }
}


-(void)informView
{
  //  update each AbstractView register to this model
    if (abstractView !=nil) {
        for (int i=0; i<abstractView.count; i++) {
            
            [[abstractView objectAtIndex:i] update];
             
            
        }
    }
}

@end
