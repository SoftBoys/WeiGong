//
//  WG_JobAddressCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobAddressCell.h"
#import "WG_JobDetail.h"
#import "WG_IconButton.h"

@interface WG_JobAddressCell ()
@property (nonatomic, strong) WG_IconButton *addressButton;
@property (nonatomic, strong) WG_IconButton *moreButton;
@end
@implementation WG_JobAddressCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    [self.contentView addSubview:self.addressButton];
    [self.contentView addSubview:self.moreButton];
    
    [self.addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.right.mas_lessThanOrEqualTo(self.moreButton.mas_left);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.bottom.mas_equalTo(0);
    }];
}

- (void)setDetail:(WG_JobDetail *)detail {
    _detail = detail;
    if (_detail) {
        NSArray *jobplaces = _detail.jobplaces;
        NSString *button_title = jobplaces.count > 1 ? @"更多":nil;
        [self.moreButton setTitle:button_title forState:UIControlStateNormal];
//        self.selectionStyle = self.moreButton.hidden ? UITableViewCellSelectionStyleNone:UITableViewCellSelectionStyleDefault;
        NSString *title = nil;
        if (jobplaces) {
            title = [(WG_JobAddressItem *)[jobplaces firstObject] jobAddress];
            for (WG_JobAddressItem *item in jobplaces) {
                if (item.defaultFlag == 1) {
                    title = item.jobAddress;
                    break;
                }
            }
        }
//        title = @"北京欢迎你北京欢迎你北京欢迎你北京欢迎你北京欢迎你北京欢迎你北京欢迎你";
        [self.addressButton setTitle:title forState:UIControlStateNormal];
    }
}

- (WG_IconButton *)addressButton {
    if (!_addressButton) {
        _addressButton = [WG_IconButton buttonWithType:UIButtonTypeCustom];
        _addressButton.userInteractionEnabled = NO;
        _addressButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_addressButton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
        [_addressButton setTitle:@"地点" forState:UIControlStateNormal];
        _addressButton.space = 4;
    }
    return _addressButton;
}
- (WG_IconButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [WG_IconButton buttonWithType:UIButtonTypeCustom];
        _moreButton.userInteractionEnabled = NO;
        _moreButton.type = 1;
        [_moreButton setImage:[self wg_image] forState:UIControlStateNormal];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        _moreButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_moreButton setTitleColor:kColor_Orange forState:UIControlStateNormal];
        _moreButton.space = 4;
    }
    return _moreButton;
}

- (UIImage *)wg_image {
    
    CGSize size = CGSizeMake(6, 10);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(size.width, size.height/2.0);
    CGPoint point3 = CGPointMake(0, size.height);
    

    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, point3.x, point3.y);
    
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, kColor_Orange.CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
