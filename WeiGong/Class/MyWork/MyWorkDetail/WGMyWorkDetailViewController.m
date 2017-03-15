//
//  WGMyWorkDetailViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/24.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMyWorkDetailViewController.h"
#import "WGMyWorkDetail.h"

#import "WGMyWorkDetailHeadCell.h"
#import "WGMyWorkDetailAddressCell.h"

@interface WGMyWorkDetailViewController ()
@property (nonatomic, strong) WGMyWorkDetail *workDetail;
@end

@implementation WGMyWorkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作安排";
    
}

- (void)wg_loadData {
    if (self.personalWorkId == 0) {
        [MBProgressHUD wg_message:@"无工作安排"];
        [self wg_pop];
    }
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl]];
    request.wg_parameters = @{@"personalWorkId":@(self.personalWorkId)};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            WGLog(@"安排详情：%@", response);
            WGMyWorkDetail *workDetail = [WGMyWorkDetail wg_modelWithDictionry:response.responseJSON];
            self.workDetail = workDetail;
            [self.tableView wg_reloadData];
        }
    }];
}
#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WGMyWorkDetailHeadCell *cell = [WGMyWorkDetailHeadCell wg_cellWithTableView:self.tableView];
        cell.workDetail = self.workDetail;
        return cell;
    } else if (indexPath.section == 1) {
        
        WGMyWorkDetailAddressCell *cell = [WGMyWorkDetailAddressCell wg_cellWithTableView:self.tableView];
        cell.index = indexPath.row;
        cell.workDetail = self.workDetail;
        return cell;
    }
    
    return [super wg_cellAtIndexPath:indexPath];
}
- (NSInteger)wg_numberOfSections {
    if (self.workDetail) {
        return 2;
    }
    return 0;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 4;
    }
    return 0;
}
- (CGFloat)wg_sectionFooterHeightAtSection:(NSInteger)section {
    return 10;
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}

- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/newArrange/naAttendanceDetail";
}

@end
