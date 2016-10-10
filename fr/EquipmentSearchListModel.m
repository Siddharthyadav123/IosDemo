//
//  EquipmentSearchListModel.m
//  FleetRight
//
//  Created by Ranjit singh on 8/30/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "EquipmentSearchListModel.h"
#import "LocalModel.h"


@implementation EquipmentSearchListModel

-(void)initialize
{
    [super initialize];
    [self executeTask];
}

-(void)initializeInstances{
    localModel = [[[ApplicationController getInstance]getModelFacade]getLocalModel];
}

-(void)onPreTaskExecute
{
    
    NSString *equipmentListURL = [URL_GET_ALL_SEARCH_TEXT_RELATED_DATA stringByAppendingString:self.searchText];
    //replacing black space by +
    equipmentListURL = [equipmentListURL stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [httpRequestHandlerImpl setServiceURL:equipmentListURL];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_GET_ALL_SEARCH_TEXT_RELATED_DATA %@", equipmentListURL);
}

-(void)doInBackGround{
    
    [self requestData];
}

-(void)onTaskStopExecution{
    
}

-(void)onResponse:(NSData *)responseData{
    
    if(responseData!=nil){
        [self parseResponseData:responseData];
        if ([self.searchEquipmentListArray count]!=0) {
            [self initializeImageDownloadManager];
        }
        
    }else
    {
          self.errorMessage=@"No Search Result Found";
         [self informView];
    }
   
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
    // NSLog(@"jsonData: %@", jsonData);
    
    if(jsonData!=nil){
        [self parseResponse:jsonData];
        
    }else{
          self.errorMessage=@"No Search Result Found";
         [self informView];
    }
}

/*
 * Method to parse error message
 //{
 //"id": 48,
 //  "ename": "Ducati",
 //  "mnf_id": 1,
 //  "mnfname": "Tata",
 //  "mdname": "E100",
 //  "cname": "Crusher",
 //   "year": 2016,
 //  "hour_per_miles": 30,
 //   "daily": "$125",
 //   "weekly": "$1250",
 //  "monthly": "$12500",
 //  "sale_price": "0",
 //   "status": "Available",
 //   "url": "http://alkurn.net/clients/fleetright/frontend/web/uploads/default.jpg"
 //}
 */
-(void)parseResponse :(NSArray*)jsonResponse{
    @autoreleasepool {
        
        @try {
            if(jsonResponse!=nil && [jsonResponse count]>0)
            {
                
                self.searchEquipmentListArray= [[NSMutableArray alloc]init];
                
                for(int i=0;i<[jsonResponse count];i++)
                {
                    NSDictionary *item = [jsonResponse objectAtIndex:i];
                    
                    EquipmentDo *equipmentDo=[self parseEquipment:item];
                    
                    [self.searchEquipmentListArray addObject:equipmentDo];
                    
                }
                
                self.errorCode = SUCCESS_CODE;
                self.errorMessage=nil;
            }else{
                self.errorMessage=@"No Search Result Found";
            }
            
            NSLog(@"error message :  %@",self.errorMessage);
        } @catch (NSException *exception) {
            self.errorMessage=@"No Search Result Found";
           
        }
        
         [self informView];
        
    }
}


/**
 * Parsing Equipment
 **/
-(EquipmentDo*) parseEquipment:(NSDictionary*) item
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



/*
 * Method to post data in server
 */
-(void)requestData{
    [httpRequestHandlerImpl execute];
}


-(void)initializeImageDownloadManager{
    
    @autoreleasepool {
        NSMutableArray *vehicleImageArray = self.searchEquipmentListArray;
        int vehicleImageCount= (int)[vehicleImageArray count];
        
        for (int i=0; i<vehicleImageCount; i++) {
            
            EquipmentDo *equipmentDo = [vehicleImageArray objectAtIndex:i];
            NSURL *imageURL = [NSURL URLWithString:equipmentDo.url];
            
            AsyncImageDownloaderModel *asyncImageDownloaderModel = [[AsyncImageDownloaderModel alloc]init];
            asyncImageDownloaderModel.imageIndex = i;
            asyncImageDownloaderModel.imageURL =imageURL;
            asyncImageDownloaderModel.equipmentListServiceModel = self;
            [asyncImageDownloaderModel initialize];
            
            
            equipmentDo=nil;
            imageURL = nil;
            
        }
    }
    
}


-(void)onImageDownloadResponse:(UIImage *)image andImageIndes:(int)index success:(BOOL) succeeded{
    @autoreleasepool {
        if (succeeded) {
            EquipmentDo *tempEquipmentDo = [self.searchEquipmentListArray objectAtIndex:index];
            [tempEquipmentDo setVehicleImage:image];
            [self informView];
        }
    }
    
}



@end
