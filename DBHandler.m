//
//  DBHandler.m
//  InsertData
//
//  Created by r shah on 29/08/13.
//  Copyright (c) 2013 r shah. All rights reserved.
//

#import "DBHandler.h"
@implementation DBHandler
-(id)init{
    self = [super init];
    if(self){
        arrData = [[NSMutableArray alloc]init];
        dicData = [[NSMutableDictionary alloc]init];
    }
    return self;
}
-(void)dealloc{
    arrData=nil;
    dicData=nil;
}
-(void)checkDBAndCopy{
 
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
    strDBPath = [documentsDir stringByAppendingPathComponent:@"TextMsg.sqlite"];
    
    //(@"%@",strDBPath);
    
	NSFileManager *fileManager = [[NSFileManager alloc]init];
    
	if (![fileManager fileExistsAtPath:strDBPath]) {
        
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TextMsg.sqlite"];
        
        [fileManager copyItemAtPath:databasePathFromApp toPath:strDBPath error:nil];
        
        //(@"%@",databasePathFromApp);
        
    }
}
-(BOOL) insertData:(NSString *)query{
    [self checkDBAndCopy];
    BOOL success= NO;
    
      if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK) {
        
        sqlite3_stmt *stmt;
        
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &stmt, NULL)==SQLITE_OK) {
            
            sqlite3_step(stmt);
            success = YES;
            //(@"success = yes");
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(contactDB);
    
    return success;
}
-(BOOL)CheckDataFromDB:(NSString *)query{
    
    BOOL Success = NO;
    
    //  [self checkAndCreateDatabase];
    
    if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK) {
        
        sqlite3_stmt *stmt;
        
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &stmt, NULL)==SQLITE_OK) {
            
            while (sqlite3_step(stmt)==SQLITE_ROW) {
                
                 Success = YES;
                
                break;
            }
            
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(contactDB);
    
    return Success;
    
}
- (NSMutableArray *)ShowTblAdminLogin:(NSString *)query
{
    [arrData removeAllObjects];
    [self checkDBAndCopy];
    if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK) {
        
        sqlite3_stmt *stmt;
        
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &stmt, NULL)==SQLITE_OK) {
            
            while (sqlite3_step(stmt)==SQLITE_ROW) {
                dicData =[[NSMutableDictionary alloc]init];
                [dicData setObject:[[NSString alloc]initWithFormat:@"%s",sqlite3_column_text(stmt,0)] forKey:@"AdmLog_id"];
                [dicData setObject:[[NSString alloc]initWithFormat:@"%s",sqlite3_column_text(stmt,1)] forKey:@"Email_id"];
                [dicData setObject:[[NSString alloc]initWithFormat:@"%s",sqlite3_column_text(stmt,2)] forKey:@"Password"];
                [dicData setObject:[[NSString alloc]initWithFormat:@"%s",sqlite3_column_text(stmt,3)] forKey:@"deviceUUID"];
                [dicData setObject:[[NSString alloc]initWithFormat:@"%s",sqlite3_column_text(stmt,4)] forKey:@"FlagON"];
                [dicData setObject:[[NSString alloc]initWithFormat:@"%s",sqlite3_column_text(stmt,5)] forKey:@"FlagOFF"];
                [arrData addObject:dicData];
                NSLog(@"%@",arrData);
            }
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(contactDB);
    
    return arrData;
    dicData=nil;
}
@end
