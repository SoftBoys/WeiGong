//
//  WGevaluationProgressView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/8.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGEvaluationProgressCell.h"
#import "WGBaseLabel.h"
#import "WGEvaluationInfo.h"

@interface WGEvaluationProgressButton : UIButton

@end

@implementation WGEvaluationProgressButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = kFont(13);
        [self setTitleColor:kWhiteColor forState:UIControlStateNormal];
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted { }
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize imageSize = self.currentImage.size;
    return (CGRect){0,0,imageSize};
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 5;
    return (CGRect){5,0,self.wg_width-titleX,self.wg_height};
}
@end
#define kProgressW  (kScreenWidth - 150)
#define kProgressH  20
@interface WGEvaluationProgressCell ()
@property (nonatomic, strong) WGBaseLabel *labname;
@property (nonatomic, strong) WGEvaluationProgressButton *button_progress;
@property (nonatomic, strong) UILabel *labtime;
@end
@implementation WGEvaluationProgressCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = kClearColor;
    self.contentView.backgroundColor = kClearColor;
    UIView *backView = [UIView new];
    backView.backgroundColor = kWhiteColor;
    [self insertSubview:backView belowSubview:self.contentView];
    
    
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.button_progress];
    [self.contentView addSubview:self.labtime];
    
    CGFloat left = 12;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, left, 0, left));
    }];
    
    CGFloat nameX = 40;
    CGFloat nameY = 10;
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.mas_equalTo(nameY);
    }];
    [self.button_progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname);
        make.top.mas_equalTo(self.labname.mas_bottom);
        make.width.mas_equalTo(kProgressW);
        make.height.mas_equalTo(kProgressH);
        make.bottom.mas_equalTo(-nameY);
    }];
    [self.labtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.button_progress.mas_right).offset(5);
        make.centerY.mas_equalTo(self.button_progress);
    }];
}

- (void)setItem:(WGEvaluationListItem *)item {
    _item = item;
    if (_item) {
//        _item.myHours = @"10";
        
        _item.color = _item.color ?: @"259cdd";
        
        self.labname.text = _item.markName;
        
        self.labtime.text = kStringAppend(_item.sumHours, @"小时");
        [self.button_progress setTitle:kStringAppend(_item.myHours, @"小时") forState:UIControlStateNormal];
        
        CGFloat imageW = (kProgressW*[_item.myHours integerValue]/[_item.sumHours integerValue]);
        UIImage *image = [[UIImage wg_imageWithColor:[UIColor wg_colorWithHexString:_item.color] size:CGSizeMake(imageW, kProgressH)] wg_imageWithCornerRadius:kProgressH/2];
        [self.button_progress setImage:image forState:UIControlStateNormal];
        
    }
}
#pragma mark - getter && setter 
- (WGBaseLabel *)labname {
    if (!_labname) {
        WGBaseLabel *label = [WGBaseLabel wg_labelWithFont:kFont(14) textColor:kColor_Black];
        label.insets = UIEdgeInsetsMake(5, 0, 5, 0);
        _labname = label;
    }
    return _labname;
}
- (UILabel *)labtime {
    if (!_labtime) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
        _labtime = label;
    }
    return _labtime;
}
- (WGEvaluationProgressButton *)button_progress {
    if (!_button_progress) {
        WGEvaluationProgressButton *button = [WGEvaluationProgressButton buttonWithType:UIButtonTypeCustom];
        UIColor *backColor = [UIColor wg_colorWithHexString:@"#e5e5e5"];
        UIImage *backImage = [[UIImage wg_imageWithColor:backColor size:CGSizeMake(kProgressW, kProgressH)] wg_imageWithCornerRadius:kProgressH/2];
        [button setBackgroundImage:backImage forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        _button_progress = button;
    }
    return _button_progress;
}

#pragma mark - private


@end


