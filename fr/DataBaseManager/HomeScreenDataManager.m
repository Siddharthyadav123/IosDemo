//
//  HomeScreenDataTable.m
//  FleetRight
//
//  Created by test on 23/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "HomeScreenDataManager.h"
#import "EquipmentDo.h"

@implementation HomeScreenDataManager


NSString* const EQUIPMENT_ID = @"equipment_id";
NSString* const E_NAME = @"ename";
NSString* const MNF_ID = @"mnf_id";
NSString* const MNF_NAME = @"mnfname";
NSString* const MD_NAME = @"mdname";
NSString* const CN_NAME = @"cname";
NSString* const YEAR = @"year";
NSString* const HOURS_PER_MILES = @"hour_per_miles";
NSString* const DAILY = @"daily";
NSString* const WEEKLY = @"weekly";
NSString* const MONTHLY = @"monthly";
NSString* const SALE_PRICE = @"sale_price";
NSString* const STATUS = @"status";
NSString* const URL = @"url";
NSString* const IMAGE_DATA = @"imageData";
NSString* const VEHICLE_IMAGE = @"vehicleImage";

- (instancetype)init
{
    if (self) {
        [self initializeTable];
        self = [super init];
    }
    return self;
}
/*
 * Initialise Table Name.
 */
-(void)initializeTable{
    
    TableName = @"HomeScreenDataTable";
    
}
/*
 * Creates the db table.
 @query is a query string.
 */
-(BOOL)createTable:(NSString*) query{
    
    NSString *createQuery = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ( id INTEGER PRIMARY KEY AUTOINCREMENT, %@ varchar(100), %@ varchar (255), %@ varchar(255), %@ varchar(255), %@ varchar(255), %@ varchar(255), %@ varchar(255), %@ varchar(255), %@ varchar(255), %@ varchar(255), %@ varchar(255), %@ varchar(255), %@ varchar(255), %@ varchar(255))",TableName,EQUIPMENT_ID,E_NAME,MNF_ID,MNF_NAME,MD_NAME,CN_NAME,YEAR,HOURS_PER_MILES,DAILY,WEEKLY,MONTHLY,SALE_PRICE,STATUS,URL];
   
    return [super createTable:createQuery];
}

/*
 * Insert Data into Employee Table (Value Array is a set of columns values).
 */
-(void)insertUserData:(NSArray*)valuesArray
{
    for (int i=0; i<[valuesArray count]; i++) {
        
        EquipmentDo *equipmentDo = [valuesArray objectAtIndex:i];
        ContentValuesDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%ld",(long)equipmentDo.id ],EQUIPMENT_ID,
                                   equipmentDo.ename,E_NAME,
                                   [NSString stringWithFormat:@"%ld",(long)equipmentDo.mnf_id ],MNF_ID,
                                   equipmentDo.mnfname, MNF_NAME,
                                   equipmentDo.mdname,MD_NAME,
                                   equipmentDo.cname,CN_NAME,
                                   [NSString stringWithFormat:@"%ld",(long)equipmentDo.year],YEAR,
                                   [NSString stringWithFormat:@"%ld",(long)equipmentDo.hour_per_miles],HOURS_PER_MILES,
                                   equipmentDo.daily,DAILY,
                                   equipmentDo.weekly,WEEKLY,
                                   equipmentDo.monthly,MONTHLY,
                                   equipmentDo.sale_price,SALE_PRICE,
                                   equipmentDo.status,STATUS,
                                   equipmentDo.url,URL, nil];
        
        
       // NSLog(@"userContentValues dictionary is: %@ for index: %d",ContentValuesDictionary,i );
        BOOL inserted= [super insertData:ContentValuesDictionary];
       // NSLog(@"Inserted: %d",inserted);
        
    }
    
}


/*
 * Get Data from database (selectedField is a identifier that which you want to be select)
 */
-(NSArray *)getData
{
    NSArray *dataArray = [self getAllDataFromDataBase];
    return dataArray;
    
}


/*
 * Delete Data from database (selectedField is a identifier that which row you want to delete)
 */
-(void)deleteData:(NSString*)selectedField
{
    
    [super deleteData:nil];
    
}


/*
 * Method to get all data from DB
 */
- (NSArray*) getAllDataFromDataBase
{
    
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
  //  NSLog(@"Data base path %@",dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &myDB) == SQLITE_OK) {
        
         NSString *sqlTable = [NSString stringWithFormat:@"SELECT * FROM %@",TableName];
        const char *sql = [sqlTable UTF8String];
        
        sqlite3_stmt *statement = NULL;
        
        if(sqlite3_prepare_v2(myDB, sql, -1, &statement, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(statement) == SQLITE_ROW) {
                EquipmentDo *equipmentDo = [[EquipmentDo alloc]init];
                
                                equipmentDo.id = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]integerValue];
                                equipmentDo.ename = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                                equipmentDo.mnf_id = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)]integerValue];
                                equipmentDo.mnfname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                                equipmentDo.mdname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                                equipmentDo.cname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                                equipmentDo.year = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)]integerValue];
                                equipmentDo.hour_per_miles = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)]integerValue];
                                equipmentDo.daily = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                                equipmentDo.weekly = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                                equipmentDo.monthly = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
                                equipmentDo.sale_price = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
                                equipmentDo.status = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
                                equipmentDo.url = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
                                
                                [resultArray addObject:equipmentDo];
                                
                                

                
                
            }
        }
        
       // NSLog(@"get data %s",sql);
    }
    
    sqlite3_close(myDB);
    return resultArray;

}





@end
