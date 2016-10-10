//
//  SQLiteTable.m
//  SQLiteDataBaseApplication
//
//  Created by Ranjit singh on 7/11/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "SQLiteTable.h"


@implementation SQLiteTable



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
/*
 * Initialise DataBase Path.
 */
-(void)initialize{
    dbPath =NSTemporaryDirectory();
    dbPath = [dbPath stringByAppendingPathComponent:@"FleetRight.sql3"];
  
    //creates the db & & table if not exists.
    [self createDataBase];
}



/*
 * Creates the DB file.
 */
-(BOOL)createDataBase{
    
    int result = sqlite3_open([dbPath UTF8String], &myDB);
    
    if (SQLITE_OK == result) {
        NSLog(@"DB opend/created..");
        //creates the table
        [self createTable:@"Query String"];
        return YES;
        
    }
    return NO;
}
/*
 * Create Table into database.
 */
-(BOOL)createTable:(NSString*) query{
   // NSLog(@"From Super class>> createDataBaseTable>> Query: %@", query);
    
    NSLog(@"Create Query is : %@",query);
    const char* UserTable = [query UTF8String];
    char * errInfo ;
    int result = sqlite3_exec(myDB, UserTable, nil, nil, &errInfo);
    
    if (SQLITE_OK == result) {
        NSLog(@"Table Created");
        return YES;
    }else {
        //NSString* err = [[NSString alloc]initWithUTF8String:errInfo];
        
        NSLog(@"error in creating table :(");
        NSLog(@"Failed to create table result:%d, errInfo=%s",result,errInfo);
        return NO;
    }
    
    
    return YES;
}
/*
 * This method is used to Inserts the data into table
 @contentValues: It is a dictionary which having key that is field/column and value is fieldValue.
 */
-(BOOL)insertData:(NSDictionary*)contentValues
{
    //@columnsArray: It will store all columns of table.
    NSArray *columnsArray = [contentValues allKeys];
    
    //@valuesArray: It will store values of repectives columns.
    NSArray *valuesArray = [contentValues allValues];
    
    NSMutableString* tableColumns = [NSMutableString string];
    NSMutableString* columnValues = [NSMutableString string];
    NSString *column;
    NSString *value;
    
    //Fetch one by one field and values from Dictionary and build string.
    for (int i=0 ; i<[columnsArray count];i++)
    {
        column = [NSString stringWithFormat:@"%@ ",[columnsArray objectAtIndex:i]];
        value = [NSString stringWithFormat:@"%@ ",[valuesArray objectAtIndex:i]];
        if (i==[columnsArray count]-1)
        {
            [tableColumns appendString:[NSString stringWithFormat:@"%@ ",column]];
            [columnValues appendString:[NSString stringWithFormat:@"'%@' ",value]];
        }
        else
        {
            [tableColumns appendString:[NSString stringWithFormat:@"%@, ",column]];
            [columnValues appendString:[NSString stringWithFormat:@"'%@',",value]];
        }
        
    }
//    NSLog(@"tableColumns is : %@",tableColumns);
//    NSLog(@"columnValues is : %@",columnValues);
    
    NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",TableName,tableColumns,columnValues];
    
  //  NSLog(@"Insert Query: %@",insertQuery);
    char* insertError;
    int result1 = sqlite3_exec(myDB, [insertQuery cStringUsingEncoding:NSASCIIStringEncoding], nil, nil, &insertError);
    
    if (SQLITE_OK == result1) {
        NSLog(@"Data Inserted Successfully");
        return YES;
    }
    else {
        NSString* err = [[NSString alloc]initWithUTF8String:insertError];
        NSLog(@"%d: error in adding :(: %@",result1, err);
        return NO;
        
    }
    
    return NO;
    
}
/*
 * This method is used to Get Data from Table.
 @columnsArray: Its a number of fields Array if columnsArray is nil so it will consider All fields.
 @whereClause: Its having where [condition] Ex: name = 'abc'.
 */
