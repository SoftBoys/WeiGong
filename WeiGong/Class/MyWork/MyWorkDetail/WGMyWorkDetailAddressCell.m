//
//  WGMyWorkDetailAddressCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMyWorkDetailAddressCell.h"
#import "WGMyWorkDetail.h"
#import "NSAttributedString+Addition.h"

@interface WGMyWorkDetailAddressCell ()
@property (nonatomic, strong) UILabel *labaddress;
@end
@implementation WGMyWorkDetailAddressCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.labaddress];
    
    CGFloat addressX = 12, addressY = 5;
    [self.labaddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addressX);
        make.top.mas_equalTo(addressY);
        make.bottom.mas_equalTo(-addressY);
        make.right.mas_equalTo(-addressX);
    }];
    
}

- (void)setWorkDetail:(WGMyWorkDetail *)workDetail {
    _workDetail = workDetail;
    if (_workDetail) {
        NSString *key = nil, *content = nil;
        
        if (self.index == 0) {
            key = @"时间：";
            NSString *workDate = [[NSDate wg_dateWithDateString:_workDetail.workDate dateFormat:@"yyyyMMdd"] wg_stringWithDateFormat:@"yyyy-MM-dd"];
            content = [NSString stringWithFormat:@"%@ %@-%@", workDate, _workDetail.startTime, _workDetail.stopTime];
        } else if (self.index == 1) {
            key = @"地点：";
            content = _workDetail.address;
        } else if (self.index == 2) {
            key = @"签到：";
            content = _workDetail.startTime;
        }else if (self.index == 3) {
            key = @"签退：";
            content = _workDetail.stopTime;
        }
        NSAttributedString *attAddress =  [NSAttributedString wg_attStringWithString:kStringAppend(key, content) keyWord:key font:kFont(15) highlightColor:kColor_Black_Sub textColor:kColor_Black];
        self.labaddress.attributedText = attAddress;
    }
}

- (UILabel *)labaddress {
    if (!_labaddress) {
        _labaddress = [UILabel wg_labelWithFont:nil];
    }
    return _labaddress;
}

@end
