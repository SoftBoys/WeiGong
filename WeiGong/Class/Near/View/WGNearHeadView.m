//
//  WGNearHeadView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/7.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGNearHeadView.h"

@interface WGNearHeadView () <UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UILabel *labaddress;
@property (nonatomic, strong) UIButton *button_refresh;
@end

@implementation WGNearHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor(236, 235, 232);
        [self addSubview:self.searchBar];
        [self addSubview:self.labaddress];
        [self addSubview:self.button_refresh];
        
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        [self.labaddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.searchBar.mas_bottom);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth-40);
        }];
        
        [self.button_refresh mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.labaddress);
            make.width.mas_equalTo(40);
            make.right.mas_equalTo(0);
        }];

    }
    return self;
}
- (void)setAddress:(NSString *)address {
    _address = address;
    if (_address) {
        self.labaddress.text = kStringAppend(@" 位置：", _address);
    
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if (searchBar.text) {
        [searchBar resignFirstResponder];
        __weak typeof(self) weakself = self;
        if (self.searchHandle) {
            self.searchHandle(weakself.searchBar.text);
        }
    }
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - getter && setter 
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        UISearchBar *searchBar = [UISearchBar new];
        searchBar.delegate = self;
        searchBar.placeholder = @"搜索";
        searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        
        UIView *backView = [UIView new];
        backView.backgroundColor = kColor(249, 249, 249);
        [searchBar insertSubview:backView atIndex:1];
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        _searchBar = searchBar;
    }
    return _searchBar;
}
- (UILabel *)labaddress {
    if (!_labaddress) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black];
        label.text = @" 位置：请稍等,正在加载...";
        _labaddress = label;
    }
    return _labaddress;
}
- (UIButton *)button_refresh {
    if (!_button_refresh) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"signup_location"] forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if (strongself.locationHandle) {
                strongself.locationHandle();
            }
        }];
        _button_refresh = button;
    }
    return _button_refresh;
}
@end
