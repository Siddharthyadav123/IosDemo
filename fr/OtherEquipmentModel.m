//
//  OtherEquipmentModel.m
//  FleetRight
//
//  Created by test on 29/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "OtherEquipmentModel.h"
#import "EquipmentDetailViewController.h"

@implementation OtherEquipmentModel
-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self executeTask];
}

-(void)onPreTaskExecute{
    NSString *parameters = [NSString stringWithFormat:@"equipment_id=%d&mnf_id=%d",self.equipment_id,self.mnf_id];
    NSString *otheEquipmentURL = [URL_GET_OTHER_RELATED_EQUIPMENT_DETAILS stringByAppendingString:parameters];
    [httpRequestHandlerImpl setServiceURL:otheEquipmentURL];
    [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_GET_OTHER_RELATED_EQUIPMENT_DETAILS -> %@", otheEquipmentURL);
    
}

/*
 * Method to initializes instances
 */
-(void)initializeInstances{
    
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
   
    if(responseData!=nil){
        [self parseResponseData:responseData];
    }
   // [self informView];
}

/*
 * Parse the response data here.
 */
-(void)parseResponseData:(NSData*)responseData{
    NSError* error;
    NSArray* jsonData = [NSJSONSerialization
                         JSONObjectWithData:responseData
                         options:kNilOptions
                         error:&error];
    NSLog(@"jsonData of OtherEquipment model: %@", jsonData);
  
    
    if(jsonData!=nil){
        [self parseResponse:jsonData];
        if ([self.otherRelatedEquipmrntArray count]!=0) {
            [self initializeImageDownloadManager];
        }
        
        self.errorCode = SUCCESS_CODE;
        
    }else{
        self.errorMessage=@"Error in parsing";
    }
    
    NSLog(@"error message :  %@",self.errorMessage);
}



-(void)parseResponse :(NSArray*)jsonResponse{
    @autoreleasepool {
        if(jsonResponse!=nil && [jsonResponse count]>0)
        {
            self.otherRelatedEquipmrntArray= [[NSMutableArray alloc]init];
            
            for(int i=0;i<[jsonResponse count];i++)
            {
                NSDictionary *item = [jsonResponse objectAtIndex:i];
                
                EquipmentDo *equipmentDo=[self parseOtherEquipmentResponse:item];
                
                [self.otherRelatedEquipmrntArray addObject:equipmentDo];
                
                
            }
            
            self.errorCode = SUCCESS_CODE;
            
        }else{
            self.errorMessage=@"Error in parsing";
        }
        
        NSLog(@"error message :  %@",self.errorMessage);
        
    }
}



/**
 * Parsing Equipment
 **/
-(EquipmentDo*) parseOtherEquipmentResponse:(NSDictionary*) item
{
    @autoreleasepool {
        
        EquipmentDo *equipementDo=[[EquipmentDo alloc]init];
        
        equipementDo.id=[[item objectForKey:@"id"] integerValue];
        
        
        if([item objectForKey:@"ename"]!=[NSNull null])
        {
            equipementDo.ename=[item objectForKey:@"ename"];
            
        }
        
        equipementDo.mnf_id=[[item objectForKey:@"mnf_id"] integerValue];
        
        
        if([item objectForKey:@"mnfname"]!=[NSNull null])
        {
            equipementDo.mnfname=[item objectForKey:@"mnfname"];
            
        }
        
        if([item objectForKey:@"mdname"]!=[NSNull null])
        {
            equipementDo.mdname=[item objectForKey:@"mdname"];
            
        }
        
        if([item objectForKey:@"cname"]!=[NSNull null])
        {
            equipementDo.cname=[item objectForKey:@"cname"];
            
        }
        
        
        equipementDo.year=[[item objectForKey:@"year"] integerValue];
        
        
        equipementDo.hour_per_miles=[[item objectForKey:@"hour_per_miles"]integerValue];
        
        
        
        if([item objectForKey:@"daily"]!=[NSNull null])
        {
            equipementDo.daily=[item objectForKey:@"daily"];
            
        }
        
        if([item objectForKey:@"weekly"]!=[NSNull null])
        {
            equipementDo.weekly=[item objectForKey:@"weekly"];
            
        }
        
        if([item objectForKey:@"monthly"]!=[NSNull null])
        {
            equipementDo.monthly=[item objectForKey:@"monthly"];
            
        }
        
        if([item objectForKey:@"sale_price"]!=[NSNull null])
        {
            equipementDo.sale_price=[item objectForKey:@"sale_price"];
            
        }
        
        
        if([item objectForKey:@"status"]!=[NSNull null])
        {
            equipementDo.status=[item objectForKey:@"status"];
            
        }
        
        
        if([item objectForKey:@"url"]!=[NSNull null])
        {
            equipementDo.url=[item objectForKey:@"url"];
            
        }
        
        return equipementDo;
        
    }
}

-(void)initializeImageDownloadManager{
    
    @autoreleasepool {
        NSMutableArray *vehicleImageArray = self.otherRelatedEquipmrntArray;
        int vehicleImageCount= (int)[vehicleImageArray count];
        
        for (int i=0; i<vehicleImageCount; i++) {
            
            EquipmentDo *equipmentDo = [vehicleImageArray objectAtIndex:i];
            
            NSString *url=nil;
            if([equipmentDo.url containsString:@" "])
            {
                url = [equipmentDo.url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                
            }else{
                url=equipmentDo.url;
            }
            
            NSURL *imageURL = [NSURL URLWithString:url];
            
            AsyncImageDownloaderModel *asyncImageDownloaderModel = [[AsyncImageDownloaderModel alloc]init];
            asyncImageDownloaderModel.imageIndex = i;
            asyncImageDownloaderModel.imageURL =imageURL;
            asyncImageDownloaderModel.imageRequestIdentifier = IMAGE_REQUEST_FROM_OTHER_EQUIPMENT_MODEL;
            asyncImageDownloaderModel.otherEquipmentModel = self;
            [asyncImageDownloaderModel initialize];
            
            
            equipmentDo=nil;
            imageURL = nil;
            
        }
    }
    
}


-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded{
    @autoreleasepool {
        if (succeeded) {
            EquipmentDo *tempEquipmentDo = [self.otherRelatedEquipmrntArray objectAtIndex:index];
            [tempEquipmentDo setVehicleImage:image];
           
        }
         [self informView];
    }
    
}

/*
 * Override informview method to call onImageUploadDataResponse method of viewcontroller instead of update method.
 */
-(void) informView{
    
    if (abstractView !=nil) {
        for (int i=0; i<abstractView.count; i++) {
            
                EquipmentDetailViewController *equipmentDetailViewController = [abstractView objectAtIndex:i];
                
                [equipmentDetailViewController onVehicleImageResponse];
                
                       
            
        }
    }
    
}


@end
