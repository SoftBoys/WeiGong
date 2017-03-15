//
//  WGAccountViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGAccountViewController.h"
#import "WGAddAccountViewController.h"

#import "WGAccountListItem.h"
#import "WGAccountInfo.h"
#import "WGAccountListCell.h"
#import "WGBaseNoHightButton.h"

#import "WGActionSheet.h"

#import "WGRequestManager.h"

@interface WGAccountViewController () <WGAccountListCellDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSArray *accountInfoArray;
@property (nonatomic, strong) WGBaseNoHightButton *addButton;
@end

@implementation WGAccountViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView flashScrollIndicators];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户管理";
//    self.dataArray = @[@"", @"", @"", @""].mutableCopy;
    self.sepLineColor = kClearColor;
    
//    self.tableView.editing = YES;
    [self setAddItem];
}
- (void)setAddItem {
    [self.navBar addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight);
        make.right.bottom.mas_equalTo(0);
        make.width.height.mas_equalTo(kNavigationBarHeight);
    }];
    self.addButton.hidden = YES;
}

- (void)wg_loadData {
//    return;
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:self.requestUrl];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
                NSArray *accountList = response.responseJSON[@"accountInfo"];
                NSArray *accountInfoArray = [WGAccountInfo wg_modelArrayWithDictArray:accountList];
                self.accountInfoArray = accountInfoArray;
                self.addButton.hidden = accountList.count == 0;
                NSArray *paymentList = response.responseJSON[@"paymentList"];
                NSArray *list = [WGAccountListItem wg_modelArrayWithDictArray:paymentList];
                self.dataArray = list.mutableCopy;
                [self.tableView wg_reloadData];
            }
        }
    }];
}
#pragma mark - 代理方法

- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGAccountListItem *item = self.dataArray[indexPath.section];
    WGAccountListCell *cell = [WGAccountListCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    cell.delegate = self;
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return 1;
    return [self.dataArray count];
}
- (NSInteger)wg_numberOfSections {
    return [self.dataArray count];
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 12.0;
}
#pragma mark - Cell滑动删除方法
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        WGAccountListItem *item = self.dataArray[indexPath.section];
        [self deleteAccountWithItem:item section:indexPath.section];
//        [dataArray removeObjectAtIndex:indexPath.row];
//        // Delete the row from the data source.
//        [testTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}



#pragma mark - WGAccountListCellDelegate
- (void)tapAccountBoxWithItem:(WGAccountListItem *)item {
    
    if (item.accountDefault == 1) return;
    NSString *title = @"温馨提示";
    NSString *message = @"确定要设为默认账户吗?";
    NSString *cancel = @"取消", *sure = @"确定";
    [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger index) {
        if (index) {
            [self setDefaultAccount:item];
        }
    } cancel:cancel sure:sure];
}
#pragma mark - 设置默认账户
- (void)setDefaultAccount:(WGAccountListItem *)item {
//    item.accountDefault = 1;
//    [self.tableView wg_reloadData];
//    return;
    [MBProgressHUD wg_showHub_CanTap];
    NSString *url = [self defaultAccountUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = @{@"paymentAccountId":@(item.paymentAccountId)};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        [MBProgressHUD wg_hideHub];
        if (response.statusCode == 200) {
            [self wg_loadData];
        } else {
            NSString *message = response.responseJSON[@"content"];
            if (message) {
                [MBProgressHUD wg_message:message];
            }
        }
    }];
}
#pragma mark - 删除账户
- (void)deleteAccountWithItem:(WGAccountListItem *)item section:(NSInteger)section {
    [MBProgressHUD wg_showHub_CanTap];
    NSString *url = [self deleteAccountUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = @{@"paymentAccountId":@(item.paymentAccountId)};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        [MBProgressHUD wg_hideHub];
        if (response.statusCode == 200) {
            [self.dataArray wg_removeObject:item];
            [self.tableView wg_deleteSingleSection:section];
        } else {
            NSString *message = response.responseJSON[@"content"];
            if (message) {
                [MBProgressHUD wg_message:message];
            }
        }
    }];
}
- (NSString *)deleteAccountUrl {
    return @"/linggb-ws/ws/0.1/payment/deletePayment";
}
- (NSString *)defaultAccountUrl {
    return @"/linggb-ws/ws/0.1/payment/setDafault";
}
#pragma mark - private
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/payment/getPaymentList_v3";
}
- (void)dealloc {
    [WGRequestManager cancelTaskWithUrl:[self defaultAccountUrl]];
    [WGRequestManager cancelTaskWithUrl:[self deleteAccountUrl]];
}
#pragma mark - getter && setter 
- (WGBaseNoHightButton *)addButton {
    if (!_addButton) {
        _addButton = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"account_add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
- (void)showActionSheet {
    
    NSMutableArray *titles = @[].mutableCopy;
    for (WGAccountInfo *info in self.accountInfoArray) {
        [titles wg_addObject:info.accountTypeName];
    }
    [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
        if (index) {
            if (index > self.accountInfoArray.count) return ;
            WGAccountInfo *info = self.accountInfoArray[index-1];
            [self pushVCWithInfo:info];
        }
    } cancel:nil others:titles];
}

- (void)pushVCWithInfo:(WGAccountInfo *)info {
    __weak typeof(self) weakself = self;
    WGAddAccountViewController *addVC = [WGAddAccountViewController new];
    addVC.info = info;
    addVC.saveAccountSuccessHandle = ^() {
        __strong typeof(weakself) strongself = weakself;
        [strongself wg_loadData];
        [strongself wg_popToVC:strongself];
    };
    [self wg_pushVC:addVC];
}
@end
