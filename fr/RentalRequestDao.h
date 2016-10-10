//
//  RentalRequestDao.h
//  FleetRight
//
//  Created by test on 30/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RentalRequestDao : NSObject

@property(strong,nonatomic) NSString* name;
@property(strong,nonatomic) NSString*  emailAddress;
@property(strong,nonatomic) NSString* contactNumber;
@property(strong,nonatomic) NSString* jobLocation;
@property(strong,nonatomic) NSString*  province;
@property(strong,nonatomic) NSString* rentDay;
@property(strong,nonatomic) NSString* fromDate;
@property(strong,nonatomic) NSString* toDate;
@property(strong,nonatomic) NSString*  comment;


@end
