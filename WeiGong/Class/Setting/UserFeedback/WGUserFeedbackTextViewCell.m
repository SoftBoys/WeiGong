//
//  WGUserFeedbackTextViewCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGUserFeedbackTextViewCell.h"
#import "WGUserDeedbackContactCell.h"
#import "WGBaseTextView.h"

#define kTextViewTag  300
@interface WGUserFeedbackTextViewCell ()
@property (nonatomic, strong) WGBaseTextView *textView;
@property (nonatomic, strong) UILabel *labcount;
@end
@implementation WGUserFeedbackTextViewCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.labcount];
    
    CGFloat left = 10;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-left);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.labcount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.textView.mas_right);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(0);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:nil];
    [self textDidChanged];
}
- (void)textDidChanged {
    NSInteger length = self.textView.text.length;
    NSInteger maxCount = 1000;
    if (length > maxCount) {
        self.textView.text = [self.textView.text substringToIndex:maxCount];
    }
    
    self.item.name_content = self.textView.text;
    
    NSString *countText = [NSString stringWithFormat:@"%@/%@",@(self.textView.text.length),@(maxCount)];
    self.labcount.text = countText;
}


- (void)setItem:(WGUserDeedbackContactItem *)item {
    _item = item;
    if (_item) {
        self.textView.text = _item.name_content;
        self.textView.placeholder = _item.placeholer;
        self.textView.tag = kTextViewTag + _item.index;
    }
}

- (WGBaseTextView *)textView {
    if (!_textView) {
        _textView = [[WGBaseTextView alloc] init];
//        _textView.placeholder = @"你的每一个意见对我们都很重要";
        _textView.font = kFont(14);
        _textView.textColor = kColor_Black;
        _textView.placeholderColor = kColor_PlaceHolder;
    }
    return _textView;
}
- (UILabel *)labcount {
    if (!_labcount) {
        _labcount = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_PlaceHolder];
    }
    return _labcount;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
