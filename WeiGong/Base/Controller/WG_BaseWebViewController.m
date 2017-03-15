//
//  WG_BaseWebViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseWebViewController.h"

@interface WG_BaseWebViewController ()
@property (nonatomic, strong) UIView *progressView;
@end

@implementation WG_BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:self.webView belowSubview:[self navBar]];
    
    [self.view addSubview:self.progressView];
    
    // 监听进度条的进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        double pregress = [change[NSKeyValueChangeNewKey] doubleValue];
//        NSLog(@"%.2f", pregress);
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame = self.progressView.frame;
            frame.size.width = kScreenWidth * (pregress);
//            NSLog(@"width:%.2f", frame.size.width);
            self.progressView.frame = frame;
        } completion:^(BOOL finished) {
            if (pregress >= 1.0) {
                self.progressView.hidden = YES;
            }
        }];
    } else if ([keyPath isEqualToString:@"scrollView.contentSize"]) {
//        change[NSKeyValueChangeNewKey]
//        WGLog(@"change:%@", change);
    }
}
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
}

- (UIColor *)progressColor {
    return kColor_Blue;
}
#pragma mark - getter && setter
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
        _webView.frame = CGRectMake(0, kTopBarHeight, kScreenWidth, kScreenHeight-kTopBarHeight);
        _webView.allowsBackForwardNavigationGestures = NO;
        _webView.navigationDelegate = self;
//        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _webView;
}
- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [UIView new];

        float progressH = 2.0f;
        float progressY = kTopBarHeight;
        _progressView.frame = CGRectMake(0, progressY, 0, progressH);
        _progressView.backgroundColor = [self progressColor] ?:kColor_Blue;
    }
    return _progressView;
}
#pragma mark - WKNavigationDelegate



@end
