//
//  WG_BaseWebViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseViewController.h"
#import <WebKit/WebKit.h>

@interface WG_BaseWebViewController : WG_BaseViewController <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
/** 进度条颜色 (默认为蓝色) */
- (UIColor *)progressColor;
@end
