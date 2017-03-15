//
//  WGApplyJobViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGApplyJobViewController.h"
#import "WGApplyJobViewController+Calander.h"
#import "WG_JobDetail.h"

#import "WGApplyJobListItem.h"
#import "WGApplyJobChooseCell.h"
#import "WGApplyJobDateCell.h"
#import "WGActionSheet.h"

#import "WGApplyJobFootView.h"
#import "WGApplyJobCollectionViewCell.h"

#import "WGApplyJobParam.h"

@interface WGApplyJobViewController ()
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) WGApplyJobFootView *footView;
@end

@implementation WGApplyJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请";
    
    self.tableView.tableFooterView = self.footView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView wg_reloadData];
}

#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGApplyJobListItem *item = self.dataArray[indexPath.section];
    if (item.type == 1 || item.type == 2) {
        WGApplyJobChooseCell *cell = [WGApplyJobChooseCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    } else if (item.type == 3) {
        __weak typeof(self) weakself = self;
        WGApplyJobDateCell *cell = [WGApplyJobDateCell wg_cellWithTableView:self.tableView];
        
        cell.refreshHandle = ^() {
            __strong typeof(weakself) strongself = weakself;
            [strongself.tableView wg_reloadData];
        };
        cell.item = item;
        return cell;
    }
    
    return [super wg_cellAtIndexPath:indexPath];
}
- (NSInteger)wg_numberOfSections {
    return [self.dataArray count];
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    WGApplyJobListItem *item = self.dataArray[section];
    CGFloat height = item.type == 3 ? 25:10;
    return height;
}
- (UIView *)wg_headerAtSection:(NSInteger)section {
    WGApplyJobListItem *item = self.dataArray[section];
    if (item.type == 3) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black];
        label.text = @"   选择可上岗日期";
        return label;
    } else if (item.type == 0) {
        
    }
    return nil;
}
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WGApplyJobListItem *item = self.dataArray[indexPath.section];
    if (item.type == 1) {
        NSArray <WG_JobAddressItem *> *jobplaces = self.detail.jobplaces;
        NSMutableArray *jobTitles = @[].mutableCopy;
        [jobplaces enumerateObjectsUsingBlock:^(WG_JobAddressItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [jobTitles wg_addObject:obj.jobAddress];
        }];
        
        WGActionSheet *sheet = [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
            if (index > 0) {
                NSInteger sheet_index = index - 1;
                if (sheet_index < jobplaces.count) {
                    WG_JobAddressItem *addressItem = jobplaces[sheet_index];
                    item.addressItem = addressItem;
                    [self.tableView wg_reloadData];
                }
            }
        } cancel:@"取消" others:jobTitles];
        sheet.canScroll = YES;
        sheet.maxHeight = 220;
        
    } else if (item.type == 2) {
        NSArray <WG_JobTimeItem *> *jobTimes = self.detail.jobTimes;
        NSMutableArray *jobTitles = @[].mutableCopy;
        [jobTimes enumerateObjectsUsingBlock:^(WG_JobTimeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *title = [NSString stringWithFormat:@"%@-%@", obj.startTime, obj.stopTime];
            [jobTitles wg_addObject:title];
        }];
        
        WGActionSheet *sheet = [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
            if (index > 0) {
                NSInteger sheet_index = index - 1;
                if (sheet_index < jobTimes.count) {
                    WG_JobTimeItem *timeItem = jobTimes[sheet_index];
                    item.timeItem = timeItem;
                    [self.tableView wg_reloadData];
                }
            }
        } cancel:@"取消" others:jobTitles];
        sheet.canScroll = YES;
        sheet.maxHeight = 220;
    }
}
#pragma mark - 提交数据
- (void)checkData {
    WGApplyJobParam *param = [WGApplyJobParam new];
    param.enterpriseJobId = self.detail.enterpriseJobId;
    param.enterpriseInfoId = self.detail.enterpriseInfoId;
    
    WG_JobAddressItem *addressItem = nil;
    WG_JobTimeItem *timeItem = nil;
    NSMutableArray *toDateList = @[].mutableCopy;
    for (NSInteger i = 0; i < [self.dataArray count]; i++) {
        WGApplyJobListItem *item = self.dataArray[i];
        if (item.type == 1) {
            if (item.addressItem == nil) {
                [MBProgressHUD wg_message:@"请选择意向工作地点"];
                return;
            }
            addressItem = item.addressItem;
        } else if (item.type == 2) {
            if (item.timeItem == nil) {
                [MBProgressHUD wg_message:@"请选择可上岗时段"];
                return;
            }
            timeItem = item.timeItem;
        } else if (item.type == 3) {
            NSArray *monthList = item.monthList;
            for (NSArray *itemList in monthList) {
                for (WGApplyJobCollectionItem *item in itemList) {
                    if ([item isKindOfClass:[WGApplyJobCollectionItem class]]) {
                        if (item.isSelected) {
                            NSString *ymdString = [item.date wg_stringWithDateFormat:@"yyyyMMdd"];
                            [toDateList wg_addObject:ymdString];
                        }
                    }
                }
            }
            
            if (toDateList.count == 0) {
                [MBProgressHUD wg_message:@"请选择工作日期"];
                return;
            }
            
        }
    }
    
    if (addressItem == nil) {
        addressItem = [self.detail.jobplaces firstObject];
    }
    if (timeItem == nil) {
        timeItem = [self.detail.jobTimes firstObject];
    }
    param.toAddress = addressItem.enterpriseJobplaceId;
    param.toTime = [NSString stringWithFormat:@"%@-%@",timeItem.startTime,timeItem.stopTime];
    param.toDate = [toDateList componentsJoinedByString:@","];
    
    WGLog(@"submit:%@", [param wg_keyValues]);
    
    [self submitDataWithParam:param];
    
}
- (void)submitDataWithParam:(WGApplyJobParam *)param {
    __weak typeof(self) weakself = self;
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl] isPost:YES];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
                NSString *message =response.responseJSON[@"result"][@"content"];
                [MBProgressHUD wg_message:message];
            }
            __strong typeof(weakself) strongself = weakself;
            if (strongself.submitSuccessHandle) {
                strongself.submitSuccessHandle();
            }
        } else {
            
        }
    }];
}
#pragma mark - private
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/postJob_v2";
}
- (WGApplyJobFootView *)footView {
    if (!_footView) {
        _footView = [WGApplyJobFootView new];
        _footView.wg_height = 80;
        __weak typeof(self) weakself = self;
        _footView.submitHandle = ^ () {
            __strong typeof(weakself) strongself = weakself;
            [strongself checkData];
        };
        
    }
    return _footView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSArray <WG_JobAddressItem *> *jobplaces = self.detail.jobplaces;
        NSMutableArray *muArray = @[].mutableCopy;
        if (jobplaces.count > 1) {
            WGApplyJobListItem *item = [WGApplyJobListItem new];
            item.type = 1;
            [muArray wg_addObject:item];
        }
        // 显示可上岗时段
        NSArray <WG_JobTimeItem *> *jobTimes = self.detail.jobTimes;
        if (jobTimes.count > 1) {
            WGApplyJobListItem *item = [WGApplyJobListItem new];
            item.type = 2;
            [muArray wg_addObject:item];
        }
        // 设置日期选择框
//        self.detail.dateStart;
//        self.detail.dateStop;
        
        WGApplyJobListItem *item = [WGApplyJobListItem new];
        item.type = 3;
        item.monthList = [self monthsWithJobDetail:self.detail];
        [muArray wg_addObject:item];
        
        _dataArray = [muArray copy];
    }
    return _dataArray;
}
@end