-(NSArray*)getData:(NSArray*)columnsArray andWhereClause:(NSString*)whereClause
{
    //sql SELECT command
    //condition= nil;
    NSString *selectQuery;
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    if(columnsArray == nil)
    {
        //if @columnsArray is equal to nil the it will set All fields.
        selectQuery = [NSString stringWithFormat:@"SELECT * FROM %@",TableName];
        
    }
    else
    {
        NSMutableString* tableColumns = [NSMutableString string];
        NSString *column;
        //Fetch one by one field from Array and build string.
        for (int i=0 ; i<[columnsArray count];i++)
        {
            column = [NSString stringWithFormat:@"%@ ",[columnsArray objectAtIndex:i]];
            
            if (i==[columnsArray count]-1)
            {
                [tableColumns appendString:[NSString stringWithFormat:@"%@ ",column]];
                
            }
            else
            {
                [tableColumns appendString:[NSString stringWithFormat:@"%@, ",column]];
                
            }
            
        }
        //if columnsArray is having some fields so fire select query with specifice fields.
        selectQuery = [NSString stringWithFormat:@"SELECT %@ FROM %@ ",tableColumns,TableName];
        
        
    }
    if(whereClause!= nil)
    {
        // if whereClause is having any value so Append it with selectQuery.
        selectQuery = [selectQuery stringByAppendingFormat:@"WHERE %@",whereClause];
        //selectQuery = [selectQuery stringByAppendingString:@"where id = 1"];
       // NSLog(@"select Query is = %@", selectQuery);
        
    }
    
    sqlite3_stmt* sqlStatement;
    int result2 = sqlite3_prepare_v2(myDB, [selectQuery UTF8String], -1, &sqlStatement, NULL);
    
    if(result2 == SQLITE_OK) {
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            //int nameid = (int)sqlite3_column_int(sqlStatement, 0);
            
            for (int i=0 ; i<[columnsArray count];i++)
                
            {
                //char* resultValue = (char*)sqlite3_column_text(sqlStatement, i);
                NSString *resultValue = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(sqlStatement, i)];
                [resultArray addObject:resultValue];
                
            }
            
            //            NSLog(@"Result Array Values is : %@, %@ , %@ , %@",[resultArray objectAtIndex:0],[resultArray objectAtIndex:1],[resultArray objectAtIndex:2],[resultArray objectAtIndex:3]);
            return resultArray;
            //            char* user_name = (char*)sqlite3_column_text(sqlStatement, 0);
            //            char* Address = (char*)sqlite3_column_text(sqlStatement, 1);
            //            char* DOB = (char*)sqlite3_column_text(sqlStatement, 2);
            //            char* info = (char*)sqlite3_column_text(sqlStatement, 3);
            //
            //            NSLog(@"user_name =  %s Address = %s ",user_name,Address);
            
        }
        sqlite3_finalize(sqlStatement);
        NSLog(@"Select OK :)");
    }else {
        NSLog(@"Error in Select :(");
        
    }
    
    return NO;
}




/*
 *This method is used to Delete Data from table.
 @whereClause having the where [condition] that whih row you want to delete. Ex: where Name = 'abc'.
 */
-(BOOL)deleteData:(NSString*)whereClause
{
    
    sqlite3_stmt *sqlStatement;
    //NSString *deleteQuery;
    
   
    
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",TableName,whereClause];
   
    
    if(whereClause == nil)
    {
        //if @columnsArray is equal to nil the it will set All fields.
        deleteQuery = [NSString stringWithFormat:@"DELETE FROM %@",TableName];
        
    }
    
     NSLog(@"Delete statement is = %@",deleteQuery);
    
    if (sqlite3_prepare_v2(myDB, [deleteQuery UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
    {
        if(sqlite3_step(sqlStatement) == SQLITE_DONE)
        {
            NSLog(@"Delete Record Successfully.");
            return YES;
        }
        else
        {
            NSLog(@"Failed to Delete Record.");
            return NO;
        }
        sqlite3_finalize(statement);
    }
    else
    {
        NSLog(@"%s: prepare failure: %s", __FUNCTION__, sqlite3_errmsg(myDB));
        return NO;
        
    }
    
}

/*
 * This method will Update the Table Data.
 @contentValues: It is a dictionary which having key that is field/column and value is repective fieldValue that you want to update.
 @whereClause having the where [condition] that whih row you want to update. Ex: where Name = 'abc'.
 */
-(BOOL)updateData:(NSDictionary*)contentValues andWhereClause:(NSString*)whereClause
{
    NSArray *columnsArray = [contentValues allKeys];
    NSArray *valuesArray = [contentValues allValues];
    NSMutableString* updateString = [NSMutableString string];
    
    NSString *column;
    NSString *value;
    //Fetch one by one field and values from Dictionary and build string.
    for (int i=0 ; i<[columnsArray count];i++)
    {
        column = [NSString stringWithFormat:@"%@ ",[columnsArray objectAtIndex:i]];
        value = [NSString stringWithFormat:@"%@ ",[valuesArray objectAtIndex:i]];
        if (i==[columnsArray count]-1)
        {
            [updateString appendString:[NSString stringWithFormat:@"%@ = ",column]];
            [updateString appendString:[NSString stringWithFormat:@"'%@'",value]];
        }
        else
        {
            [updateString appendString:[NSString stringWithFormat:@"%@ = ",column]];
            [updateString appendString:[NSString stringWithFormat:@"'%@',",value]];
        }
        
    }
   // NSLog(@"tableColumns is : %@",updateString);
    
    NSString *updateQuery = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",TableName,updateString,whereClause];
    NSLog(@"Update query: %@",updateQuery);
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(myDB, [updateQuery UTF8String], -1, &stmt, NULL)==SQLITE_OK) {
        NSLog(@"Query Executed");
        return YES;
    }
    else
    {
        NSLog(@"Failed to update Data");
        return NO;
    }
    sqlite3_finalize(stmt);
    
    
}

@end
