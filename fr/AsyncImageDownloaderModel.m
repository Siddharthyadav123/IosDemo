//
//  AsyncImageDownloaderModel.m
//  FleetRight
//
//  Created by test on 22/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "AsyncImageDownloaderModel.h"
#import "EquipmentListServiceModel.h"
#import "EquipmentIndividualModel.h"
#import "OtherEquipmentModel.h"
#import "InventoryModel.h"
#import "RenterContractIndividualModel.h"


@implementation AsyncImageDownloaderModel

-(void)initialize{
    
    [self startImageDownloadThread];
    
}


-(void)startImageDownloadThread{
    NSThread *timerThread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadAsyncImage) object:nil];
    [timerThread start];
}

/*
 * Method to initialize downloading images from server
 */
-(void)downloadAsyncImage{
    
    [self downloadImageWithURL:self.imageURL imageIndex:self.imageIndex completionBlock:^(BOOL succeeded, UIImage *image,int index){
        
        if (succeeded) {
            
            if ([self.imageRequestIdentifier isEqual:IMAGE_REQUEST_FROM_EQUIPMENT_INDIVIDUAL_MODEL]) {
                //Call method of Equipment Individual Model
                [self.equipmentIndividualModel onImageDownloadResponse:image andImageIndes:index success:succeeded];
            }
            
            else if ([self.imageRequestIdentifier isEqual:IMAGE_REQUEST_FROM_OTHER_EQUIPMENT_MODEL]) {
                //Call method of Other Equipment Model
                [self.otherEquipmentModel onImageDownloadResponse:image andImageIndes:index success:succeeded];
            }
            
            else if([self.imageRequestIdentifier isEqual:IMAGE_REQUEST_FROM_RENT]||[self.imageRequestIdentifier isEqual:IMAGE_REQUEST_FROM_SOLD]||[self.imageRequestIdentifier isEqual:IMAGE_REQUEST_FROM_IDLE]){
                //Call method of Inventory Equipment Model
                [self.inventoryModel onImageDownloadResponse:image andImageIndes:index success:succeeded identifier:self.imageRequestIdentifier];
            }
            
            else if ([self.imageRequestIdentifier isEqual:IMAGE_REQUEST_FROM_INDIVIDUAL_CONTRACT]||[self.imageRequestIdentifier isEqual:IMAGE_DOWNLOAD_REQUEST_FOR_SUPPLIER]||[self.imageRequestIdentifier isEqual:IMAGE_DOWNLOAD_REQUEST_FOR_RENTER]) {
                //Call method of Renter Contract Individual Model
                [self.renterContractIndividualModel onImageDownloadResponse:image andImageIndes:index success:succeeded identifier:self.imageRequestIdentifier];
            }
            
            else{
                //Call method of Equipment List Service Model
                [self.equipmentListServiceModel onImageDownloadResponse:image andImageIndes:index success:succeeded];
            }
        }
    }];
    
    
}


- (void)downloadImageWithURL:(NSURL *)url imageIndex:(int)index completionBlock:(void (^)(BOOL succeeded, UIImage *image,int index))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image,index);
                               } else{
                                   completionBlock(NO,nil,index);
                               }
                           }];
}

@end
