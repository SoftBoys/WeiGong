//
//  WG_JobFootView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/9.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobFootView.h"
#import "WG_JobDetail.h"
#import "WG_VerticalIconButton.h"

#import "MBProgressHUD+WG_Extension.h"
#import "WG_UserDefaults.h"
#import "WGLoginTool.h"

#import "WGJobCollectParam.h"

@interface WG_JobFootView ()
@property (nonatomic, strong) WG_VerticalIconButton *collectButton;
@property (nonatomic, strong) WG_VerticalIconButton *consultButton;
@property (nonatomic, strong) UIButton *applyButton;
@property (nonatomic, assign) NSUInteger requestId;
@end
@implementation WG_JobFootView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor_Line;
        
        [self addSubview:self.collectButton];
        [self addSubview:self.consultButton];
        [self addSubview:self.applyButton];
        
        [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kLineHeight);
            make.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(80);
        }];
        
        [self.consultButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.collectButton);
            make.width.mas_equalTo(self.collectButton);
            make.left.mas_equalTo(self.collectButton.mas_right).offset(kLineHeight);
        }];
        [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.collectButton);
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(self.consultButton.mas_right);
        }];
        
    }
    return self;
}
- (void)setDetail:(WG_JobDetail *)detail {
    _detail = detail;
    self.hidden = _detail == nil;
    if (_detail) {
        self.collectButton.selected = _detail.favorite;
        
        BOOL enabled = YES;
        NSString *applyTitle = @"立即申请";
        if (_detail.personalJobId) {
            if (_detail.postFlag == 1) {
                applyTitle = @"撤销申请";
            } else {
                applyTitle = @"已经申请";
                enabled = NO;
            }
        }
        
        
        [self.applyButton setTitle:applyTitle forState:UIControlStateNormal];
        
        self.applyButton.enabled = enabled;
    }
}

- (void)wg_collectClick {
    
    BOOL isLogin = [[WG_UserDefaults shareInstance] isLogin];
    if (!isLogin) {
        [WGLoginTool loginWithCompleteHandle:^(WGBaseResponse *response) {
            
        }];
        return;
    }
    
    if (self.detail == nil) {
        WGLog(@"获取数据失败");
        return;
    }
    
    BOOL isCollect = !self.collectButton.selected;
    self.collectButton.userInteractionEnabled = NO;
    [MBProgressHUD wg_showHub_CanTap];
    // 1  2
    NSInteger postFlag = isCollect ? 1:2;
    WGJobCollectParam *param = [WGJobCollectParam new];
    param.enterpriseJobId = kIntToStr(self.detail.enterpriseJobId);
    param.enterpriseInfoId = kIntToStr(self.detail.enterpriseInfoId);
    param.personalInfoId = [WG_UserDefaults shareInstance].userId;
    param.postFlag = @(postFlag);
    /** 收藏职位 */
    NSString *url = @"/linggb-ws/ws/0.1/job/setJobfavorite";
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        [MBProgressHUD wg_hideHub];
        self.collectButton.userInteractionEnabled = YES;
        if (response.responseJSON) {
            if (response.statusCode == 200) {
                self.collectButton.selected = !self.collectButton.selected;
                NSString *message = @"收藏成功";
                if (!isCollect) {
                    message = @"取消收藏成功";
                }
                WGLog(message);
                [MBProgressHUD wg_message:message];
            }
            //                WGLog([response description]);
        }
    }];

}
- (void)wg_consultClick {
    BOOL isLogin = [[WG_UserDefaults shareInstance] isLogin];
    if (!isLogin) {
        [WGLoginTool loginWithCompleteHandle:^(WGBaseResponse *response) {
            
        }];
        return;
    }
    if (self.detail.overdue == 2) {
        [MBProgressHUD wg_message:@"职位已过期,不可操作"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(wg_consult)]) {
        [self.delegate wg_consult];
    }
    
}

- (WG_VerticalIconButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [WG_VerticalIconButton buttonWithType:UIButtonTypeCustom];
        [_collectButton setImage:[UIImage imageNamed:@"collect_nor"] forState:UIControlStateNormal];
        [_collectButton setImage:[UIImage imageNamed:@"collect_sel"] forState:UIControlStateSelected];
        [_collectButton setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectButton setTitle:@"取消收藏" forState:UIControlStateSelected];
        _collectButton.titleLabel.font = kFont_12;
        _collectButton.space = 3;
        [_collectButton setTitleColor:kColor_Blue forState:UIControlStateNormal];
        [_collectButton setTitleColor:kColor_Blue forState:UIControlStateSelected];
        _collectButton.backgroundColor = kColor_White;
        [_collectButton addTarget:self action:@selector(wg_collectClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectButton;
}
- (WG_VerticalIconButton *)consultButton {
    if (!_consultButton) {
        _consultButton = [WG_VerticalIconButton buttonWithType:UIButtonTypeCustom];
        [_consultButton setImage:[UIImage imageNamed:@"talk"] forState:UIControlStateNormal];
        [_consultButton setTitle:@"咨询" forState:UIControlStateNormal];
        _consultButton.titleLabel.font = kFont_12;
        _consultButton.space = 3;
        [_consultButton setTitleColor:kColor_Blue forState:UIControlStateNormal];
        [_consultButton setTitleColor:kColor_Blue forState:UIControlStateSelected];
        _consultButton.backgroundColor = kColor_White;
        [_consultButton addTarget:self action:@selector(wg_consultClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _consultButton;
}
- (UIButton *)applyButton {
    if (!_applyButton) {
        _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _applyButton.titleLabel.font = kFont_15;
        [_applyButton setTitleColor:kColor_White forState:UIControlStateNormal];
//        [_applyButton setTitleColor:kColor_PlaceHolder forState:UIControlStateDisabled];
        [_applyButton setTitle:@"立即申请" forState:UIControlStateNormal];
//        _applyButton.backgroundColor = kColor_Blue;
        
        UIImage *image_nor = [[UIImage wg_imageWithColor:kColor_Blue] wg_resizedImage];
        UIImage *image_hig = [[UIImage wg_imageWithColor:[kColor_Blue colorWithAlphaComponent:0.8]] wg_resizedImage];
        UIImage *image_disable = [[UIImage wg_imageWithColor:kColor_PlaceHolder] wg_resizedImage];
        [_applyButton setBackgroundImage:image_nor forState:UIControlStateNormal];
        [_applyButton setBackgroundImage:image_hig forState:UIControlStateHighlighted];
        [_applyButton setBackgroundImage:image_disable forState:UIControlStateDisabled];
        
        __weak typeof(self) weakself = self;
        [_applyButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            
            BOOL isLogin = [[WG_UserDefaults shareInstance] isLogin];
            if (!isLogin) {
                [WGLoginTool loginWithCompleteHandle:^(WGBaseResponse *response) {
                    
                }];
                return;
            }
            if (strongself.detail.overdue == 2) {
                [MBProgressHUD wg_message:@"职位已过期,不可操作"];
                return;
            }
            if ([strongself.delegate respondsToSelector:@selector(wg_applyOrNot)]) {
                [strongself.delegate wg_applyOrNot];
            }
        }];
    }
    return _applyButton;
}
@end
