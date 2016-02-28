//
//  LSNewsItem.h
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/17.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 
 "sid": "467433",
 "title": "微软：谷歌Chrome和Firefox用户也应该更新IE浏览器",
 "pubtime": "2016-01-16 23:29:59",
 "summary": "微软最近表示，除非用户目前的IE11浏览器已经打上最新补丁，否则即使用户平常使用谷歌Chrome和Firefox浏览器上网，不使用IE浏览器，用户的电脑也可能容易受到攻击和漏洞影响。微软警告说，即使用户不使用IE浏览器，浏览器仍然需要更新，因为浏览器更新之时，其他一些Windows组件也得到了修补。所以，如果用户没有将IE浏览器维持在最新版本，那么操作系统仍然容易受到攻击。",
 "topic": "4",
 "counter": "1948",
 "comments": "14",
 "ratings": "5",
 "score": "-10",
 "ratings_story": "5",
 "score_story": "-10",
 "topic_logo": "http://static.cnbetacdn.com/topics/370fc2611e10cd8.png",
 "thumb": "http://static.cnbetacdn.com/thumb/mini/article/2016/0116/c32dedb1fe509a2.jpg_100x100.jpg"
 */

@interface LSNewsItem : NSObject

@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pubtime;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *counter;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *thumb;

@end
