//
//  WGApplyJobCollectionHeader.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/3.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGApplyJobCollectionHeader.h"

@interface WGApplyJobCollectionHeader ()
@property (nonatomic, strong) UIButton *button_pre;
@property (nonatomic, strong) UIButton *button_next;
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, copy) NSArray *weeks;
@end
@implementation WGApplyJobCollectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.button_pre];
        [self addSubview:self.button_next];
        [self addSubview:self.labtitle];
        [self addSubview:self.line];
        
        CGFloat buttonW = 30;
        CGFloat buttonX = 0;
        [self.button_pre mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(buttonX);
            make.width.mas_equalTo(buttonW);
            make.top.height.mas_equalTo(self.labtitle);
        }];
        
        [self.button_next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-buttonX);
            make.width.top.height.mas_equalTo(self.button_pre);
        }];
        
        [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.centerX.mas_equalTo(0);
        }];
        
        CGFloat lineX = 10;
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineX);
            make.right.mas_equalTo(-lineX);
            make.top.mas_equalTo(self.labtitle.mas_bottom);
            make.height.mas_equalTo(kLineHeight);
        }];
        
        self.weeks = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
        CGFloat spaceX = 15;
        CGFloat weekW = (kScreenWidth-spaceX*2)/self.weeks.count;
        weekW = (kScreenWidth-lineX*2)/self.weeks.count;
        UIView *lastView = nil;
        for (NSInteger i = 0; i < self.weeks.count; i++) {
            UILabel *label = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = self.weeks[i];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.line.mas_bottom);
                make.width.mas_equalTo(weekW);
                make.bottom.mas_equalTo(0);
                if (lastView) {
                    make.left.mas_equalTo(lastView.mas_right);
                } else {
                    make.left.mas_equalTo(lineX);
                }
            }];
            
            lastView = label;
        }
    }
    return self;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    if (_title) {
        self.labtitle.text = _title;
    }
}
#pragma mark - getter && setter 

- (UILabel *)labtitle {
    if (!_labtitle) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
        label.textAlignment = NSTextAlignmentCenter;
        _labtitle = label;
    }
    return _labtitle;
}
- (UIButton *)button_pre {
    if (!_button_pre) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *arrowLeft_nor = [UIImage wg_arrowImageWithColor:kColor_Black size:CGSizeMake(6, 12) arrowW:kLineHeight arrowType:WGArrowImageTypeLeft];
        UIImage *arrowLeft_dis = [UIImage wg_arrowImageWithColor:kLightGrayColor size:CGSizeMake(6, 12) arrowW:kLineHeight arrowType:WGArrowImageTypeLeft];
        [button setImage:arrowLeft_nor forState:UIControlStateNormal];
        [button setImage:arrowLeft_dis forState:UIControlStateDisabled];
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if (strongself.previousHandle) {
                strongself.previousHandle();
            };
        }];
        _button_pre = button;
    }
    return _button_pre;
}
- (UIButton *)button_next {
    if (!_button_next) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *arrowRight_nor = [UIImage wg_arrowImageWithColor:kColor_Black size:CGSizeMake(6, 12) arrowW:kLineHeight arrowType:WGArrowImageTypeRight];
        UIImage *arrowRight_dis = [UIImage wg_arrowImageWithColor:kLightGrayColor size:CGSizeMake(6, 12) arrowW:kLineHeight arrowType:WGArrowImageTypeRight];
        [button setImage:arrowRight_nor forState:UIControlStateNormal];
        [button setImage:arrowRight_dis forState:UIControlStateDisabled];
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if (strongself.nextHandle) {
                strongself.nextHandle();
            };
        }];
        _button_next = button;
    }
    return _button_next;
}
- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kColor_Line;
    }
    return _line;
}

@end
