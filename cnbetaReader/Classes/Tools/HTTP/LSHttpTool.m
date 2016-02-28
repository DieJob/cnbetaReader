//
//  LSHttpTools.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/17.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//
//  HTTP工具类

#import "LSHttpTool.h"
#import "AFHTTPSessionManager.h"

@implementation LSHttpTool

+(void)GET:(NSString *)url parameters:(NSDictionary *)params getContent:(BOOL)content success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if (content) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else{
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
