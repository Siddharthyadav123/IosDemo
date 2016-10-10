//
//  SearchAllDataModel.m
//  FleetRight
//
//  Created by test on 25/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "SearchAllDataModel.h"

@implementation SearchAllDataModel

-(void) initialize{
    [super initialize];
    [self initializeInstances];
    [self executeTask];
}

-(void)onPreTaskExecute{
    
    NSString *searchAllDataUrl = [URL_GET_ALL_SEARCH_DATA stringByAppendingString:@""];
    [httpRequestHandlerImpl setServiceURL:searchAllDataUrl];
    // [httpRequestHandlerImpl setHeaders:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_GET_ALL_SEARCH_DATA %@", searchAllDataUrl);
    
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
    NSArray* jsonData = [NSJSONSerialization
                         JSONObjectWithData:responseData
                         options:kNilOptions
                         error:&error];
    NSLog(@"jsonData: %@", jsonData);
    NSLog(@"JSONERROR: %@",error);
    if(jsonData!=nil){
        [self parseData:jsonData];
    }
}

//Response
//{
//    name = Ducati;
//},
//{
//    name = Dicor;
//},
//{
//    name = Titanium;
//},
//{
//    name = Pulsur;
//},
//{
//    name = Pulsur;
//},
//{
//    name = Fortuner;
//}

-(void)parseData:(NSArray*)jsonArray{
    if(jsonArray!=nil && [jsonArray count]>0)
    {
        self.allSearchDataArray= [[NSMutableArray alloc]init];
        
        for(int i=0;i<[jsonArray count];i++)
        {
            NSDictionary *item = [jsonArray objectAtIndex:i];
            
            SearchDao *searchDao=[self parseSearchData:item];
            
            [self.allSearchDataArray addObject:searchDao];
            
        }
        
        self.errorCode = SUCCESS_CODE;
        
    }else{
        self.errorMessage=@"Error in parsing";
    }
    
    NSLog(@"error message :  %@",self.errorMessage);
}


/**
 * Parsing Search Data
 **/
-(SearchDao*) parseSearchData:(NSDictionary*) item{
    
    SearchDao *searchDao=[[SearchDao alloc]init];
    
    if([item objectForKey:@"name"]!=[NSNull null])
    {
        searchDao.searchName=[item objectForKey:@"name"];
        
    }
    return searchDao;
}

@end
