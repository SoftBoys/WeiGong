//
//  WG_SearchHistoryCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_SearchHistoryCell.h"
#import "WG_SearchHistoryTool.h"


@interface WG_SearchHistoryCell ()
@property (nonatomic, strong) UILabel *labname;
@end
@implementation WG_SearchHistoryCell

- (void)wg_setupSubViews {
    
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.labname = [UILabel wg_labelWithFont:kFont_16 textColor:kColor_Black_Sub];
    [self.contentView addSubview:self.labname];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.centerY.mas_equalTo(0);
    }];
//    
//    float offsetX = 15;
//    UIEdgeInsets insets = UIEdgeInsetsMake(0, offsetX, 0, offsetX);
//    self.separatorInset = insets;
//    self.layoutMargins = insets;
//    
//    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(offsetX);
//        make.right.mas_offset(-offsetX);
//        make.top.bottom.mas_offset(0);
//    }];
//    
    [self.arrowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
    }];
    
    UIImageView *imageView = [UIImageView new];
    UIImage *image = [WG_SearchHistoryCell backImageWithColor:kColor_White];
    imageView.image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    self.backgroundView = imageView;
    
    UIImageView *selectImageView = [UIImageView new];
    UIImage *selectImage = [WG_SearchHistoryCell backImageWithColor:kColor_Gray_Back];
    selectImageView.image = [selectImage stretchableImageWithLeftCapWidth:selectImage.size.width*0.5 topCapHeight:image.size.height*0.5];
    self.selectedBackgroundView = selectImageView;
}

- (void)setItem:(WG_SearchHistoryItem *)item {
    _item = item;
    if (_item) {
        self.labname.text = _item.name;
    }
}

+ (UIImage *)backImageWithColor:(UIColor *)color {
    
    CGSize size = CGSizeMake(kScreenWidth, 5);
    
//    CGRect rect = (CGRect){0, 0, size};
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    float offsetX = 12;
    CGPoint point0 = CGPointMake(offsetX, 0);
    CGPoint point1 = CGPointMake(kScreenWidth-offsetX, 0);
    CGPoint point2 = CGPointMake(kScreenWidth-offsetX, size.height);
    CGPoint point3 = CGPointMake(offsetX, size.height);
    CGContextMoveToPoint(context, point0.x, point0.y);
    CGContextAddLineToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, point3.x, point3.y);
    CGContextAddLineToPoint(context, point0.x, point0.y);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
//    CGContextSetLineWidth(context, 5);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextDrawPath(context, kCGPathEOFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
@end
