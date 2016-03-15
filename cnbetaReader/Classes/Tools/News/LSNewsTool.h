//
//  LSNewsListTool.h
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/17.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSNewsContent.h"

@interface LSNewsTool : NSObject

+(void)loadNewsListWithSuccess:(void(^)(NSArray *newsListArray))success failure:(void(^)(NSError * error))failure;

+(void)loadMoreNewsListWithSid:(NSString *)sid success:(void(^)(NSArray *newsListArray))success failure:(void(^)(NSError * error))failure;
+(void)loadNewsContentWithSid:(NSString *)sid success:(void(^)(LSNewsContent *newsContent))success failure:(void(^)(NSError * error))failure;

@end
