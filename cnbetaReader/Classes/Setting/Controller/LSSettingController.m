//
//  LSSettingController.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/3/12.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import "LSSettingController.h"



@interface LSSettingController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISwitch *autoLoadImageSwitch;
@property (nonatomic, strong) UISwitch *autoRefreshSwitch;

@end

@implementation LSSettingController

- (UISwitch *)autoRefreshSwitch{
    if (!_autoRefreshSwitch) {
        _autoRefreshSwitch = [[UISwitch alloc] init];
        _autoRefreshSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:AUTOREFRESH];
        [_autoRefreshSwitch addTarget:self action:@selector(autoRefresh) forControlEvents:UIControlEventTouchUpInside];
    }
    return _autoRefreshSwitch;
}

- (UISwitch *)autoLoadImageSwitch{
    if (!_autoLoadImageSwitch) {
        _autoLoadImageSwitch = [[UISwitch alloc] init];
        _autoLoadImageSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:AUTOLOADIMAGE];
        [_autoLoadImageSwitch addTarget:self action:@selector(imageLoadSetting) forControlEvents:UIControlEventTouchUpInside];
    }
    return _autoLoadImageSwitch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelection = NO;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"自动加载正文图片";
            cell.accessoryView = self.autoLoadImageSwitch;
            break;
        case 1:
            cell.textLabel.text = @"首次启动自动刷新";
            cell.accessoryView = self.autoRefreshSwitch;
        default:
            break;
    }
    return cell;
}

- (void)imageLoadSetting {
    [[NSUserDefaults standardUserDefaults] setBool:self.autoLoadImageSwitch.isOn forKey:AUTOLOADIMAGE];
}

- (void)autoRefresh {
    [[NSUserDefaults standardUserDefaults] setBool:self.autoRefreshSwitch.isOn forKey:AUTOREFRESH];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    self.autoLoadImageSwitch = nil;
}


@end
