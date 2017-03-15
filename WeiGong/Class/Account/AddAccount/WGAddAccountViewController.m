//
//  WGAddAccountViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGAddAccountViewController.h"
#import "WGAccountInfo.h"
#import "WGAddAccountCell.h"
#import "WGAddAccountFootView.h"

#import "WGAddAccountParam.h"
#import "WGActionSheet.h"

@interface WGAddAccountViewController () <WGAddAccountCellDelegate>
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) WGAddAccountFootView *footView;
@end

@implementation WGAddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger accountid = [self.info.accountType integerValue];
    if (accountid == 160101) {
        self.title = @"添加支付宝账号";
    } else if (accountid == 160102) {
        self.title = @"添加银行卡号";
    }
    
    self.dataArray = [self arrayWithInfo:self.info];
    
    self.tableView.tableFooterView = self.footView;
    
}

- (NSArray *)arrayWithInfo:(WGAccountInfo *)info {
    NSInteger accountid = [info.accountType integerValue];
    NSArray *titles = nil;
    if (accountid == 160101) {
        titles = @[@"真实姓名",@"支付宝账号"];
    } else if (accountid == 160102) {
        titles = @[@"真实姓名",@"开户银行",@"银行卡号"];
    }
    NSMutableArray *muArray = @[].mutableCopy;
    for (NSInteger i = 0; i < titles.count; i++) {
        WGAddAccountItem *item = [WGAddAccountItem new];
        item.name_left = titles[i];
        item.index = i;
        item.canInput = YES;
        if (accountid == 160102 && i == 1) {
            item.canInput = NO;
        }
        NSString *place = item.canInput ? @"请输入":@"请选择";
        item.placeholer = kStringAppend(place, item.name_left);
        [muArray addObject:item];
    }
    return [muArray copy];
}
#pragma mark - WGAddAccountCellDelegate
- (void)chooseBankWithItem:(WGAddAccountItem *)item {
    
    __block NSMutableArray *titles = @[].mutableCopy;
    
    NSArray <WGAccountBankInfo *> *bankList = self.info.bankInfo;
    [bankList enumerateObjectsUsingBlock:^(WGAccountBankInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = [NSString stringWithFormat:@"%@",obj.bankName];
        [titles wg_addObject:name];
    }];
    
    WGActionSheet *sheet = [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
        if (index > 0) {
            WGAccountBankInfo *info = bankList[index-1];
//            WGLog(@"name:%@", info.bankName);
            item.name_content = info.bankName;
            [self.tableView wg_reloadData];
        }
    } cancel:@"取消" others:[titles copy]];
    sheet.canScroll = YES;
    sheet.maxHeight = 220;
}
#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    WGAddAccountItem *item = self.dataArray[indexPath.row];
    WGAddAccountCell *cell = [WGAddAccountCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    cell.delegate = self;
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 12;
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(0, 12, 0, 0);
}

#pragma mark - getter && setter 
- (WGAddAccountFootView *)footView {
    if (!_footView) {
        _footView = [WGAddAccountFootView new];
        _footView.wg_height = 100;
        __weak typeof(self) weakself = self;
        _footView.saveHandle = ^() {
            __strong typeof(weakself) strongself = weakself;
            [strongself saveAccount];
        };
    }
    return _footView;
}
#pragma mark - 保存
- (void)saveAccount {
//    NSMutableString *muString = @"".mutableCopy;
    for (WGAddAccountItem *item in self.dataArray) {
        if (item.name_content == nil) {
            NSString *place = item.canInput ? @"请输入":@"请选择";
            [MBProgressHUD wg_message:kStringAppend(place, item.name_left)];
            return;
        }
    }
    __block NSString *accountName = nil;
    __block NSString *accountId = nil;
    __block NSString *bankInfo = nil;
    [self.dataArray enumerateObjectsUsingBlock:^(WGAddAccountItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
        if (item.name_content == nil) {
            [MBProgressHUD wg_message:kStringAppend(@"请输入", item.name_left)];
            return;
        }
        if (idx == 0) {
            accountName = item.name_content;
        }
        if ([self.info.accountType integerValue] == 160101) { // 支付宝
            if (idx == 1) {
                accountId = item.name_content;
            }
        } else if ([self.info.accountType integerValue] == 160102) {
            if (idx == 1) {
                bankInfo = item.name_content;
            }else if (idx == 2) {
                accountId = item.name_content;
            }
        }
    }];
    
    
    WGAddAccountParam *param = [WGAddAccountParam new];
    param.accountType = [self.info.accountType integerValue];
    param.accountName = accountName;
    param.accountId = accountId;
    param.bankInfo = bankInfo;
    
    [MBProgressHUD wg_showHub_CanTap];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl] isPost:YES];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        [MBProgressHUD wg_hideHub];
        if (response.statusCode == 200) {
//            [self performSelector:@selector(wg_pop) withObject:nil afterDelay:0.3];
            if (self.saveAccountSuccessHandle) {
                self.saveAccountSuccessHandle();
            }
        } else {
            if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
                NSString *content = response.responseJSON[@"content"];
                [MBProgressHUD wg_message:content];
            }
        }
    }];
    
}

- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/payment/addPayment_v3";
}

@end
