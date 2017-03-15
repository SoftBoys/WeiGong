//
//  WGBasicInfoDescCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoDescCell.h"
#import "WGBaseTextView.h"

@interface WGBasicInfoDescCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) WGBaseTextView *textView;
@end
@implementation WGBasicInfoDescCell

@synthesize cellItem = _cellItem;
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.textView];
    
    CGFloat spaceX = 12, spaceY = 10;
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceX);
        make.top.mas_equalTo(spaceY);
        make.width.mas_equalTo(75);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname.mas_right);
        make.right.mas_equalTo(self.arrowView.mas_right);
        make.top.mas_equalTo(3);
        make.bottom.mas_equalTo(-spaceX);
        make.height.mas_equalTo(50);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
//    self.textView.backgroundColor = kRedColor;
}
- (void)textViewDidChanged:(NSNotification *)noti {
    UITextView *textView = noti.object;
    if (textView.tag == _cellItem.cellType) {
        _cellItem.name_content = textView.text;
        if (self.cellItem.cellType == 15) {
            self.cellItem.info.resume = self.cellItem.name_content;
        }
    }
}
- (void)setCellItem:(WGBasicInfoCellItem *)cellItem {
    _cellItem = cellItem;
    if (_cellItem) {
        self.labname.text = _cellItem.name_left;
        self.textView.text = _cellItem.name_content;
        self.textView.placeholder = _cellItem.placeholder;
        self.textView.tag = _cellItem.cellType;
    }
}

#pragma mark - getter && setter
- (UILabel *)labname {
    if (!_labname) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
        
        _labname = label;
    }
    return _labname;
}
- (WGBaseTextView *)textView {
    if (!_textView) {
        WGBaseTextView *textView = [WGBaseTextView new];
        textView.placeholderColor = kColor_PlaceHolder;
        textView.font = kFont(15);
        textView.textColor = kColor_Black;
        _textView = textView;
    }
    return _textView;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
