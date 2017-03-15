//
//  WGUserFeedbackViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGUserFeedbackViewController.h"
#import "WGBaseLabel.h"

#import "WGUserFeedbackTextViewCell.h"
#import "WGUserDeedbackContactCell.h"

#import "WGUserFeedbackFootView.h"
#import "WGUserFeedbackParam.h"

@interface WGUserFeedbackViewController ()
@property (nonatomic, strong) WGBaseLabel *labremind1;
@property (nonatomic, strong) WGBaseLabel *labremind2;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WGUserFeedbackFootView *footView;
@end

@implementation WGUserFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = self.footView;
}

#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGUserDeedbackContactItem *item = self.dataArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        WGUserFeedbackTextViewCell *cell = [WGUserFeedbackTextViewCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    } else if (indexPath.section == 1) {
        WGUserDeedbackContactCell *cell = [WGUserDeedbackContactCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    }
    return [super wg_cellAtIndexPath:indexPath];
}
- (NSInteger)wg_numberOfSections {
    return [self.dataArray count];
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    NSArray *items = self.dataArray[section];
    return items.count;
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 35;
}
- (UIView *)wg_headerAtSection:(NSInteger)section {
    if (section == 0) {
        return self.labremind1;
    } else if (section == 1) {
        return self.labremind2;
    }
    return nil;
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}

#pragma mark - getter && setter 
- (WGBaseLabel *)labremind1 {
    if (!_labremind1) {
        WGBaseLabel *label = [WGBaseLabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
//        label.insets = UIEdgeInsetsMake(0, 12, 0, 12);
        label.text = @"  留下你的宝贵意见";
        _labremind1 = label;
    }
    return _labremind1;
}
- (WGBaseLabel *)labremind2 {
    if (!_labremind2) {
        WGBaseLabel *label = [WGBaseLabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
        label.insets = self.labremind1.insets;
        label.text = @"  联系方式";
        _labremind2 = label;
    }
    return _labremind2;
}

- (WGUserFeedbackFootView *)footView {
    if (!_footView) {
        _footView = [WGUserFeedbackFootView new];
        _footView.wg_height = 100;
        __weak typeof(self) weakself = self;
        _footView.submitHandle = ^() {
            __strong typeof(weakself) strongself = weakself;
            [strongself submitFeedbackData];
        };
    }
    return _footView;
}
#pragma mark - 提交
- (void)submitFeedbackData {
    
    WGUserDeedbackContactItem *ideaItem = self.dataArray[0][0];
    WGUserDeedbackContactItem *emailItem = self.dataArray[1][0];
    WGUserDeedbackContactItem *phoneItem = self.dataArray[1][1];
    
    // 邮箱和手机至少有一个
    NSString *place = nil;
    
    if (ideaItem.name_content == nil) {
        place = @"请输入意见";
    } else if (emailItem.name_content == nil && phoneItem.name_content == nil) {
        place = @"请输入邮箱或手机号";
    } else if (![emailItem.name_content wg_isEmail] && ![phoneItem.name_content wg_isPhone]) {
        place = @"请输入正确邮箱或正确手机号";
    } 
    
    if (place) {
        [MBProgressHUD wg_message:place];
        return;
    }
    WGUserFeedbackParam *param = [WGUserFeedbackParam new];
    param.typeId = 1;
    param.content = @"意见反馈";
    param.desc = ideaItem.name_content;
    param.email = emailItem.name_content;
    param.mobile = phoneItem.name_content;
    
    NSString *url = [self requestUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *message = response.responseJSON[@"content"];
            [MBProgressHUD wg_message:message];
        }
        
        if (response.statusCode == 200) {
            [self performSelector:@selector(wg_pop) withObject:nil afterDelay:0.3];
        }
    }];
    
    
}
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/userComplaint";
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
        NSArray *titles = @[@"邮箱：",@"手机："];
        NSArray *placeholders = @[@"请填写正确的邮箱，以便及时收到反馈",@"请填写正确的手机号"];
        
        NSMutableArray *array1 = @[].mutableCopy;
        for (NSInteger i = 0; i < titles.count; i++) {
            WGUserDeedbackContactItem *item = [WGUserDeedbackContactItem new];
            item.name_left = titles[i];
            item.placeholer = placeholders[i];
            item.index = i + 1;
            [array1 addObject:item];
        }
        
        [_dataArray wg_addObject:array1];
        
        WGUserDeedbackContactItem *item = [WGUserDeedbackContactItem new];
        item.placeholer = @"你的每一个意见对我们都很重要";
        item.index = 0;
        [_dataArray wg_insertObject:@[item] atIndex:0];
        
    }
    return _dataArray;
}

@end
