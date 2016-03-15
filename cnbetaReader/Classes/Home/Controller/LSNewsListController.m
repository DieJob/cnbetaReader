//
//  LSNewsListController.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/17.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import "LSNewsListController.h"
#import "NSString+Tools.h"
#import "LSNewsTool.h"
#import "LSNewsItem.h"
#import "UIImageView+WebCache.h"
#import "LSNewsItemCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJRefresh.h"
#import "LSNewsContentController.h"
#import "MBProgressHUD.h"
#import <WebKit/WebKit.h>
#import "LSPreViewController.h"
#import "LSSettingController.h"



@interface LSNewsListController ()<WKNavigationDelegate, UIViewControllerPreviewingDelegate>

@property(nonatomic, strong)NSMutableArray *newsListArray;
@property(nonatomic, strong)WKWebView *webView;
@property(nonatomic, strong)NSIndexPath *indexPath;
@property(nonatomic, strong)LSPreViewController *preVC;

@end


static NSString *ID = @"cell";

@implementation LSNewsListController

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadYouku"];
    self.webView = nil;
}

-(NSMutableArray *)newsListArray{
    if (!_newsListArray) {
        _newsListArray = [NSMutableArray array];
    }
    return _newsListArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadYouku"] != YES) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://v.youku.com/v_show/id_XNzIyNTU5MTgw.html?from=s1.8-1-1.2"]]];
//        NSLog(@"loadYouku");
    }
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNewsList)];
    BOOL autoRefresh = [[NSUserDefaults standardUserDefaults] boolForKey:AUTOREFRESH];
    if (autoRefresh) {
        [self.tableView.mj_header beginRefreshing];
    }
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNewsList)];
    [self.tableView.mj_footer setAutomaticallyHidden:YES];
//    self.tableView.fd_debugLogEnabled = YES;

//    self.tableView.estimatedRowHeight = 178;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"新闻列表";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user_main_setting"] style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
}

- (void)setting {
    [self.navigationController pushViewController:[[LSSettingController alloc] init] animated:YES];
}

-(void)loadMoreNewsList{
    __weak typeof(self) weakSelf = self;
//    NSLog(@"上拉刷新");
    LSNewsItem *lastItem = self.newsListArray.lastObject;
    [LSNewsTool loadMoreNewsListWithSid:lastItem.sid success:^(NSArray *newsListArray) {
        [weakSelf.newsListArray addObjectsFromArray:newsListArray];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

-(void)refreshNewsList{
    __weak typeof(self) weakSelf = self;
//    NSLog(@"下拉刷新");
    [LSNewsTool loadNewsListWithSuccess:^(NSArray *newsListArray) {
        [weakSelf.newsListArray removeAllObjects];
        [weakSelf.newsListArray addObjectsFromArray:newsListArray];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    
    self.indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    previewingContext.sourceRect = [self.tableView rectForRowAtIndexPath:self.indexPath];
    
    LSNewsItem *item = self.newsListArray[self.indexPath.row];
    
    self.preVC = [[LSPreViewController alloc] initWithSid:item.sid];
    
    return self.preVC;

}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
//    [self tableView:self.tableView didSelectRowAtIndexPath:self.indexPath];
    [self.navigationController pushViewController:self.preVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.tableView reloadData];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSNewsItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    LSNewsItem *newsItem = self.newsListArray[indexPath.row];
    
    cell.newsItem = newsItem;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSNewsItem *item = self.newsListArray[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell setNewsItem:item];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LSNewsItem *item = self.newsListArray[indexPath.row];
    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.userInteractionEnabled = NO;
    hud.labelText = @"玩命加载中( ｡ớ ₃ờ)ھ";
    __weak typeof(self)weakSelf = self;
    [LSNewsTool loadNewsContentWithSid:item.sid success:^(LSNewsContent *newsContent) {
        [weakSelf.navigationController pushViewController:[[LSNewsContentController alloc] initWithNewsContent:newsContent] animated:YES];
    }failure:^(NSError *error) {
        [hud setHidden:YES];
    }];
}


@end
