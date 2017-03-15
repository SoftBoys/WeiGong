//
//  WG_WebViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/13.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_WebViewController.h"

@implementation WG_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.webUrl) return;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    
}

@end

@implementation WG_WebViewController (JavaScript)

- (void)setJavaScript {
    
    
}

@end
