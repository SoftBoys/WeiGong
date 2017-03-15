//
//  WGSignUpTimeView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGSignUpTimeView.h"
#import "WGSignUpDetail.h"

@interface WGSignUpTimeView ()
@property (nonatomic, strong) UILabel *labname;
@end

@implementation WGSignUpTimeView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black];
        [self addSubview:label];
        self.labname = label;
        UIView *line = [UIView new];
        line.backgroundColor = kColor_Line;
        [self addSubview:line];
        
        [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(0);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(kLineHeight);
        }];
    }
    return self;
}

- (void)setTimestamp:(NSTimeInterval)timestamp {
    _timestamp = timestamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *dateString = [date wg_stringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.labname.text = kStringAppend(@"时间：", dateString);
}

@end
