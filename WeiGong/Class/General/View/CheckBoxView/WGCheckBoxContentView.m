//
//  WGCheckBoxContentView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/10.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGCheckBoxContentView.h"
#import "WGCheckBoxView.h"

#import "WG_BaseTableViewCell.h"

@interface WGCheckBoxCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGCheckBoxItem *item;
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UIButton *button_box;
@end
@implementation WGCheckBoxCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.button_box];
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        
    }];
    [self.button_box mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
}

- (void)setItem:(WGCheckBoxItem *)item {
    _item = item;
    if (_item) {
        self.labname.text = _item.name;
        self.button_box.selected = _item.selected;
    }
}
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
    }
    return _labname;
}
- (UIButton *)button_box {
    if (!_button_box) {
        _button_box = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_box.userInteractionEnabled = NO;
        [_button_box setImage:[UIImage imageNamed:@"mine_experience_nor"] forState:UIControlStateNormal];
        [_button_box setImage:[UIImage imageNamed:@"mine_experience_sel"] forState:UIControlStateSelected];
    }
    return _button_box;
}

@end

@interface WGCheckBoxContentView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *button_cancel;
@property (nonatomic, strong) UIButton *button_sure;
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation WGCheckBoxContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.labtitle];
        [self addSubview:self.line];
        [self addSubview:self.button_cancel];
        [self addSubview:self.button_sure];
        
        [self addSubview:self.tableView];
        [self setupFrame];
    }
    return self;
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setupFrame];
}
- (void)setupFrame {
    CGFloat buttonW = 60;
    CGFloat buttonH = 40;
    self.button_cancel.frame = CGRectMake(0, 0, buttonW, buttonH);
    self.button_sure.frame = CGRectMake(self.wg_width-buttonW, 0, buttonW, buttonH);
    self.labtitle.frame = CGRectMake(0, 0, self.wg_width, buttonH);
    self.line.frame = CGRectMake(0, self.labtitle.wg_bottom, self.wg_width, kLineHeight);
    self.tableView.frame = CGRectMake(0, self.line.wg_bottom, self.wg_width, self.wg_height-self.line.wg_bottom);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_title) {
        self.labtitle.text = _title;
    }
}
- (void)setBoxItems:(NSArray<WGCheckBoxItem *> *)boxItems {
    _boxItems = [boxItems copy];
    if (_boxItems) {
        
        
        [self.tableView reloadData];
    }
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WGCheckBoxItem *item = self.boxItems[indexPath.row];
    WGCheckBoxCell *cell = [WGCheckBoxCell wg_cellWithTableView:tableView];
    cell.item = item;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.boxItems count];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WGCheckBoxItem *item = self.boxItems[indexPath.row];
    item.selected = !item.selected;
    [tableView reloadData];
}
#pragma mark - getter && setter
- (UILabel *)labtitle {
    if (!_labtitle) {
        _labtitle = [UILabel wg_labelWithFont:kFont(16) textColor:kBlackColor];
        _labtitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labtitle;
}
- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
    }
    return _line;
}
- (UIButton *)button_cancel {
    if (!_button_cancel) {
        UIButton *button = [self buttonWithTitle:@"取消"];
        _button_cancel = button;
    }
    return _button_cancel;
}
- (UIButton *)button_sure {
    if (!_button_sure) {
        UIButton *button = [self buttonWithTitle:@"完成"];
        _button_sure = button;
    }
    return _button_sure;
}
- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:kColor_Black forState:UIControlStateNormal];
    button.titleLabel.font = kFont(15);
    return button;
}
- (void)buttonClick:(UIButton *)button {
    
    if (button == self.button_cancel) {
        if (self.sureHandle) {
            self.sureHandle(nil);
        }
    } else if (button == self.button_sure) {
        __weak typeof(self) weakself = self;
        if (self.sureHandle) {
            self.sureHandle(weakself.boxItems);
        }
    }
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.rowHeight = UITableViewAutomaticDimension;
        table.separatorInset = UIEdgeInsetsZero;
        table.layoutMargins = UIEdgeInsetsZero;
        table.estimatedRowHeight = 40;
        table.delegate = self;
        table.dataSource = self;
        table.tableFooterView = [UIView new];
        table.separatorColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
        _tableView = table;
    }
    return _tableView;
}
@end
