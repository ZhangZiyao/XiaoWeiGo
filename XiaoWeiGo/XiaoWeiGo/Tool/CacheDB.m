//
//  CacheDB.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "CacheDB.h"
#import "FMDB.h"

#define cachePath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

static FMDatabase *_db;
static NSInteger const cacheTime = 0 ;

@implementation CacheDB
#pragma mark -- 数据库实例

+ (void)initialize{
    NSString * bundleName =[[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey];
    NSString *dbName=[NSString stringWithFormat:@"%@%@",bundleName,@".sqlite"];
    NSString *filename = [cachePath stringByAppendingPathComponent:dbName];
    _db = [FMDatabase databaseWithPath:filename];
    if ([_db open])
    {
        BOOL res = [_db tableExists:@"XWData"];
        if (!res)
        {
            // 4.创表
            BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS XWData (id integer PRIMARY KEY AUTOINCREMENT, url text NOT NULL, data blob NOT NULL,savetime date);"];
            NSLog(@"\n\n---%@----\n\n",result?@"成功创表":@"创表失败");
            NSLog(@"%@",NSHomeDirectory());
        }
    }
    [_db close];
}
#pragma mark --通过请求参数去数据库中加载对应的数据

+ (NSData *)cachedDataWithUrl:(NSString *)url
{
    NSData * data = [[NSData alloc]init];
    [_db open];
    FMResultSet *resultSet = nil;
    resultSet = [_db executeQuery:@"SELECT * FROM XWData WHERE url = ?", url];
    // 遍历查询结果
    while (resultSet.next)
    {
        NSDate *  time = [resultSet dateForColumn:@"savetime"];
        NSTimeInterval timeInterval = -[time timeIntervalSinceNow];
        if(timeInterval > cacheTime &&  cacheTime!= 0)
        {
            NSLog(@"\n\n     %@     \n\n",@"缓存的数据过期了");
            
        }
        else
        {
            data = [resultSet objectForColumn:@"data"];
        }
    }
    [_db close];
    return data;
}
#pragma mark -- 缓存数据到数据库中
+ (void)saveData:(NSData *)data url:(NSString *)url
{
    [_db open];
    FMResultSet *rs = [_db executeQuery:@"select * from XWData where url = ?",url];
    if([rs next])
    {
        BOOL res  =[_db executeUpdate: @"update XWData set data =?,savetime =? where url = ?",data,[NSDate date],url];
        NSLog(@"\n\n%@     %@\n\n",url,res?@"数据更新成功":@"数据更新失败");
    }
    else
    {
        BOOL res =  [_db executeUpdate:@"INSERT INTO XWData (url,data,savetime) VALUES (?,?,?);",url, data,[NSDate date]];
        NSLog(@"\n\n%@     %@\n\n",url,res?@"数据插入成功":@"数据插入失败");
    }
    [_db close];
}
@end
