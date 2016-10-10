//
//  ModelFacde.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "ModelFacde.h"
#import "LocalModel.h"






@implementation ModelFacde

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"Object is created");
        
        self->remoteModel=[[RemoteModel alloc]init];
        self->localModel=[[LocalModel alloc]init];
        
    }
    return self;
}


-(LocalModel *)getLocalModel
{
    
    return  localModel;
   
}

-(RemoteModel *)getRemoteModel
{
    
    return  remoteModel;
   
}


-(void)initialize
{
   
    [self->localModel initialize];
    [self->remoteModel initialize];
    
    NSLog(@"Object destroyed");
    
}

-(void)informView
{
    
}

-(void)destory
{
    [self->localModel destory];
    [self->remoteModel destory];
    
    NSLog(@"Object destroyed");
}

-(void)registerview:(NSObject<AbstractView> *)view
{
    
}

-(void)unregisterview:(NSObject<AbstractView> *)view
{
    
}

@end
