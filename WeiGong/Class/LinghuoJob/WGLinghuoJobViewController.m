//
//  WGLinghuoJobViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGLinghuoJobViewController.h"
#import "WG_WebViewController.h"
#import "WGLinghuoDetailViewController.h"

#import "WGLinghuoJobDetail.h"

#import "WGBaseNoHightButton.h"
@interface WGLinghuoJobViewController ()
@property (nonatomic, strong) WGLinghuoJobDetail *detail;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIImageView *remindImageView;
@property (nonatomic, strong) UILabel *labremind;
@property (nonatomic, strong) WGBaseNoHightButton *button_lastMonth;
@end

@implementation WGLinghuoJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"灵活就业";
    
    [self setRightItem];
    [self makeUI];
}
- (void)makeUI {
    [self.view addSubview:self.remindImageView];
    [self.view addSubview:self.labremind];
    [self.view addSubview:self.button_lastMonth];
    CGFloat imageW = 120, imageH = imageW;
    [self.remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageW);
        make.height.mas_equalTo(imageH);
        make.center.mas_equalTo(CGPointMake(0, -30));
    }];
    
    CGFloat remindX = 30;
    [self.labremind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(remindX);
        make.right.mas_equalTo(-remindX);
        make.top.mas_equalTo(self.remindImageView.mas_bottom).offset(10);
    }];
    
    [self.button_lastMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.labremind);
        make.bottom.mas_equalTo(-30);
        make.height.mas_equalTo(40);
    }];
    
    self.button_lastMonth.hidden = YES;
}
- (void)setRightItem {
    __weak typeof(self) weakself = self;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:kOrangeColor forState:UIControlStateNormal];
    button.titleLabel.font = kFont(15);
//    [button setTitle:@"灵活就业" forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"easywork_save"];
    [button setImage:image forState:UIControlStateNormal];
    [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        __strong typeof(weakself) strongself = weakself;
        if (strongself.detail) {
            
            WG_WebViewController *webVC = [WG_WebViewController new];
            webVC.webUrl = strongself.detail.linkUrl;
            webVC.title = strongself.detail.linkTitle;
            [strongself wg_pushVC:webVC];
        }
    }];
    [self.navBar addSubview:button];
    self.rightButton = button;
    button.hidden = YES;
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(kNavigationBarHeight);
    }];
}

- (void)wg_loadData {
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:self.requestUrl];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.responseJSON) {
//            WGLog(@"linghuo:%@",response);
            WGLinghuoJobDetail *detail = [WGLinghuoJobDetail wg_modelWithDictionry:response.responseJSON];
            self.detail = detail;
            
            
            self.rightButton.hidden = self.detail == nil;
            
            
            [WGDownloadImageManager downloadImageWithUrl:detail.contentUrl completeHandle:^(BOOL finished, UIImage *image) {
                if (image) {
                    self.remindImageView.image = image;
                }
            }];
            
            self.labremind.text = detail.content;
            
            self.button_lastMonth.hidden = detail.agileFlag != 3;
            
        }
    }];
    
}
- (void)pushPreViewController {
    WGLinghuoDetailViewController *linghuoDetailVC = [WGLinghuoDetailViewController new];
    
    [self wg_pushVC:linghuoDetailVC];
}
#pragma mark - getter && setter 
- (UIImageView *)remindImageView {
    if (!_remindImageView) {
        _remindImageView = [UIImageView new];
//        _remindImageView.backgroundColor = kRedColor;
    }
    return _remindImageView;
}
- (UILabel *)labremind {
    if (!_labremind) {
        _labremind = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
        _labremind.textAlignment = NSTextAlignmentCenter;
        _labremind.numberOfLines = 0;
    }
    return _labremind;
}
- (WGBaseNoHightButton *)button_lastMonth {
    if (!_button_lastMonth) {
        _button_lastMonth = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [[[UIImage wg_imageWithColor:kColor_Blue size:CGSizeMake(20, 20)] wg_imageWithCornerRadius:5] wg_resizedImage];
        [_button_lastMonth setBackgroundImage:image forState:UIControlStateNormal];
        [_button_lastMonth setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_button_lastMonth setTitle:@"上月工作情况" forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [_button_lastMonth setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself pushPreViewController];
        }];
    }
    return _button_lastMonth;
}
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/shebao/agileInfo";
}

@end
