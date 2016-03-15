//
//  LSNewsContent.h
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/19.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSNewsContent : NSObject

@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *hometext;
@property (nonatomic, copy) NSString *bodytext;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *sn;

@end
