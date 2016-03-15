//
//  LSNewsListTool.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/17.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//
//  新闻列表获取工具类

#import "LSNewsTool.h"
#import "LSHttpTool.h"
#import "LSNewsItem.h"
#import "MJExtension.h"
#import "NSString+Tools.h"
#import "AFHTTPSessionManager.h"
#import "ObjectiveGumbo.h"

#define VIDEOWIDTH ([UIScreen mainScreen].bounds.size.width - 20)

@implementation LSNewsTool

+(void)loadNewsListWithSuccess:(void (^)(NSArray *))success failure:(void(^)(NSError * error))failure{
    NSString *timestamp = [NSString getTimestamp];
    NSString *appkey_md5 = [NSString createMD5:[NSString stringWithFormat:@"app_key=10000&format=json&method=Article.Lists&timestamp=%@&v=1.0&mpuffgvbvbttn3Rc",timestamp]];
    NSString *url = [NSString stringWithFormat:@"http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.Lists&timestamp=%@&v=1.0&sign=%@",timestamp,appkey_md5];
    
    [LSHttpTool GET:url parameters:nil getContent:NO success:^(id responseObject) {
        NSArray *newsList = [LSNewsItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
//        LSNewsItem *item = newsList[0];
//        NSLog(@"%@",item.summary);
        if (success) {
            success(newsList);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

//467877

+(void)loadMoreNewsListWithSid:(NSString *)sid success:(void (^)(NSArray *))success failure:(void(^)(NSError * error))failure{
    NSString *timestamp = [NSString getTimestamp];
    NSString *appkey_md5 = [NSString createMD5:[NSString stringWithFormat:@"app_key=10000&end_sid=%@&format=json&method=Article.Lists&timestamp=%@&topicid=null&v=1.0&mpuffgvbvbttn3Rc",sid,timestamp]];
    NSString *url = [NSString stringWithFormat:@"http://api.cnbeta.com/capi?app_key=10000&end_sid=%@&format=json&method=Article.Lists&timestamp=%@&topicid=null&v=1.0&mpuffgvbvbttn3Rc&sign=%@",sid,timestamp,appkey_md5];
    
    [LSHttpTool GET:url parameters:nil getContent:NO success:^(id responseObject) {
        NSArray *newsList = [LSNewsItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        if (success) {
            success(newsList);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)loadNewsContentWithSid:(NSString *)sid success:(void (^)(LSNewsContent *))success failure:(void(^)(NSError * error))failure{
    NSString *url = [NSString stringWithFormat:@"http://www.cnbeta.com/articles/%@.htm",sid];
    [LSHttpTool GET:url parameters:nil getContent:YES success:^(id responseObject) {
//        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        
        OGNode *node = [ObjectiveGumbo parseNodeWithData:responseObject];
        OGElement *el = [node elementsWithClass:@"content"].lastObject;
        LSNewsContent *content = [[LSNewsContent alloc] init];
        
        content.sid = sid;
        
        NSRange range1 = [el.html rangeOfString:@"<script type=\"text/javascript\" src=\"http://yuntv.letv.com/bcloud.js\">"];
        NSMutableString *bodyText = [el.html mutableCopy];
        
        if (range1.location != NSNotFound) {
            NSString *str = [NSString stringWithFormat:@"<script type=\"text/javascript\"> \
                             if(!!letvcloud_player_conf){ \
                             letvcloud_player_conf.width = \"%f\", \
                             letvcloud_player_conf.height = \"%f\" \
                             }</script>", VIDEOWIDTH, VIDEOWIDTH * 10 / 16];
            [bodyText insertString:str atIndex:range1.location];
        }
        
        NSRange range2 = [node.text rangeOfString:@"\",SN:\""];
        if (range2.location != NSNotFound) {
            content.sn = [node.text substringWithRange:NSMakeRange(range2.location + range2.length, 5)];
        }
        
        
        content.bodytext = bodyText;
        el = [node elementsWithClass:@"introduction"].lastObject;
        content.hometext = el.text;
        el = [node elementsWithID:@"news_title"].lastObject;
        content.title = el.text;
        el = [node elementsWithClass:@"where"].lastObject;
        content.source = el.html;
        el = [node elementsWithClass:@"date"].lastObject;
        content.time = el.text;
        if (success) {
            success(content);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
