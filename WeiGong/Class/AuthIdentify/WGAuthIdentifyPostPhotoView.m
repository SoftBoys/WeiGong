//
//  WGAuthIdentifyPostPhotoView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGAuthIdentifyPostPhotoView.h"

@interface WGAuthIdentifyPostPhotoView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *postButton;

@end
@implementation WGAuthIdentifyPostPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kClearColor;
        [self addSubview:self.imageView];
        [self addSubview:self.postButton];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
//            make.height.mas_equalTo(220);
//            make.bottom.mas_equalTo(0);
        }];
        
        [self.postButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.centerX.mas_equalTo(0);

            make.bottom.mas_equalTo(-10);
        }];
        
    }
    return self;
}

- (void)setItem:(WGAuthIdentifyPostPhotoItem *)item {
    _item = item;
    if (_item) {
//        WGLog(@"WGAuthIdentifyPostPhotoItem:%@",_item);
        self.imageView.image = _item.placeholderImage;
        self.postButton.hidden = !_item.showButton;
//        self.button.hidden = YES;
        [self.postButton setTitle:_item.title forState:UIControlStateNormal];
        [WGDownloadImageManager downloadImageWithUrl:_item.imageUrl completeHandle:^(BOOL finished, UIImage *image) {
            if (image) {
                self.imageView.image = image;
//                _item.placeholderImage = image;
            }
        }];
        
//        CGFloat width = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width;
//        WGLog(@"width:%@",@(width));
//        self.selfW = width;
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
}
- (void)updateConstraints {
    [super updateConstraints];
    
    CGFloat imageH = self.item.imageH;
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(imageH);
        if (!_item.showButton) {
            make.bottom.mas_equalTo(-10);
        }
    }];
    
    [self.postButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        if (_item.showButton) {
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
            
//            make.top.mas_equalTo(self.imageView.mas_bottom).offset(0);
//            make.height.mas_equalTo(0);
        } else {
            make.width.height.mas_equalTo(0);
        }
    }];
}
- (void)tapImage:(UIImageView *)imageView {
    if ([self.delegate respondsToSelector:@selector(didClickImageWithItem:)]) {
        [self.delegate didClickImageWithItem:self.item];
    }
}
#pragma mark - getter && setter 
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.layer.masksToBounds = YES;
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = 6;
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
    }
    return _imageView;
}
- (UIButton *)postButton {
    if (!_postButton) {
        _postButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _postButton.titleLabel.font = kFont(14);
        [_postButton setTitleColor:kColor_Orange forState:UIControlStateNormal];
        _postButton.clipsToBounds = YES;
        _postButton.layer.masksToBounds = YES;
        _postButton.layer.cornerRadius = 4;
        _postButton.layer.borderColor = kColor_Orange.CGColor;
        _postButton.layer.borderWidth = kLineHeight;
//        _postButton.backgroundColor = kGreenColor;
        __weak typeof(self) weakself = self;
        [_postButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if ([strongself.delegate respondsToSelector:@selector(didClickUpdateButtonWithItem:)]) {
                [strongself.delegate didClickUpdateButtonWithItem:strongself.item];
            }
        }];
    }
    return _postButton;
}
@end

@implementation WGAuthIdentifyPostPhotoItem


@end
