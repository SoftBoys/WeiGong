//
//  WGJobDetailJSViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/16.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGJobDetailJSViewController.h"

@interface WGJobDetailJSViewController ()

@end

@implementation WGJobDetailJSViewController

- (void)viewDidLoad {
    
    self.webUrl = @"https://www.baidu.com";
    [super viewDidLoad];
    
    self.title = @"详情页JS";
    
    UIImage *image = [UIImage imageNamed:@"nav_back_circle"];
    [self.backButton setImage:image forState:UIControlStateNormal];
    
    
    
}


#pragma mark - Private
- (UIColor *)navbarBackgroundColor {
    return kClearColor;
}
- (BOOL)navbarLineHidden {
    return YES;
}


@end
