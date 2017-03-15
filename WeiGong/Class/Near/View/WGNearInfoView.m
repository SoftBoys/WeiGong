//
//  WGNearInfoView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/7.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGNearInfoView.h"
#import "WGNearMapItem.h"

@interface WGNearInfoView ()
@property (nonatomic, strong) UILabel *labjobname;
@property (nonatomic, strong) UILabel *labcompanyname;
@property (nonatomic, strong) UILabel *labaddress;
@property (nonatomic, strong) UILabel *labprice;
@property (nonatomic, strong) UILabel *labdistance;
@end
@implementation WGNearInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.labjobname];
        [self addSubview:self.labcompanyname];
        [self addSubview:self.labaddress];
        [self addSubview:self.labprice];
        [self addSubview:self.labdistance];
        
        [self.labjobname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(5);
            make.width.mas_equalTo(kScreenWidth-80);
            make.height.mas_equalTo(20);
        }];
        [self.labcompanyname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.mas_equalTo(self.labjobname);
            make.top.mas_equalTo(self.labjobname.mas_bottom);
            make.width.mas_equalTo(self.labjobname);
        }];
        [self.labaddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.mas_equalTo(self.labjobname);
            make.top.mas_equalTo(self.labcompanyname.mas_bottom);
            make.width.mas_equalTo(kScreenWidth-80);
        }];
        [self.labprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
//            make.width.mas_equalTo(40);
            make.height.mas_equalTo(25);
        }];
        [self.labdistance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.height.mas_equalTo(self.labprice);
            make.top.mas_equalTo(self.labprice.mas_bottom);
            make.width.mas_equalTo(70);
        }];
        
    }
    return self;
}

- (void)setMapItem:(WGNearMapItem *)mapItem {
    _mapItem = mapItem;
    if (_mapItem) {
        
        self.labjobname.text = _mapItem.jobName;
        self.labcompanyname.text = _mapItem.enterpriseName;
        self.labaddress.text = _mapItem.address;
        self.labprice.text = [NSString stringWithFormat:@"%@元/%@",_mapItem.salary,_mapItem.salaryStandard];
        self.labdistance.text = [NSString stringWithFormat:@"%@km",_mapItem.distance];
        
    }
}
#pragma mark - getter && setter  
- (UILabel *)labjobname {
    if (!_labjobname) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kWhiteColor];
        
        _labjobname = label;
    }
    return _labjobname;
}
- (UILabel *)labcompanyname {
    if (!_labcompanyname) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kWhiteColor];
        
        _labcompanyname = label;
    }
    return _labcompanyname;
}
- (UILabel *)labaddress {
    if (!_labaddress) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kWhiteColor];
        
        _labaddress = label;
    }
    return _labaddress;
}
- (UILabel *)labprice {
    if (!_labprice) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Orange];
        label.textAlignment = NSTextAlignmentRight;
        _labprice = label;
    }
    return _labprice;
}
- (UILabel *)labdistance {
    if (!_labdistance) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kWhiteColor];
        label.textAlignment = NSTextAlignmentRight;
        _labdistance = label;
    }
    return _labdistance;
}

@end
