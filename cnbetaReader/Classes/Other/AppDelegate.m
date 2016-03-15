//
//  AppDelegate.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/16.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import "AppDelegate.h"
#import "SDWebImageManager.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialAlipayShareHandler.h"
#import "UMSocialYiXinHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "LSCommentTool.h"

#define UMAPPKEY @"56a9db4067e58e42620027af"
#define WXAPPID @"wxefbcbad8b6bd537e"
#define WXSECRET @"338ab0a390cb36bc0a7bfebd803707f8"
#define QQAPPID @"1105086887"
#define QQAPPKEY @"JK25i9lsyCIeUrrI"
#define ALIPAYAPPID @"2016020201135465"
#define YIXINAPPID @"yx2c5c5be9b13a4f59b755aaf8e1cd4062"
#define WBAPPKEY @"2468318557"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUpUMSocial];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:AUTOREFRESH]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:AUTOREFRESH];
    }
    
//    [LSCommentTool loadCommentListWithSid:@"483033" pageNum:@"1" SN:@"ee5a0" success:^(NSArray *commentListArray) {
//        
//    }];
    
    return YES;
}

- (void)setUpUMSocial{
    [UMSocialData setAppKey:UMAPPKEY];
    
    [UMSocialWechatHandler setWXAppId:WXAPPID appSecret:WXSECRET url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKEY url:@"http://www.umeng.com/social"];
//    [UMSocialAlipayShareHandler setAlipayShareAppId:ALIPAYAPPID];
    [UMSocialYixinHandler setYixinAppKey:YIXINAPPID url:@"http://www.umeng.com/social"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:WBAPPKEY RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToYXSession,UMShareToYXTimeline]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
