//
//  WG_SettingViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_SettingViewController.h"
#import "WG_SettingCell.h"
#import "WG_SettingLoginoutView.h"
#import "WG_WebViewController.h"
#import "WG_AboutUsViewController.h"
#import "WGChangePassViewController.h"
#import "WGUserFeedbackViewController.h"

#import "UIAlertController+Addition.h"
#import "WG_UserDefaults.h"

#import "WG_Cache.h"

#import "WGChangeAccountViewController.h"

#import "WGHuanxinTool.h"

#import "WGRequestManager.h"

@interface WG_SettingViewController ()
@property (nonatomic, copy) NSArray *dataArray;
@end
@implementation WG_SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    __weak typeof(self) weakself = self;
    WG_SettingLoginoutView *loginoutView = [WG_SettingLoginoutView loginoutViewWithTap:^{
        [weakself askLoginout];
    }];
    loginoutView.frame = CGRectMake(0, 0, kScreenWidth, 60);
    self.tableView.tableFooterView = loginoutView;
    self.tableView.rowHeight = 44;
}
- (void)askLoginout {
    NSString *title = @"提醒";
    NSString *message = @"您确定要退出吗?";
    [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger index) {
        if (index) {
            [self wg_loginout];
            [[WG_UserDefaults shareInstance] loginOut];
            [WGHuanxinTool wg_loginout];
            [self wg_popToRootVC];
//            [self.navigationController popViewControllerAnimated:YES];
            
        }
    } cancel:@"取消" sure:@"退出"];
    
}
- (void)wg_loginout {
    NSString *adminUserId = [WG_UserDefaults shareInstance].adminUserId;
    NSDictionary *param = nil;
    if (adminUserId) {
        param = @{@"adminUserId":adminUserId};
    }
    NSString *url = [self wg_loginoutUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = param;
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        
    }];
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WG_SettingCell *cell = [WG_SettingCell wg_cellWithTableView:self.tableView];
    cell.item = self.dataArray[indexPath.row];
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 20;
}
#pragma mark - UITableViewDelegate
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WG_SettingItem *item = self.dataArray[indexPath.row];

    // TODO:跳转页面
    if (item.isCache) {
        NSString *title = @"温馨提醒";
        NSString *message = @"是否要清除缓存?";
        [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger buttonIndex) {
            if (buttonIndex) {
                [WG_Cache wg_clearCaches];
                self.dataArray = nil;
                [self.tableView reloadData];
            }
        } cancel:@"取消" sure:@"确定"];
        return;
    }
    
    if (indexPath.row == 0) { // 更换账号
        WGChangeAccountViewController *changeVC = [WGChangeAccountViewController new];
        changeVC.title = item.name;
        [self wg_pushVC:changeVC];
    } else if (indexPath.row == 1) { // 修改密码
        WGChangePassViewController *changePassVC = [WGChangePassViewController new];
        changePassVC.title = item.name;
        [self wg_pushVC:changePassVC];
        
    } else if (indexPath.row == 2) {
        
    } else if (indexPath.row == 3) { // 用户反馈
        WGUserFeedbackViewController *feedbackVC = [WGUserFeedbackViewController new];
        feedbackVC.title = item.name;
        [self wg_pushVC:feedbackVC];
    } else if (indexPath.row == 4) { // 帮助
        WG_WebViewController *helpVC = [[WG_WebViewController alloc] init];
        helpVC.title = @"帮助";
        helpVC.webUrl = [WG_UserDefaults shareInstance].helpUrl;
        [self wg_pushVC:helpVC];
    } else if (indexPath.row == 5) { // 关于
        WG_AboutUsViewController *aboutVC = [WG_AboutUsViewController new];
        [self wg_pushVC:aboutVC];
    } else if (indexPath.row == 6) { // 评分
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kCommentUrl]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kCommentUrl]];
        }
    }
    
}

- (void)dealloc {
    [WGRequestManager cancelTaskWithUrl:[self wg_loginoutUrl]];
}
- (NSString *)wg_loginoutUrl {
    return @"/linggb-ws/ws/0.1/person/logout";
}
#pragma mark - getter && setter
- (NSArray *)dataArray {
    if (!_dataArray) {
        NSMutableArray *muArray = [NSMutableArray new];
        NSArray *titles = @[@"更换账号",@"修改密码",@"工作状态",@"用户反馈",@"帮助",@"关于",@"给我们评分",@"清除缓存"];
        for (NSUInteger i = 0; i < titles.count; i++) {
            WG_SettingItem *item = [WG_SettingItem new];
            item.name = titles[i];
            item.isCache = (i == titles.count - 1);
            if (item.isCache) {
                item.cache = [NSString stringWithFormat:@"(%@)", [self wg_caches]];
            }
            if (i == 2) {
                item.isSwitch = YES;
            }
            item.status = self.status;
            [muArray addObject:item];
        }
        _dataArray = [muArray copy];
    }
    return _dataArray;
}

/** 设置显示的缓存数据 */
- (NSString *)wg_caches {
    // 默认为K
    long long size_k = [WG_Cache wg_getCaches];
    
    NSInteger unit = 1024;
    double size_m = size_k * 1.00 / unit;
    if (size_m >= 1) {
        return [NSString stringWithFormat:@"%.2fM", size_m];
    }
    return [NSString stringWithFormat:@"%lldK", size_k];
}

@end
