//
//  WGTrainViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/8.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGTrainViewController.h"
#import "WGBaseNoHightButton.h"

@interface WGTrainViewController ()
@property (nonatomic, strong) WGBaseNoHightButton *button;
@end

@implementation WGTrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"培训";

    self.view.backgroundColor = kColor(103, 204, 204);
    
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}

#pragma mark - getter && setter 
- (WGBaseNoHightButton *)button {
    if (!_button) {
        WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *image = [UIImage imageNamed:@"train_icon"];
        [button setImage:image forState:UIControlStateNormal];
        _button = button;
    }
    return _button;
}

@end
