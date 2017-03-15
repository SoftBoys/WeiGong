//
//  WGWorkExperienceViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/20.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkExperienceViewController.h"
#import "WGWorkExperienceCell.h"
#import "WGWorkExperienceItem.h"

@interface WGWorkExperienceViewController ()
@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, strong) UIButton *button_save;
@property (nonatomic, copy) NSArray<WGWorkExperienceItem *> *items_selected;
@end

@implementation WGWorkExperienceViewController
+ (instancetype)instanceWithCallBackHandle:(WGWorkCallBackHandle)handel {
    WGWorkExperienceViewController *workVC = [WGWorkExperienceViewController new];
    workVC.handle = handel;
    return workVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作经验";
    
    [self addSaveItem];
}
- (void)addSaveItem {
    [self.navBar addSubview:self.button_save];
    [self.button_save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
    self.button_save.hidden = self.dataArray.count == 0;
}
- (void)wg_loadData {
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:self.requestUrl];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.responseJSON) {
            NSArray *list = response.responseJSON;
            if ([list isKindOfClass:[NSArray class]]) {
                NSArray *items = [WGWorkExperienceItem wg_modelArrayWithDictArray:list];
                self.dataArray = items;
            }
            self.button_save.hidden = self.dataArray.count == 0;
            [self.tableView wg_reloadData];
        }
    }];

}
#pragma mark - 代理方法
-(UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGWorkExperienceItem *item = self.dataArray[indexPath.row];
    WGWorkExperienceCell *cell = [WGWorkExperienceCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 30;
}
- (UIView *)wg_headerAtSection:(NSInteger)section {
    UILabel *label = [UILabel wg_labelWithFont:kFont(13) textColor:kColor_Black];
    label.text = @"   经验标签选择";
    return label;
}
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WGWorkExperienceItem *item = self.dataArray[indexPath.row];
    BOOL validate = (item.validate == 1) ? 0:1;
    item.validate = validate;
    [self.tableView wg_reloadData];
}
#pragma mark - private
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/getPersonalMarksInfo";
}

- (UIButton *)button_save {
    if (!_button_save) {
        _button_save = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button_save setTitle:@"保存" forState:UIControlStateNormal];
        [_button_save setTitleColor:kColor_Orange forState:UIControlStateNormal];
        _button_save.titleLabel.font = kFont(16);
        __weak typeof(self) weakself = self;
        [_button_save setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself saveData];
        }];
    }
    return _button_save;
}
- (void)saveData {
    WGLog(@"保存数据");
    
    NSMutableArray *items_select = @[].mutableCopy;
    NSMutableArray *markIdList = @[].mutableCopy;
    NSMutableArray *markNameList = @[].mutableCopy;
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        WGWorkExperienceItem *item = self.dataArray[i];
        if (item.validate == 1) {
            [items_select addObject:item];
            [markIdList addObject:@(item.code)];
            [markNameList wg_addObject:item.name];
        }
    }
    self.items_selected = items_select;
    if (items_select.count == 0) {
        [MBProgressHUD wg_message:@"请至少选择一个标签"];
        return;
    }
    
    NSString *markName = [markNameList componentsJoinedByString:@","];
    
    NSString *url = @"/linggb-ws/ws/0.1/person/addMark";
    
    NSDictionary *params = @{@"markId":[markIdList componentsJoinedByString:@","],@"markName":markName};
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = params;
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        NSDictionary *data = response.responseJSON;
        if (data && [data isKindOfClass:[NSDictionary class]]) {
            NSInteger comment = [data[@"common"] integerValue];
            NSString *content = data[@"content"];
            if (content) {
                [MBProgressHUD wg_message:content];
            }
            if (comment == 1) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    __weak typeof(self) weakself = self;
                    if (self.handle) {
                        self.handle(weakself.items_selected, markName);
                    }
                });
            }
        }
    }];
}
@end
