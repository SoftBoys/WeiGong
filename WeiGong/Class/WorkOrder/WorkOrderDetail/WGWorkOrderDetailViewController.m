//
//  WGWorkOrderDetailViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkOrderDetailViewController.h"

#import "WGWorkOrderListCell.h"
#import "WGWorkOrderDetail.h"
#import "WGWorkOrderDetailCell.h"
#import "WGWorkOrderDetailListCell.h"
#import "WGWorkOrderDetailHeadCell.h"
#import "WGBaseNoHightButton.h"

#import "WGRequestManager.h"

@interface WGWorkOrderDetailViewController ()
@property (nonatomic, strong) WGWorkOrderDetail *orderDetail;
@property (nonatomic, strong) WGBaseNoHightButton *button_sure;
@end

@implementation WGWorkOrderDetailViewController
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
//    self.sepLineColor = kClearColor;
    
    [self.view addSubview:self.button_sure];
    [self.button_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self updateView];
}
- (void)updateView {
    CGFloat spaceY = 10;
    BOOL showButton = self.orderDetail.orderFlag == 2;
    self.button_sure.hidden = !showButton;
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.bottom = showButton ? 40+spaceY:0+spaceY;
    self.tableView.contentInset = contentInset;
    
}
- (void)wg_loadData {
    if (self.listItem == nil) {
        [MBProgressHUD wg_message:@"订单无效"];
        [self wg_pop];
        return;
    }
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl]];
    request.wg_parameters = @{@"enterpriseOrderNewId":@(self.listItem.enterpriseOrderNewId)};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            WGWorkOrderDetail *orderDetail = [WGWorkOrderDetail wg_modelWithDictionry:response.responseJSON];
            self.orderDetail = orderDetail;
            [self updateView];
            [self.tableView wg_reloadData];
        } else {
            
        }
    }];
}
#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WGWorkOrderDetailCell *cell = [WGWorkOrderDetailCell wg_cellWithTableView:self.tableView];
        cell.orderDetail = self.orderDetail;
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            WGWorkOrderDetailHeadCell *cell = [WGWorkOrderDetailHeadCell wg_cellWithTableView:self.tableView];
            return cell;
        }
        NSInteger row = indexPath.row - 1;
        WGWorkOrderDetailListItem *item = self.orderDetail.workList[row];
        WGWorkOrderDetailListCell *cell = [WGWorkOrderDetailListCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    }
    return [super wg_cellAtIndexPath:indexPath];
}
- (NSInteger)wg_numberOfSections {
    if (self.orderDetail == nil) {
        return 0;
    } else {
        if (self.orderDetail.workList.count) {
            return 2;
        }
        return 1;

    }
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.orderDetail.workList.count + 1;
    }
    return 0;
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 12;
}
- (UIView *)wg_headerAtSection:(NSInteger)section {
    return [UIView new];
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat left = 24;
    return UIEdgeInsetsMake(0, left, 0, left);
}
#pragma mark - private
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/orderNew/personOrderDetail";
}

- (WGBaseNoHightButton *)button_sure {
    if (!_button_sure) {
        WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(17);
        [button setTitle:@"订单确认" forState:UIControlStateNormal];
        [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
        UIImage *image_nor = [[UIImage wg_imageWithColor:kColor_Blue] wg_resizedImage];
        [button setBackgroundImage:image_nor forState:UIControlStateNormal];
        
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself alertSure];
        }];
        
        _button_sure = button;
    }
    return _button_sure;
}

- (void)alertSure {
    NSString *title = @"提醒", *message = @"是否确认？";
    NSString *cancel = @"取消", *sure = @"确认";
    [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger index) {
        if (index) {
            [self sureOrder];
        }
    } cancel:cancel sure:sure];
    
}
- (void)sureOrder {
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self sureOrderUrl] isPost:YES];
    request.wg_parameters = @{@"enterpriseOrderNewId":@(self.orderDetail.enterpriseOrderNewId)};
    [MBProgressHUD wg_showHub_CanTap];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        [MBProgressHUD wg_hideHub];
        
        if (response.statusCode == 200) {
            [self wg_loadData];
        }
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *messgae = response.responseJSON[@"content"];
            [MBProgressHUD wg_message:messgae];
        }
    }];
    
}
- (NSString *)sureOrderUrl {
    return @"/linggb-ws/ws/0.1/orderNew/setOrderPersonalFlag";
}
- (void)dealloc {
    [WGRequestManager cancelTaskWithUrl:[self sureOrderUrl]];
}
@end
