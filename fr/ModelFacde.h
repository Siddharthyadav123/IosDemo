//
//  ModelFacde.h
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#ifndef __MODEL_FACADE_H__
#define __MODEL_FACADE_H__


#import <Foundation/Foundation.h>
#import "IModel.h"
#import "RemoteModel.h"
@class LocalModel;
@interface ModelFacde : NSObject<IModel>
{
    
    /**
     * LocalModel Class reference
     */
    LocalModel *localModel;
    
    /**
     * RemoteModel Class reference
     */
    RemoteModel *remoteModel;
    
}

-(LocalModel*) getLocalModel;

-(RemoteModel*) getRemoteModel;

@end


#endif