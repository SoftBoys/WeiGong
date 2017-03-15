//
//  WG_MywalletViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/3.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MywalletViewController.h"

#import "WG_MywalletAccount.h"
#import "WG_MywalletAccountItem.h"

#import "WG_MywalletCell.h"
#import "WG_MywalletHeadView.h"

#import "WG_TableViewGifHeader.h"
#import "WG_TableViewNormalFooter.h"

#import "WG_UserDefaults.h"

@interface WG_MywalletViewController () <WG_MywalletHeadViewDelegate>
@property (nonatomic, assign) NSInteger requestId;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WG_MywalletAccount *account;
@property (nonatomic, strong) WG_MywalletHeadView *headView;
@end
@implementation WG_MywalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    self.headView = [WG_MywalletHeadView new];
    self.headView.frame = CGRectMake(0, 0, kScreenWidth, 80);
    self.headView.delegate = self;
    self.tableView.tableHeaderView = self.headView;
    
    __weak typeof(self) weakself = self;
    self.tableView.mj_header = [WG_TableViewGifHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself wg_getAccountWithPage:weakself.page];
    }];
    self.tableView.mj_footer = [WG_TableViewNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself wg_getAccountWithPage:weakself.page];
    }];
    
    [self wg_getAccountWithPage:self.page];

}
- (void)wg_getAccountWithPage:(NSInteger)page {
    
    __block dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group);
    
    WGBaseRequest *request_wallet = [WGBaseRequest wg_requestWithUrl:@"/linggb-ws/ws/0.1/account/getAccountById"];
    NSString *useid = [WG_UserDefaults shareInstance].userId ?: @"";
    request_wallet.wg_parameters = @{@"personalInfoId":useid};
    [request_wallet wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        WGLog(@"我的钱包");
        if (response.responseJSON) {
            WG_MywalletAccount *account = [WG_MywalletAccount mj_objectWithKeyValues:response.responseJSON];
            self.account = account;
            self.headView.account = account;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    
    WGBaseRequest *request_account = [WGBaseRequest wg_requestWithUrl:@"/linggb-ws/ws/0.1/account/accountList"];
    request_account.wg_parameters = @{@"pageNum":@(page), @"pageSize":@15};
    [request_account wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        WGLog(@"账户列表");
        if (response.responseJSON) {
            if (page == 0) {
                [self.dataArray removeAllObjects];
            }
            NSArray *itemArray = [WG_MywalletAccountItem mj_objectArrayWithKeyValuesArray:response.responseJSON[@"items"]];
            [self.dataArray addObjectsFromArray:itemArray];
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        WGLog(@"队列完成");
        [self.tableView reloadData];

    });
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WG_MywalletCell *cell = [WG_MywalletCell wg_cellWithTableView:self.tableView];
    cell.item = self.dataArray[indexPath.row];
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 10;
}
#pragma mark - WG_MywalletHeadViewDelegate
- (void)wg_tapDetail {
    // TODO: 点击明细
    WGLog(@"点击明细");
}
- (void)wg_tapCash {
    // TODO: 点击提现
    WGLog(@"点击提现");
}
#pragma mark - getter && setter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
@end
