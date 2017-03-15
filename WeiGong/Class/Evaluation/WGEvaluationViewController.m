//
//  WGEvaluationViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/8.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGEvaluationViewController.h"
#import "WGEvaluationInfo.h"
#import "WGEvaluationProgressCell.h"
#import "WGEvaluationHeadCell.h"

@interface WGEvaluationViewController ()
@property (nonatomic, strong) WGEvaluationInfo *info;
@end

@implementation WGEvaluationViewController
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的信誉";
    self.needCellSepLine = NO;
}

- (void)wg_loadData {
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl]];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
                WGEvaluationInfo *info = [WGEvaluationInfo wg_modelWithDictionry:response.responseJSON];
                self.info = info;
                [self.tableView wg_reloadData];
            }
        }
    }];
}

#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        WGEvaluationHeadCell *cell = [WGEvaluationHeadCell wg_cellWithTableView:self.tableView];
        cell.info = self.info;
        return cell;
    } else {
        WGEvaluationListItem *item = [self.info.evalRank wg_objectAtIndex:indexPath.row-1];
        WGEvaluationProgressCell *cell = [WGEvaluationProgressCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    }
    
    return [super wg_cellAtIndexPath:indexPath];
}
- (NSInteger)wg_numberOfSections {
    if (self.info) {
        return 1;
    } else {
        return 0;
    }
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.info.evalRank.count + 1;
    }
    return 0;
}
- (UIView *)wg_headerAtSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 12;
}

- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/personEval/getPersonalEval";
}
#pragma mark - getter && setter 


@end
