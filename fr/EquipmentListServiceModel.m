//
//  EquipmentListServiceModel.m
//  FleetRight
//
//  Created by Ranjit singh on 8/12/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "EquipmentListServiceModel.h"
#import "LocalModel.h"

@implementation EquipmentListServiceModel


-(void)initialize
{
    [super initialize];
    [self initializeInstances];
    [self executeTask];
}

-(void)initializeInstances{
    self.homeScreenDataManager = [[HomeScreenDataManager alloc]init];
    localModel = [[[ApplicationController getInstance]getModelFacade]getLocalModel];
    localModel.homeScreenDataTable = self.homeScreenDataManager;
}

-(void)onPreTaskExecute
{
    
    NSString *equipmentListURL = [URL_GET_EQUIPMENT_LIST stringByAppendingString:@""];
    [httpRequestHandlerImpl setServiceURL:equipmentListURL];
    //   [httpRequestHandlerImpl setHeaders:@"Authorization" value:[self getAuthToken]];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_CHECK_SIGN_IN %@", equipmentListURL);
}

-(void)doInBackGround{
    
    [self requestData];
}

-(void)onTaskStopExecution{
    
}

-(void)onResponse:(NSData *)responseData{
    
    if(responseData!=nil){
        [self parseResponseData:responseData];
        if ([self.equipmentListArray count]!=0) {
            [self deleteImageDataFromFolder];
            [self initializeImageDownloadManager];
        }
        
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
    // NSLog(@"jsonData: %@", jsonData);
    
    if(jsonData!=nil){
        [self parseResponse:jsonData];
    }
    
    [self informView];
    
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
        if(jsonResponse!=nil && [jsonResponse count]>0)
        {
            self.equipmentListArray= [[NSMutableArray alloc]init];
            
            for(int i=0;i<[jsonResponse count];i++)
            {
                NSDictionary *item = [jsonResponse objectAtIndex:i];
                
                EquipmentDo *equipmentDo=[self parseEquipment:item];
                
                [self.equipmentListArray addObject:equipmentDo];
                
                
            }
            if( [self.equipmentListArray count]>0){
                [self saveDataInDataBase:self.equipmentListArray];
                self.errorCode = SUCCESS_CODE;
            }
            
        }else{
            
            self.errorMessage=@"Error in parsing";
        }
        
        
        NSLog(@"error message :  %@",self.errorMessage);
        
    }
}


/**
 * Parsing Equipment
 **/
-(EquipmentDo*) parseEquipment:(NSDictionary*) item
{
    @autoreleasepool {
        
        EquipmentDo *equipementDo=[[EquipmentDo alloc]init];
        
        if ([item objectForKey:@"id"]!=[NSNull null]) {
            equipementDo.id=[[item objectForKey:@"id"] integerValue];
        }
        
        
        if([item objectForKey:@"ename"]!=[NSNull null])
        {
            equipementDo.ename=[item objectForKey:@"ename"];
            
        }
        
        if ([item objectForKey:@"mnf_id"]!=[NSNull null]) {
            equipementDo.mnf_id=[[item objectForKey:@"mnf_id"] integerValue];
        }
        
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
        
        if([item objectForKey:@"year"]!=[NSNull null])
        {
            equipementDo.year=[[item objectForKey:@"year"] integerValue];
        }
        
        if([item objectForKey:@"year"]!=[NSNull null])
        {
            
            equipementDo.hour_per_miles=[[item objectForKey:@"hour_per_miles"]integerValue];
        }
        
        
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
        NSMutableArray *vehicleImageArray = self.equipmentListArray;
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
            EquipmentDo *tempEquipmentDo = [self.equipmentListArray objectAtIndex:index];
            [tempEquipmentDo setVehicleImage:image];
            [self saveImagesIntoDeviceMemory:image imageIndex:index];
        }
        [self informView];
    }
    
}

/*
 * Method to save data in database
 */
-(void)saveDataInDataBase:(NSMutableArray *)equipmentListArray{
    [self deleteDataFromDataBase];
    @autoreleasepool {
        [self.homeScreenDataManager insertUserData:equipmentListArray];
    }
}

/*
 * Method to delete data from database
 */
-(void)deleteDataFromDataBase{
    //@"" String is not going to use anywhere in delete data
    [ self.homeScreenDataManager deleteData:@""];
}


/*
 * Methodt to save images into local sd card/memory of devices
 */
-(void)saveImagesIntoDeviceMemory:(UIImage*)image imageIndex:(int)index{
    @autoreleasepool {
        
        NSData *imageData = UIImagePNGRepresentation(image);
        
        _folderPath = [self createFolderForImages];
        
        NSString *filePath = [self createFileOfImages:_folderPath imageIndex:index];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])	//Does file already exist?
        {
            [[NSFileManager defaultManager] createFileAtPath:filePath contents:imageData attributes:nil];
            
            //Write the file to documents directory
            [imageData writeToFile:filePath atomically:YES];
        }
        
        
        filePath = nil;
        imageData = nil;
        
    }
    
}

/*
 * Method to create folder in device for storing images
 */
-(NSString*)createFolderForImages{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Get the docs directory
    
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    
    NSString *folderName = @"Home_Screen_Vehicle_Image" ;
    
    NSString *folderPath = [documentsDirectoryPath  stringByAppendingPathComponent:folderName];  // subDirectory
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath])	//Does directory already exist?
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath  withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return folderPath;
    
    paths = nil;
    documentsDirectoryPath = nil;
    folderPath = nil;
    folderName = nil;
    
    return nil;
    
}

/*
 * Method to create file of image date in respective folder
 */
-(NSString*)createFileOfImages:(NSString *)folderPath imageIndex:(int)index{
    
    NSString* imageName = [@"home_screen_vehicle_image_" stringByAppendingFormat:@"0%d_index",index];
    
    //Add the FileName to FilePath
    
    NSString *filePath = [folderPath stringByAppendingPathComponent:[imageName stringByAppendingFormat:@"%@",@".png"]];
    
   // NSLog(@"Save data %@",filePath);
    
    return filePath;
    
    imageName = nil;
    filePath = nil;
}

/*
 * Method to delete image data from folder
 */
-(void)deleteImageDataFromFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Get the docs directory
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    
    if (documentsDirectoryPath!=nil) {
        [[NSFileManager defaultManager] removeItemAtPath:documentsDirectoryPath error:nil];
    }
    
}


@end
