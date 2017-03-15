//
//  WGLinghuoDetailViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGLinghuoDetailViewController.h"
#import "WGBaseNoHightButton.h"

#import "WGLinghuoDetail.h"
#import "WGLinghuoDetailListCell.h"

#import "WGLinghuoDetailHeadView.h"

#import "WGRequestManager.h"

#import "WGBaseNoHightButton.h"

@interface WGLinghuoDetailViewController ()
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) WGBaseNoHightButton *button_last;
@property (nonatomic, strong) WGBaseNoHightButton *button_next;
@property (nonatomic, strong) WGLinghuoDetailHeadView *headView;

@property (nonatomic, strong) WGLinghuoDetail *detail;
@property (nonatomic, strong) WGBaseNoHightButton *button_bottom;
@end

@implementation WGLinghuoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = [self.currentDate wg_stringWithDateFormat:@"yyyy年MM月"];
    self.title = title;
    
    [self setupNavItems];
    [self setupHeadFootView];
}

- (void)setupNavItems {
    
    WGBaseNoHightButton *button_last = [self buttonWithTitle:@"上一月"];
    [self.navBar addSubview:button_last];
    self.button_last = button_last;
    
    WGBaseNoHightButton *button_next = [self buttonWithTitle:@"下一月"];
    [self.navBar addSubview:button_next];
    self.button_next = button_next;
    
    CGFloat buttonH = kNavigationBarHeight;
    [self.button_last mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backButton.mas_right);
        make.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(buttonW);
        make.height.mas_equalTo(buttonH);
    }];
    
    [self.button_next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-60);
        make.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(buttonW);
        make.height.mas_equalTo(buttonH);
    }];
    
}
- (void)setupHeadFootView {
    WGLinghuoDetailHeadView *headView = [WGLinghuoDetailHeadView new];
    [self.view addSubview:headView];
    self.headView = headView;
    
    [self.view addSubview:self.button_bottom];
    
    CGFloat headH = 40;
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navBar.mas_bottom);
        make.height.mas_equalTo(headH);
    }];
    
    CGFloat buttonH = 49;
    [self.button_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top += headH;
    contentInset.bottom += buttonH;
    self.tableView.contentInset = contentInset;
//    self.headView.hidden = YES;
}
- (WGBaseNoHightButton *)buttonWithTitle:(NSString *)title {
    WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeMonth:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:kColor_Black forState:UIControlStateNormal];
    button.titleLabel.font = kFont(15);
    return button;
}
- (void)changeMonth:(UIButton *)button {
    if (button == self.button_last) {
        self.currentDate = [self.currentDate wg_lastMonth];
    } else if (button == self.button_next) {
        self.currentDate = [self.currentDate wg_nextMonth];
    }
    NSString *title = [self.currentDate wg_stringWithDateFormat:@"yyyy年MM月"];
    self.title = title;
    
    [self wg_loadData];
}

- (void)wg_loadData {
    
    NSString *month = [self.currentDate wg_stringWithDateFormat:@"yyyyMM"];
    if (month == nil) {
        return;
    }
//    WGLog(@"month:%@", month);
    [WGRequestManager cancelTaskWithUrl:[self requestUrl]];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl]];
    request.wg_parameters = @{@"month":month};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 0) return ;
        self.detail = nil;
        if (response.statusCode == 200) {
            WGLinghuoDetail *detail = [WGLinghuoDetail wg_modelWithDictionry:response.responseJSON];
            self.detail = detail;
        }
        self.headView.detail = self.detail;
        self.button_bottom.enabled = self.detail.uploadFlag != 0;
        [self.tableView wg_reloadData];
    }];
}
#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGLinghuoDetailListItem *item = self.detail.jobList[indexPath.row];
    WGLinghuoDetailListCell *cell = [WGLinghuoDetailListCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return self.detail.jobList.count;
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 12;
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}
#pragma mark - private
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/shebao/monthWorkList";
}
- (WGBaseNoHightButton *)button_bottom {
    if (!_button_bottom) {
        WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(15);
        UIImage *backImage_nor = [[UIImage wg_imageWithColor:kColor_Blue size:CGSizeMake(10, 10)] wg_resizedImage];
        UIImage *backImage_disable = [[UIImage wg_imageWithColor:self.tableView.backgroundColor size:CGSizeMake(10, 10)] wg_resizedImage];
        [button setBackgroundImage:backImage_nor forState:UIControlStateNormal];
        [button setBackgroundImage:backImage_disable forState:UIControlStateDisabled];
        [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [button setTitleColor:kColor_Black_Sub forState:UIControlStateDisabled];
        [button setTitle:@"生成电子凭证" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(wg_updateData) forControlEvents:UIControlEventTouchUpInside];
        _button_bottom = button;
        
        UIView *line = [UIView new];
        line.backgroundColor = kColor_Line;
        [_button_bottom addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(kLineHeight);
        }];
    }
    return _button_bottom;
}
- (NSDate *)currentDate {
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}
#pragma mark - 上传电子凭证
- (void)wg_updateData {
    WGLog(@"上传电子凭证");
}
@end
