//
//  LSCommentTool.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/3/12.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import "LSCommentTool.h"
#import "LSHttpTool.h"
#import "NSString+Tools.h"
#import "MJExtension.h"
#import "LSComment.h"
#import "LSCmntlist.h"


@implementation LSCommentTool

//http://api.cnbeta.com/capi?app_key=10000&article=&format=json&method=phone.Comment&timestamp=&v=1.0&sign=


+ (void)loadCommentListWithSid:(NSString *)sid pageNum:(NSString *)page SN:(NSString *)sn success:(void (^)(NSArray *))success failure:(void(^)(NSError * error))failure{
    NSString *url = [NSString stringWithFormat:@"http://www.cnbeta.com/cmt?op=%@,%@,%@",page,sid,sn];
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    [headers setObject:@"XMLHttpRequest" forKey:@"X-Requested-With"];
    [headers setObject:@"http://www.cnbeta.com/" forKey:@"Referer"];

    [LSHttpTool GET:url parameters:nil headers:headers success:^(id responseObject) {
        NSArray *cmList = [LSCmntlist mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"cmntlist"]];
        
        NSMutableArray *commentArr = [NSMutableArray array];
        for (LSCmntlist *temp in cmList) {
            LSComment* comment = [LSComment mj_objectWithKeyValues:responseObject[@"result"][@"cmntstore"][temp.tid]];
            [commentArr addObject:comment];
        }
        if (success) {
            success(commentArr);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}



@end
