//
//  WGActionSheet.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGActionSheet.h"

#define kActionButtonDefaultTag 1000
@interface WGActionSheet () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *otherTableView;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancel;
@property (nonatomic, copy) NSArray<NSString *> *others;

@property (nonatomic, copy) WGActionSheetCompletionHandle completionHandle;

@end

@implementation WGActionSheet

+ (instancetype)actionSheetWithTitle:(NSString *)title completionHandle:(WGActionSheetCompletionHandle)completionHandle cancel:(NSString *)cancel others:(NSArray<NSString *> *)others {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    WGActionSheet *sheet = [[[self class] alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    cancel = cancel ?: @"取消";
//    sheet.title = title;
    sheet.cancel = cancel;
    sheet.others = others;
    sheet.completionHandle = completionHandle;
    [window addSubview:sheet];
    [sheet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    return sheet;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _needMask = YES;
        _canScroll = NO;
        _maxHeight = 220;
        
        [self addSubview:self.backView];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleButton];
        [self.contentView addSubview:self.otherTableView];
        [self.contentView addSubview:self.cancelButton];
        self.backView.frame = self.bounds;
        
        CGRect contentViewF = self.bounds;
        contentViewF.origin.y = kScreenHeight;
        self.contentView.frame = contentViewF;
        self.titleButton.frame = self.bounds;
        self.otherTableView.frame = self.bounds;
        self.cancelButton.frame = self.bounds;
    }
    return self;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    if (_title) {
        [self.titleButton setTitle:_title forState:UIControlStateNormal];
    }
    self.titleButton.hidden = _title == nil;
}
- (void)setCancel:(NSString *)cancel {
    _cancel = cancel;
    if (_cancel) {
        [self.cancelButton setTitle:_cancel forState:UIControlStateNormal];
    }
    self.cancelButton.hidden = _cancel == nil;
}
- (void)setOthers:(NSArray<NSString *> *)others {
    _others = others;
    if (_others) {
        [self.otherTableView reloadData];
        return;
        for (UIView *subview in self.contentView.subviews) {
            [subview removeFromSuperview];
        }
        CGFloat height = 40;
        CGFloat buttonH = height - kLineHeight;
        CGFloat buttonW = kScreenWidth;
        CGFloat buttonY = 0;
        
        for (NSInteger i = 0; i < _others.count; i++) {
            buttonY = height * i;
            CGRect frame = CGRectMake(0, buttonY, buttonW, buttonH);
            NSString *title = _others[i];
            UIButton *button = [self buttonWithTitle:title];
            button.tag = kActionButtonDefaultTag + 1 + i;
            button.frame = frame;
            [self.contentView addSubview:button];
        }
        
        CGFloat spaceY = 4;
        buttonY += height + spaceY;
        UIButton *cancelBtn = [self buttonWithTitle:self.cancel];
        cancelBtn.tag = kActionButtonDefaultTag;
        cancelBtn.frame = CGRectMake(0, buttonY, buttonW, buttonH);
        [self.contentView addSubview:cancelBtn];
        
        self.contentView.wg_height = cancelBtn.wg_bottom;
        
    }
}
- (void)setupContentHeight {
    
    CGFloat height = 40;
    self.titleButton.wg_height = self.titleButton.hidden ? 0:height;
    self.otherTableView.wg_top = self.titleButton.wg_bottom;
    
    [self.otherTableView layoutIfNeeded];
    
    CGSize contentSize = self.otherTableView.contentSize;
    self.otherTableView.scrollEnabled = self.canScroll;
    
    if (self.canScroll) {
//        if (contentSize.height > self.maxHeight) {
//            self.otherTableView.wg_height = self.maxHeight;
//        } else {
//            self.otherTableView.wg_height = contentSize.height;
//        }
        CGFloat tableH = MIN(contentSize.height, self.maxHeight);
        self.otherTableView.wg_height = tableH;
    } else {
        CGFloat tableH = contentSize.height;
        self.otherTableView.wg_height = tableH;
    }
    
    self.cancelButton.wg_top = self.otherTableView.wg_bottom + 4;
    self.cancelButton.wg_height = height;
    self.contentView.wg_height = self.cancelButton.wg_bottom;
}

- (void)setMaxHeight:(CGFloat)maxHeight {
    _maxHeight = maxHeight;
    [self setupContentHeight];
    self.backView.backgroundColor = [self backColor];
    CGFloat height = self.contentView.wg_height;
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.backgroundColor = [self backColor];
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -height);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)didMoveToSuperview {
    [self setupContentHeight];
    self.backView.backgroundColor = [self backColor];
    CGFloat height = self.contentView.wg_height;
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.backgroundColor = [self backColor];
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -height);
    } completion:^(BOOL finished) {
        
    }];
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = kWhiteColor;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setTitleColor:kColor_Black_Sub forState:UIControlStateNormal];
    __weak typeof(self) weakself = self;
    [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        __strong typeof(weakself) strongself = weakself;
        NSInteger index = button.tag - kActionButtonDefaultTag;
        [strongself hiddenActionSheetWithAnimated:YES index:index];
    }];
    return button;
}

/** 背景色 */
- (UIColor *)backColor {
    return self.needMask ? [kBlackColor colorWithAlphaComponent:0.7]:kClearColor;
}
- (void)tapBackView:(UITapGestureRecognizer *)tap {
    [self hiddenActionSheetWithAnimated:YES index:0];
}
- (void)hiddenActionSheetWithAnimated:(BOOL)animated index:(NSInteger)index {
    
    NSTimeInterval duration = 0.25;
    [UIView animateWithDuration:duration animations:^{
        self.backView.backgroundColor = kClearColor;
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (self.completionHandle) {
            self.completionHandle(self, index);
            self.completionHandle = nil;
        }
        [self removeFromSuperview];
        
    }];
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = kColor_Black_Sub;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = kFont(14);
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    cell.textLabel.text = self.others[indexPath.row];
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.others.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hiddenActionSheetWithAnimated:YES index:indexPath.row+1];
}
#pragma mark - getter && setter 
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackView:)]];
    }
    return _backView;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = kWhiteColor;
        _contentView.backgroundColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
    }
    return _contentView;
}
- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [self buttonWithTitle:nil];
        _titleButton.hidden = YES;
    }
    return _titleButton;
}
- (UITableView *)otherTableView {
    if (!_otherTableView) {
        _otherTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _otherTableView.delegate = self;
        _otherTableView.dataSource = self;
        _otherTableView.separatorColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
        _otherTableView.separatorInset = UIEdgeInsetsZero;
        _otherTableView.layoutMargins = UIEdgeInsetsZero;
    }
    return _otherTableView;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [self buttonWithTitle:nil];
    }
    return _cancelButton;
}
- (void)dealloc {
//    WGLog(@"WGActionSheet is dealloc");
}
@end
