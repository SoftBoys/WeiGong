//
//  WGWorkMessageListViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/18.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkMessageListViewController.h"
#import "WGRequestManager.h"
#import "WGWorkMessageListItem.h"
#import "WGWorkMessageListCell.h"

#import "WG_JobDetailViewController.h"
#import "WG_WebViewController.h"

@interface WGWorkMessageListViewController ()
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation WGWorkMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sepLineColor = kClearColor;
    
    /** 改变工作列表状态 */
    [self wg_didChangeStatus];
}
- (void)wg_didChangeStatus {
    /** 改变工作信息状态 */
    NSString *url = @"/linggb-ws/ws/0.1/usermsg/updateUserMsgStatus";
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url];
    request.wg_parameters = @{@"userFlag":@(2), @"msgType":@(2)};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        
    }];
}
- (void)wg_loadData {
    [self wg_loadDataWithPage:kDefaultPage];
}
- (void)wg_loadDataWithPage:(NSInteger)page {
    self.page = page;
    NSString *url = [self requestUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url];
    request.wg_parameters = @{@"userFlag":@(2), @"pageNum":@(self.page), @"pageSize":@(15)};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.responseJSON) {
            if (self.page == kDefaultPage) {
                [self.dataArray removeAllObjects];
            }
//            WGLog(@"worklist:%@", response);
            NSArray *items = response.responseJSON[@"items"];
            if ([items isKindOfClass:[NSArray class]]) {
                NSArray *workItems = [WGWorkMessageListItem wg_modelArrayWithDictArray:items];
                [self.dataArray wg_addObjectsFromArray:workItems];
            }
            [self.tableView wg_reloadData];
        }
    }];
    
}
#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGWorkMessageListItem *item = self.dataArray[indexPath.row];
    WGWorkMessageListCell *cell = [WGWorkMessageListCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WGWorkMessageListItem *item = self.dataArray[indexPath.row];
    
    if (item.openFlag == 1) {
        WG_JobDetailViewController *jobVC = [WG_JobDetailViewController new];
        jobVC.jobId = item.openContent;
        [self wg_pushVC:jobVC];
    } else if (item.openFlag == 2) {
        WG_WebViewController *webVC = [WG_WebViewController new];
        webVC.webUrl = item.openContent;
        webVC.title = item.openTitle;
        [self wg_pushVC:webVC];
    } else if (item.openFlag == 3) {
        [self phoneWithNumber:item.openContent];
    }
}
- (void)phoneWithNumber:(NSString *)number {
    if (number == nil) {
        WGLog(@"phoneNumber is nil");
        return;
    }
    
    if ([[UIDevice wg_platformString] hasPrefix:@"iPhone"]) {
        UIWebView *phoneView = [[UIWebView alloc]init];
        NSURL *callUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",number]];
        NSURLRequest *request = [NSURLRequest requestWithURL:callUrl];
        [phoneView loadRequest:request];
        [self.view addSubview:phoneView];
    } else {
        
        [UIAlertController wg_alertWithTitle:@"提示" message:@"您的设备不能打电话" completion:^(UIAlertController *alert, NSInteger index) {
            
        } cancel:@"确定" sure:nil];
    }
}
#pragma mark - getter && setter 

- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/usermsg/getUserMessagePage";
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (void)dealloc {
    NSString *url = @"/linggb-ws/ws/0.1/usermsg/updateUserMsgStatus";
    [WGRequestManager cancelTaskWithUrl:url];
}
@end
