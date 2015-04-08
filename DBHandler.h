//
//  DBHandler.h
//  InsertData

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBHandler : NSObject
{
    sqlite3 *contactDB;
    NSString *strDBPath;
    NSMutableArray *arrData;
    NSMutableDictionary *dicData;
}
-(void)checkDBAndCopy;

-(BOOL) insertData:(NSString *)query;
-(BOOL)CheckDataFromDB:(NSString *)query;

- (NSMutableArray *)ShowTblAdminLogin:(NSString *)query;
@end
