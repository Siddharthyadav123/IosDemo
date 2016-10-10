//
//  EquipmentIndividualModel.m
//  FleetRight
//
//  Created by test on 26/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "EquipmentIndividualModel.h"

@implementation EquipmentIndividualModel

-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self executeTask];
}

-(void)onPreTaskExecute{
    NSString *vehicleID = [NSString stringWithFormat:@"%d",self.selectedVehicleID];
    NSString *detailInfoURL = [URL_GET_INDIVIDUAL_EQUIPMENT_DETAILS stringByAppendingString:vehicleID];
    [httpRequestHandlerImpl setServiceURL:detailInfoURL];
    //[httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_GET_INDIVIDUAL_EQUIPMENT_DETAILS -> %@", detailInfoURL);
    
}

/*
 * Method to initializes instances
 */
-(void)initializeInstances{
    _equipmentDo=[[EquipmentDo alloc]init];
}

-(void)doInBackGround{
    
    [self requestData];
}

-(void)onTaskStopExecution{
    
}

/*
 * Method to post data in server
 */
-(void)requestData{
    
    [httpRequestHandlerImpl execute];
    
}

-(void)onResponse:(NSData *)responseData{
    NSLog(@"On Response: %@",responseData);
    if(responseData!=nil){
        [self parseResponseData:responseData];
    }
     [self informView];
}

/*
 * Parse the response data here.
 */
-(void)parseResponseData:(NSData*)responseData{
    NSError* error;
    NSDictionary* jsonData = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:kNilOptions
                              error:&error];
    NSLog(@"jsonData: %@", jsonData);
    NSLog(@"JSONERROR: %@",error);
    
    if(jsonData!=nil){
        [self parseEquipmentDetailResponse:jsonData];
        //[self initializeImageDownloadManager];
        self.errorCode = SUCCESS_CODE;
        
    }else{
        self.errorMessage=@"Error in parsing";
    }
    
    NSLog(@"error message :  %@",self.errorMessage);
}


-(void)parseEquipmentDetailResponse:(NSDictionary*)jsonDictionary{
    
    @autoreleasepool {
        if([jsonDictionary objectForKey:@"id"]!=[NSNull null]){
            _equipmentDo.id=[[jsonDictionary objectForKey:@"id"] integerValue];
        }
        
        if([jsonDictionary objectForKey:@"ename"]!=[NSNull null])
        {
            _equipmentDo.ename=[jsonDictionary objectForKey:@"ename"];
            
        }
        
        if([jsonDictionary objectForKey:@"mnf_id"]!=[NSNull null]){
            _equipmentDo.mnf_id=[[jsonDictionary objectForKey:@"mnf_id"] integerValue];
        }
        
        if([jsonDictionary objectForKey:@"mnfname"]!=[NSNull null])
        {
            _equipmentDo.mnfname=[jsonDictionary objectForKey:@"mnfname"];
            
        }
        
        if([jsonDictionary objectForKey:@"mdname"]!=[NSNull null])
        {
            _equipmentDo.mdname=[jsonDictionary objectForKey:@"mdname"];
            
        }
        
        if([jsonDictionary objectForKey:@"cname"]!=[NSNull null])
        {
            _equipmentDo.cname=[jsonDictionary objectForKey:@"cname"];
            
        }
        
        if([jsonDictionary objectForKey:@"year"]!=[NSNull null])
        {
            _equipmentDo.year=[[jsonDictionary objectForKey:@"year"] integerValue];
            
        }
        
        if([jsonDictionary objectForKey:@"hour_per_miles"]!=[NSNull null])
        {
            _equipmentDo.hour_per_miles=[[jsonDictionary objectForKey:@"hour_per_miles"]integerValue];
            
        }
        
        if([jsonDictionary objectForKey:@"daily"]!=[NSNull null])
        {
            _equipmentDo.daily=[jsonDictionary objectForKey:@"daily"];
            
        }
        
        if([jsonDictionary objectForKey:@"weekly"]!=[NSNull null])
        {
            _equipmentDo.weekly=[jsonDictionary objectForKey:@"weekly"];
            
        }
        
        if([jsonDictionary objectForKey:@"monthly"]!=[NSNull null])
        {
            _equipmentDo.monthly=[jsonDictionary objectForKey:@"monthly"];
            
        }
        
        if([jsonDictionary objectForKey:@"sale_price"]!=[NSNull null])
        {
            _equipmentDo.sale_price=[jsonDictionary objectForKey:@"sale_price"];
            
        }
        
        
        if([jsonDictionary objectForKey:@"status"]!=[NSNull null])
        {
            _equipmentDo.status=[jsonDictionary objectForKey:@"status"];
            
        }
        
        
        if([jsonDictionary objectForKey:@"url"]!=[NSNull null])
        {
            _equipmentDo.url=[jsonDictionary objectForKey:@"url"];
            
        }
        
        if([jsonDictionary objectForKey:@"desc"]!=[NSNull null])
        {
            
            _equipmentDo.desc=[jsonDictionary objectForKey:@"desc"];
            NSLog(@"_equipmentDo.desc %@",_equipmentDo.desc);
        }
        
    }
}

//Not called any where
-(void)initializeImageDownloadManager{
    
    @autoreleasepool {
        if(_equipmentDo.url!=nil){
            NSURL *imageURL = [NSURL URLWithString: _equipmentDo.url];
            AsyncImageDownloaderModel *asyncImageDownloaderModel = [[AsyncImageDownloaderModel alloc]init];
            asyncImageDownloaderModel.imageIndex = 1;
            asyncImageDownloaderModel.imageURL =imageURL;
            asyncImageDownloaderModel.imageRequestIdentifier = IMAGE_REQUEST_FROM_EQUIPMENT_INDIVIDUAL_MODEL;
            asyncImageDownloaderModel.equipmentIndividualModel = self;
            [asyncImageDownloaderModel initialize];
            
            imageURL = nil;
        }
        
    }
}



//Not called any where
-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded{
    @autoreleasepool {
        if (succeeded) {
            [_equipmentDo setVehicleImage:image];
            [self informView];
        }
    }
    
}


@end
