//
//  WGEvaluationHeadCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/8.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGEvaluationHeadCell.h"
#import "WGEvaluationInfo.h"
#import "TSPRadarView.h"


@interface WGEvaluationHeadCell ()
@property (nonatomic, strong) TSPRadarView *radarView;
@property (nonatomic, strong) UIView *line;
@end
@implementation WGEvaluationHeadCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = kClearColor;
    self.contentView.backgroundColor = kClearColor;
    
    UIView *backView = [UIView new];
    backView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:backView];
    
    self.line = [UIView new];
    self.line.backgroundColor = kColor_Gray_Back;
    [backView addSubview:self.line];
    [backView addSubview:self.radarView];
    
    CGFloat left = 12;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, left, 0, left));
//        make.height.mas_equalTo(200);
    }];
    
    CGFloat lineX = 12;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineX);
        make.right.mas_equalTo(-lineX);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kLineHeight);
    }];
    
    
    CGFloat radarH = 240;
    CGFloat spaceY = 20;
    [self.radarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(spaceY);
        make.height.mas_equalTo(radarH);
        make.bottom.mas_equalTo(-spaceY);
    }];
    CGFloat offsetY = self.radarView.r * 0.25;
    self.radarView.centerPoint = CGPointMake(kScreenWidth/2.0-left, radarH/2.0 + offsetY);
    
}

- (void)setInfo:(WGEvaluationInfo *)info {
    _info = info;
    if (_info) {
//        _info.normativeScore = @"3";
//        _info.developmentScore = @"5";
        self.radarView.dataSeries = @[@[@([_info.normativeScore integerValue]), @([_info.developmentScore integerValue]), @([_info.disciplineScore integerValue])]];
        
    }
}

#pragma mark - getter && setter 
- (TSPRadarView *)radarView {
    if (!_radarView) {
        NSArray *titles = @[@"规范性", @"成长性", @"纪律性"];
        TSPRadarView *radarView = [[TSPRadarView alloc] init];
        radarView.backgroundLineColorRadial = kWhiteColor;
        radarView.maxValue = 10;
        radarView.steps = 1;
        radarView.attributes = titles;
        //    radarView.colorOpacity = 1;
        radarView.circleLineColor = kColor_Blue; // kColor_Line
        radarView.r = 120;
        radarView.nameColor = kColor_Black_Sub;
        radarView.nameFont = kFont(14);
        radarView.type = 0;
//        radarView.fillArea = YES;
        radarView.backgroundFillColor = kColor_Blue;
//        radarView.showLegend = YES;
        [radarView setColors:@[kColor_Orange]];
//        [radarView setTitles:@[@"12"]];
//        radarView.backgroundColor = kColor_Navbar;
        
        _radarView = radarView;
    }
    return _radarView;
}

@end
