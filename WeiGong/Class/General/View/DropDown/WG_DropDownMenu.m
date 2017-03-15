//
//  WG_DropDown.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_DropDownMenu.h"
#import "WG_DropDownCell.h"
#import "WG_DropDownButton.h"


float maxTableH = 300.f, minTableH = 100.f;
@interface WG_DropDownMenu () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) WG_DropDownButton *selectBtn;

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, assign) NSInteger currentColumn;
@end
@implementation WG_DropDownMenu

+ (instancetype)dropDownWithoOrigin:(CGPoint)origin height:(CGFloat)height {
    CGRect frame = (CGRect){origin, kScreenWidth, height};
    WG_DropDownMenu *menu = [[WG_DropDownMenu alloc] initWithFrame:frame];
    return menu;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView = [[UIView alloc] initWithFrame:frame];
        
        self.backgroundView = [[UIView alloc] initWithFrame:frame];
        self.maskColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wg_tapClick)]];
        [self.contentView addSubview:self.backgroundView];
        
        
        self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 0);
        [self.contentView addSubview:self.tableView];
        
        UIView *lineTop = [UIView new];
        [self addSubview:lineTop];
        lineTop.backgroundColor = kColor(233, 233, 233);
        lineTop.frame = CGRectMake(0, 0, kScreenWidth, kLineHeight);
        
        UIView *line = [UIView new];
        [self addSubview:line];
        line.backgroundColor = lineTop.backgroundColor;
        line.frame = CGRectMake(0, CGRectGetHeight(frame)-kLineHeight, kScreenWidth, kLineHeight);
    }
    return self;
}
- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    self.backgroundView.backgroundColor = _maskColor;
}

- (void)setDataSource:(id<WG_DropDownMenuDataSource>)dataSource {
    _dataSource = dataSource;
    
    [self reloadData];
}

