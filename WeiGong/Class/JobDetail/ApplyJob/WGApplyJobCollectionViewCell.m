//
//  WGApplyJobCollectionViewCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/3.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGApplyJobCollectionViewCell.h"
#import "WGBaseNoHightButton.h"

@interface WGApplyJobCollectionViewCell ()
@property (nonatomic, strong) WGBaseNoHightButton *button;
@end
@implementation WGApplyJobCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setItem:(WGApplyJobCollectionItem *)item {
    _item = item;
    if (_item) {

//        _item.day = @"12";
//        _item.selected = YES;
        
        self.button.enabled = _item.enabled;
        self.button.selected = _item.selected;
        
        NSString *title = _item.day;
        [self.button setTitle:title forState:UIControlStateNormal];
    }
}
#pragma mark - getter && setter
- (WGBaseNoHightButton *)button {
    if (!_button) {
        WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(16);
        [button setTitleColor:kColor_Black forState:UIControlStateNormal];
        [button setTitleColor:kWhiteColor forState:UIControlStateSelected];
        [button setTitleColor:kLightGrayColor forState:UIControlStateDisabled];
        UIImage *back_nor = [[UIImage wg_imageWithColor:kColor_Gray_Back] wg_resizedImage];
        UIImage *back_sel = [[UIImage wg_imageWithColor:kColor_Blue] wg_resizedImage];
        UIImage *back_disabled = [[UIImage wg_imageWithColor:kColor_Gray_Back] wg_resizedImage];
        [button setBackgroundImage:back_nor forState:UIControlStateNormal];
        [button setBackgroundImage:back_sel forState:UIControlStateSelected];
        [button setBackgroundImage:back_disabled forState:UIControlStateDisabled];
        button.userInteractionEnabled = NO;
//        __weak typeof(self) weakself = self;
//        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//            __strong typeof(weakself) strongself = weakself;
//            strongself.item.selected = !strongself.item.isSelected;
//            strongself.item = strongself.item;
//        }];
        _button = button;
    }
    return _button;
}

@end

@implementation WGApplyJobCollectionItem


@end
