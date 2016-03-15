//
//  LSNewsContentController.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/19.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import "LSNewsContentController.h"
#import "LSHttpTool.h"
#import "MBProgressHUD.h"
#import <WebKit/WebKit.h>
#import "UMSocial.h"
#import "LSCommentController.h"

@interface LSNewsContentController ()<WKNavigationDelegate, UMSocialUIDelegate>
@property(nonatomic, strong)LSNewsContent *content;

@end

@implementation LSNewsContentController


-(instancetype)initWithNewsContent:(LSNewsContent *)newsContent{
    if (self = [super init]) {
        self.content = newsContent;
    }
    return self;
}


-(void)dealloc{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
//    NSLog(@"瞬间爆炸");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWebView];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStyleDone target:self action:@selector(share)];
    UIBarButtonItem *commentItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user_comment"] style:UIBarButtonItemStyleDone target:self action:@selector(showComment)];
    self.navigationItem.rightBarButtonItems = @[shareItem, commentItem];
}

- (void)showComment {
    [self.navigationController pushViewController:[[LSCommentController alloc] initWithSid:self.content.sid SN:self.content.sn] animated:YES];
}

- (void)share{
    NSString *shareUrl = [self shareUrl];
    
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = self.content.title;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.content.title;
    
    [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
    [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
    [UMSocialData defaultData].extConfig.qqData.title = self.content.title;
    [UMSocialData defaultData].extConfig.qzoneData.title = self.content.title;
    
    [UMSocialData defaultData].extConfig.alipaySessionData.alipayMessageType = UMSocialAlipayMessageTypeWeb;
    [UMSocialData defaultData].extConfig.alipaySessionData.url = shareUrl;
    [UMSocialData defaultData].extConfig.alipaySessionData.title = self.content.title;
    
    [UMSocialData defaultData].extConfig.yxsessionData.yxMessageType = UMSocialYXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.yxsessionData.url = shareUrl;
    
    [UMSocialData defaultData].extConfig.yxtimelineData.yxMessageType = UMSocialYXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.yxtimelineData.url = shareUrl;
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56a9db4067e58e42620027af"
                                      shareText:self.content.hometext
                                     shareImage:[UIImage imageNamed:@"ic_launcher"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToYXSession,UMShareToYXTimeline,nil]
                                       delegate:self];
  
}

-(NSString *)shareUrl{
    return [NSString stringWithFormat:@"http://www.cnbeta.com/articles/%@.htm",self.content.sid];
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    if (platformName == UMShareToSina) {
        socialData.shareText = [NSString stringWithFormat:@"%@ %@",self.content.title, [self shareUrl]];
    }
}

-(void)initWebView{
    BOOL autoLoadImage = [[NSUserDefaults standardUserDefaults] boolForKey:AUTOLOADIMAGE];
    NSURL *baseUrl = [[NSBundle mainBundle] bundleURL];
    NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><title></title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\"/> \
                      <link  rel=\"stylesheet\" href=\"style.css\" type=\"text/css\"/><style>.title{color: #??;}??</style> \
                      <script>var config = {enableImage:%d,enableFlashToHtml5:%@};</script> \
                      <script src=\"BaseTool.js\"></script> \
                      <script src=\"ImageTool.js\"></script> \
                      <script src=\"VideoTool.js\"></script></head> \
                      <body><div><div class=\"title\">%@</div><div class=\"from\">%@<span style=\"float: right\">%@</span></div><div id=\"introduce\">%@<div class=\"clear\"></div></div><div id=\"content\">%@</div><div class=\"clear foot\">-- The End --</div></div> \
                      <script src=\"loder.js\"></script></body></html>",autoLoadImage,@"true",self.content.title,self.content.source,self.content.time,self.content.hometext,self.content.bodytext];
    
//    NSLog(@"\n\n%@\n%@\n%@\n%@\n%@",self.content.title,self.content.source,self.content.time,self.content.hometext,self.content.bodytext);
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [webView loadHTMLString:html baseURL:baseUrl];
    [self.view addSubview:webView];
    webView.navigationDelegate = self;
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    if (response.responseCode == UMSResponseCodeSuccess) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
