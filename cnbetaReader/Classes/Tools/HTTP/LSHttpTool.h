//
//  LSHttpTools.h
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/17.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSHttpTool : NSObject

+(void)GET:(NSString *)url parameters:(NSDictionary *)params getContent:(BOOL)content success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;

+(void)GET:(NSString *)url parameters:(NSDictionary *)params headers:(NSDictionary *)headers success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;

@end
