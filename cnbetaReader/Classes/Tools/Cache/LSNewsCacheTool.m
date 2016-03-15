//
//  LSNewsCacheTool.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/3/12.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//
//  留个坑，先去b站逛一圈

#import "LSNewsCacheTool.h"
#import "FMDB.h"
#import "LSNewsItem.h"

static FMDatabase *_db;

@implementation LSNewsCacheTool

+ (void)initialize {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [cachePath stringByAppendingPathComponent:@"cache.sqlite"];
    
    _db = [FMDatabase databaseWithPath:dbPath];
    
    if ([_db open]) {
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_newsList (id integer PRIMARY KEY AUTOINCREMENT, sid text NOT NULL, news_list blob NOT NULL)"];
        if (result) {
            NSLog(@"创建成功");
        }else{
            NSLog(@"创建失败");
        }
    }
}


+ (void)saveNewsList:(NSArray *)newsList {
    
}


@end