- (void)reloadData {
    
    // 列数
    NSInteger columns = [_dataSource numberOfColumnsInMenu:self];
    float buttonW = kScreenWidth/columns;
    
    for (NSInteger i = 0; i < columns; i++) {
        WG_DropDownButton *button = nil;
        if (i < self.buttons.count) {
            button = self.buttons[i];
        } else {
            button = [WG_DropDownButton buttonWithType:UIButtonTypeCustom];
//            button.backgroundColor = [UIColor greenColor];
            [self addSubview:button];
            [self.buttons addObject:button];
            [button addTarget:self action:@selector(wg_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        button.line.hidden = i == 0;
        button.frame = CGRectMake(buttonW*i, 0, buttonW, CGRectGetHeight(self.frame));
        [button setTitle:[_dataSource menu:self titleForColumn:i] forState:UIControlStateNormal];
        button.column = i;
        
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WG_DropDownCell *cell = [WG_DropDownCell wg_cellWithTableView:tableView];
    cell.text = [_dataSource menu:self titleForRow:indexPath.row inColumn:self.currentColumn];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource menu:self numberOfRowsInColumn:self.currentColumn];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self wg_buttonClick:self.selectBtn];
    if ([self.delegate respondsToSelector:@selector(menu:didSelectRow:inColumn:)]) {
        [self.delegate menu:self didSelectRow:indexPath.row inColumn:self.currentColumn];
    }
}
#pragma mark - Actions
- (void)wg_tapClick {
    
    [self wg_buttonClick:self.selectBtn];
    if ([self.delegate respondsToSelector:@selector(didTapCancel)]) {
        [self.delegate didTapCancel];
    }
}
- (void)wg_buttonClick:(WG_DropDownButton *)button {
    
    if (button == nil) return;
    // 设置选中列
    self.currentColumn = button.column;
    [self.tableView reloadData];
    
    if (self.selectBtn) {
        if (self.selectBtn == button) {
            self.selectBtn.isStretch = NO;
            if ([self.delegate respondsToSelector:@selector(menu:didSelectColumn:)]) {
                [self.delegate menu:self didSelectColumn:button.column];
            }
            // 收起来
            [self dropdownIsHidden:YES animated:YES complete:^{
                
            }];
        } else {
            button.isStretch = YES;
            self.selectBtn.isStretch = NO;
            
            // 收起之前的，展开当前的
            if ([self.delegate respondsToSelector:@selector(menu:didSelectColumn:)]) {
                [self.delegate menu:self didSelectColumn:button.column];
            }
            [self dropdownIsHidden:YES animated:NO complete:^{
                [self dropdownIsHidden:NO animated:YES complete:^{
                    
                }];
            }];
            
        }
    } else {
        button.isStretch = YES;
        if ([self.delegate respondsToSelector:@selector(menu:didSelectColumn:)]) {
            [self.delegate menu:self didSelectColumn:button.column];
        }
        // 展开
        [self dropdownIsHidden:NO animated:YES complete:^{
            
        }];
    }
    
    // 是否处于展开状态
    self.selectBtn = button.isStretch ? button:nil;
    
    
    
    
    
    
}

- (void)dropdownIsHidden:(BOOL)isHidden animated:(BOOL)animated complete:(void(^)())complete {
    
    
    UIView *superview = nil;
    
    
    superview = self.superview.superview;
    // 首页
    if (superview && [superview isKindOfClass:[UITableView class]]) {
        
        [(UITableView *)superview setScrollEnabled:isHidden];
    } else { // 搜索页面
//        superview = self.superview;
    }
    
    
//    static NSInteger contentTag = 1002;
//    UIView *contentView = [superview viewWithTag:contentTag];
//    if (contentView == nil) {
//        UIView *aboveSubview = nil;
//        for (UIView *subview in superview.subviews) {
//            if ([subview isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]) {
//                aboveSubview = subview;
//                break;
//            }
//        }
//        // 需要跟着tableView滑动
//        if (aboveSubview) {
//            [superview insertSubview:self.contentView aboveSubview:aboveSubview];
//        } else {
//            [superview insertSubview:self.contentView atIndex:1];
//        }
//    }
    
    UIView *selfView = self.superview.superview;
    
    [selfView insertSubview:self.contentView belowSubview:self.superview];

    
    [self.tableView layoutIfNeeded];
    
    float tableH = self.tableView.contentSize.height;
    float tableMaxH = 350;
    if (tableH >= tableMaxH) {
        tableH = tableMaxH;
    }
    
    CGRect frame = [self convertRect:self.bounds toView:superview];
    float contentH = MAX(self.tableView.contentSize.height, kScreenHeight);
    self.contentView.frame = (CGRect){frame.origin.x, CGRectGetMaxY(frame), kScreenWidth, contentH};
    self.backgroundView.frame = self.contentView.bounds;
    self.tableView.frame = (CGRect){0, -tableH, kScreenWidth, tableH};
    
    
//    [superview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        WGLog(@"%@  %zd", NSStringFromClass([obj class]), idx);
//    }];
    
    self.contentView.hidden = NO;
    
    // 隐藏
    if (isHidden) {
        float duration = 0.0f;
        if (animated) {
            duration = 0.25f;
        }
        [UIView animateWithDuration:duration animations:^{
            self.tableView.transform = CGAffineTransformIdentity;
//            tableF.size.height = 0;
//            self.tableView.frame = (CGRect){0, 0, kScreenWidth, 240};
            self.maskColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            self.contentView.hidden = YES;
            if (complete) {
                complete();
            }
        }];
    } else { // 显示
        float duration = 0.0f;
        if (animated) {
            duration = 0.25f;
        }
        [UIView animateWithDuration:duration animations:^{
            self.tableView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.tableView.frame));
            self.maskColor = [UIColor colorWithWhite:0.0 alpha:0.55];
        } completion:^(BOOL finished) {
            if (complete) {
                complete();
            }
        }];
    }
    
}

#pragma mark - getter && setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 44;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.layoutMargins = UIEdgeInsetsZero;
        _tableView.separatorColor = kColor_NavLine;
        _tableView.separatorColor = [UIColor wg_colorWithHexString:@"#ededed"];
    }
    return _tableView;
}
- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray new];
    }
    return _buttons;
}
@end
