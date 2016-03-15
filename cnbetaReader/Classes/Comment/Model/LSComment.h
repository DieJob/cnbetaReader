//
//  LSComment.h
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/3/12.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 tid: 12585103
 pid: 0
 sid: 483033
 date: 2016-03-13 10:39:45
 name: 匿名人士
 host_name: 中国
 comment: 不好意思，是我前几天扔的按摩棒。
 score: 0
 reason: 0
 userid: 0
 icon:
 */

@interface LSComment : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *host_name;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *icon;

@end
