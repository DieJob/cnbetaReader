//
//  LSCommentController.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/3/12.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import "LSCommentController.h"
#import "LSCommentCell.h"
#import "MJRefresh.h"
#import "LSCommentTool.h"
#import "UITableView+FDTemplateLayoutCell.h"



@interface LSCommentController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSMutableArray *commentArray;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *sn;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation LSCommentController

- (NSMutableArray *)commentArray{
    if (_commentArray == nil) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

- (instancetype)initWithSid:(NSString *)sid SN:(NSString *)sn{
    if (self = [self init]) {
        _sid = [sid copy];
        _sn = [sn copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageNum = 1;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//    self.tableView.estimatedRowHeight = 178;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [tableView registerNib:[UINib nibWithNibName:@"LSCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CommentCell"];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadComments)];
    
//    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
//    [tableView.mj_footer setAutomaticallyHidden:YES];
    
    [tableView.mj_header beginRefreshing];
    
}

//- (void)loadMoreComments {
//    __weak typeof(self)weakSelf = self;
//    self.pageNum ++;
//    [LSCommentTool loadCommentListWithSid:self.sid pageNum:[NSString stringWithFormat:@"%tu",self.pageNum] SN:self.sn success:^(NSArray *commentListArray) {
//        [weakSelf.commentArray addObjectsFromArray:commentListArray];
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    }];
//}

- (void)loadComments {
    __weak typeof(self)weakSelf = self;
    self.pageNum = 1;
    [LSCommentTool loadCommentListWithSid:self.sid pageNum:[NSString stringWithFormat:@"%tu",self.pageNum] SN:self.sn success:^(NSArray *commentListArray) {
        [weakSelf.commentArray removeAllObjects];
        [weakSelf.commentArray addObjectsFromArray:commentListArray];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    LSComment *comment = self.commentArray[indexPath.row];
    cell.comment = comment;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSComment *comment = self.commentArray[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:@"CommentCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell setComment:comment];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
