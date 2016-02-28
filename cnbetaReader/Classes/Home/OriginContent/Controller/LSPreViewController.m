//
//  LSPreViewController.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/26.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import "LSPreViewController.h"
#import <WebKit/WebKit.h>

@interface LSPreViewController ()<WKNavigationDelegate>

@property (nonatomic, copy) NSString *sid;
@property (nonatomic, weak) UIProgressView *progressView;
@property (nonatomic, weak) WKWebView *webView;

@end

@implementation LSPreViewController

-(instancetype)initWithSid:(NSString *)sid{
    if (self = [super init]) {
        self.sid = sid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.cnbeta.com/articles/%@.htm",self.sid];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    [self.view addSubview:webView];
    self.webView = webView;
    
    UIProgressView *progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
    progress.progressViewStyle = UIProgressViewStyleBar;
    [self.view addSubview:progress];
    self.progressView = progress;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqual: @"estimatedProgress"]) {
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
    }
}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.progressView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
