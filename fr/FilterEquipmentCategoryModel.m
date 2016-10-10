//
//  FilterEquipmentCategoryModel.m
//  FleetRight
//
//  Created by Ranjit singh on 8/22/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "FilterEquipmentCategoryModel.h"

@implementation FilterEquipmentCategoryModel


-(void) initialize{
    [super initialize];
    [self executeTask];
}

-(void)onPreTaskExecute{
    
    NSString *url = [URL_GET_FILTER_CATEGORIES stringByAppendingString:@""];
    [httpRequestHandlerImpl setServiceURL:url];
    [httpRequestHandlerImpl setMethodType:HTTP_GET];
    NSLog(@"URL_GET_FILTER_CATEGORIES %@", url);
    
}

-(void)doInBackGround{
     [httpRequestHandlerImpl execute];
}


-(void)onResponse:(NSData *)responseData{
  //  NSLog(@"On Response: %@",responseData);
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
  //  NSLog(@"jsonData: %@", jsonData);
    
    if(jsonData!=nil){
        [self parseResponse:jsonData];
        
    }
}

-(void)parseResponse :(NSArray*)jsonResponse{
    
    if(jsonResponse!=nil && [jsonResponse count]>0)
    {
        self.filterEquipmentCateoryList= [[NSMutableArray alloc]init];
        
        for(int i=0;i<[jsonResponse count];i++)
        {
            NSDictionary *item = [jsonResponse objectAtIndex:i];
            
            FilterEquipmentCategoryDo *filterEquipmentCategoryDo=[self parseFilterEquipmentList:item];
            
            [self.filterEquipmentCateoryList addObject:filterEquipmentCategoryDo];
            
        }
        self.errorCode = SUCCESS_CODE;
        
    }else{
        self.errorMessage=@"No Record Found";
    }
    
    //setting list in local model
    [[[ApplicationController getInstance] getModelFacade]getLocalModel].filterEquipmentCateoryList=self.filterEquipmentCateoryList;
    
    NSLog(@"error message :  %@",self.errorMessage);
}


/**
 * Parsing Equipment
 [
 {
 "id": 1,
 "name": "Crusher",
 "subcategory":
 [
 {
 "id": 2,
 "parent_id": 1,
 "name": "Sub Crusher 1",
 "desc": "kokokok"
 },
 {
 "id": 3,
 "parent_id": 1,
 "name": "Sub Crusher 2",
 "desc": "okokoko"
 }
 ]
 }]
 **/
-(FilterEquipmentCategoryDo*) parseFilterEquipmentList:(NSDictionary*) item
{
    
    FilterEquipmentCategoryDo *filterEquipmentCategoryDo=[[FilterEquipmentCategoryDo alloc]init];
    
    filterEquipmentCategoryDo.id=[[item objectForKey:@"cat_id"] integerValue];
    
    
    if([item objectForKey:@"cat_name"]!=[NSNull null])
    {
        filterEquipmentCategoryDo.name=[item objectForKey:@"cat_name"];
        
    }
    
    if([item objectForKey:@"subcategory"]!=[NSNull null])
    {
        NSArray *subCatArra=[item objectForKey:@"subcategory"];
        
        filterEquipmentCategoryDo.subcategory= [[NSMutableArray alloc]init];
        
        //addng sub cat
        for(int i=0;i<[subCatArra count];i++)
        {
            FilterEquipmentSubCateogoryDo *filterEquipmentSubCat= [[FilterEquipmentSubCateogoryDo alloc]init];
            
            //id
            filterEquipmentSubCat.id=[[subCatArra[i] objectForKey:@"subcatid"] integerValue];
           
            //parent-id
            filterEquipmentSubCat.parent_id=[[subCatArra[i] objectForKey:@"cat_id"] integerValue];
            
            //name
            if([subCatArra[i] objectForKey:@"subcat_name"]!=[NSNull null])
            {
                filterEquipmentSubCat.name=[subCatArra[i] objectForKey:@"subcat_name"];
                
            }
            
            //desc
            if([subCatArra[i] objectForKey:@"description"]!=[NSNull null])
            {
                filterEquipmentSubCat.desc=[subCatArra[i] objectForKey:@"description"];
                
            }
            
            //adding
            [filterEquipmentCategoryDo.subcategory addObject:filterEquipmentSubCat];
            
        }
        
//        //dummy
//        if([subCatArra count]==0)
//        {
//            for(int i=0;i<3;i++)
//            {
//                FilterEquipmentSubCateogoryDo *filterEquipmentSubCatDummy= [[FilterEquipmentSubCateogoryDo alloc]init];
//                //adding
//                filterEquipmentSubCatDummy.name=@"test";
//                [filterEquipmentCategoryDo.subcategory addObject:filterEquipmentSubCatDummy];
//            }
//      
//        }
        
    }
    

    return filterEquipmentCategoryDo;
    
}
@end
