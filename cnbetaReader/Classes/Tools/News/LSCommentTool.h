//
//  LSCommentTool.h
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/3/12.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCommentTool : NSObject

+ (void)loadCommentListWithSid:(NSString *)sid pageNum:(NSString *)page SN:(NSString *)sn success:(void(^)(NSArray *commentListArray))success failure:(void(^)(NSError * error))failure;


@end
