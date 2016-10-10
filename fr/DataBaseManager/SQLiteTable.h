//
//  SQLiteTable.h
//  SQLiteDataBaseApplication
//
//  Created by Ranjit singh on 7/11/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
extern NSString* const ID;



@interface SQLiteTable : NSObject
{
    sqlite3* myDB ;
    NSString* dbPath;
    sqlite3_stmt *statement;
    NSString* TableName;
  
}
// This method will initialise the database path, and called when the subclass instance is created.
-(void)initialize;

// This method will create the database and open that database.
-(BOOL)createDataBase;

//This method will create the table.
-(BOOL)createTable:(NSString*) query;

//This method is used to insert data into table.
-(BOOL)insertData:(NSDictionary*)contentValues;

//It will fetch the data from database.
-(NSArray*)getData:(NSArray*)columnsArray andWhereClause:(NSString*)whereClause;

//This method is used to delete specific record/row from table.
-(BOOL)deleteData:(NSString*)whereClause;

//This method will update the specific record/row of table.
-(BOOL)updateData:(NSDictionary*)contentValues andWhereClause:(NSString*)whereClause;
@end
