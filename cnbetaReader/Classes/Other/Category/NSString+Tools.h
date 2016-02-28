//
//  NSString+Tools.h
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/17.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Tools)

+(NSString *)filterHTML:(NSString *)html;

+(NSString *)createMD5:(NSString *)signString;

+(NSString *)getTimestamp;

+(CGRect) stringBoundsWithText:(NSString *)text andMaxSize:(CGSize)size andFont:(UIFont *)font;

@end
