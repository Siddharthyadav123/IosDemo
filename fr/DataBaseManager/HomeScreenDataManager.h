//
//  HomeScreenDataTable.h
//  FleetRight
//
//  Created by test on 23/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "SQLiteTable.h"

@class  EquipmentDo;
@interface HomeScreenDataManager : SQLiteTable
{
    NSDictionary *ContentValuesDictionary;
    NSArray *columnsArray;
}

-(void)initializeTable;
-(void)insertUserData:(NSArray*)valuesArray;
-(NSArray *)getData;
//-(void)deleteData:(NSString*)selectedField;
//-(void)updateUserData:(NSArray*)valuesArray andSelectedField:(NSString*)selectedField;
-(void)deleteData:(NSString*)selectedField;

@end
