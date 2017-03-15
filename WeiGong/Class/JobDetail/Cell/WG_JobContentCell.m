//
//  WG_JobContentCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobContentCell.h"
#import "WG_JobDetail.h"
#import "WG_IconButton.h"

@interface WG_JobContentCell ()
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UILabel *labcontent;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, strong) UIView *lastView;
@end
@implementation WG_JobContentCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labtitle];
    
    UIView *line = [UIView new];
    line.backgroundColor = kColor_Line;
    [self.contentView addSubview:line];
    
    [self.contentView addSubview:self.labcontent];
    
    float titleX = 10;
    float spaceY = 3;
    [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleX);
        make.top.mas_equalTo(spaceY);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleX);
        make.right.mas_equalTo(-titleX);
        make.height.mas_equalTo(kLineHeight);
        make.top.mas_equalTo(self.labtitle.mas_bottom).offset(spaceY);
    }];
    [self.labcontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleX);
        make.right.mas_equalTo(-titleX);
        make.top.mas_equalTo(line.mas_bottom).offset(spaceY);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-spaceY);
    }];
    
    self.buttons = @[].mutableCopy;
}
- (void)setType:(NSInteger)type {
    _type = type;
    NSString *title = type == 0 ? @"工作内容":@"工作要求";
    self.labtitle.text = title;
}
- (void)setDetail:(WG_JobDetail *)detail {
    _detail = detail;
    if (_detail) {
        
        NSString *content = self.type == 0 ? _detail.jobDesc:_detail.jobRequire;
        if (content.length == 0) {
            content = @"无";
        }
        self.labcontent.text = content;
        
//        self.lastView = self.labcontent;
        self.titles = nil;
        if (self.type == 1) {
            
            NSArray<NSString *> *markList = [_detail.requireStr componentsSeparatedByString:@","];
            NSMutableArray *muTitles = @[].mutableCopy;
            for (NSString *title in markList) {
                NSString *newTitle = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
                if (newTitle.length) {
                    [muTitles addObject:title];
                }
            }
            self.titles = [muTitles copy];
            if (self.titles.count) {
                WG_IconButton *lastBtn = nil;
                if (self.buttons.count < self.titles.count) {
                    for (NSInteger i = self.buttons.count; i < markList.count; i++) {
                        WG_IconButton *button = [self wg_button];
                        [self.contentView addSubview:button];
                        [button mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(self.labcontent.mas_bottom).offset(3);
                            make.height.mas_equalTo(25);
                            if (lastBtn) {
                                make.left.mas_equalTo(lastBtn.mas_right).offset(5);
                            } else {
                                make.left.mas_equalTo(10);
                            }
                        }];
                        lastBtn = button;
                        [self.buttons addObject:button];
                    }
                }
                [self.buttons enumerateObjectsUsingBlock:^(WG_IconButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.hidden = YES;
                    if (idx < self.titles.count) {
                        if ([self.titles[idx] length]) {
                            obj.hidden = NO;
                            [obj setTitle:self.titles[idx] forState:UIControlStateNormal];
                        }
                    }
                }];
                
                self.lastView = lastBtn;
            }
            
            
        }
        
        [self needsUpdateConstraints];
    }
}
- (void)updateConstraints {
    
//    [self.lastView mas_updateConstraints:^(MASConstraintMaker *make) {
//        if (self.titles.count) {
//            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-3).priorityHigh();
//        } else {
//            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-3).priorityHigh();
//        }
//    }];
    
    if (self.titles.count) {
        [self.labcontent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-3).priorityLow();
        }];
        if (self.lastView) {
            [self.lastView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8).priorityHigh();
            }];
        }
    } else {
        [self.labcontent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-3).priorityHigh();
        }];
        if (self.lastView) {
            [self.lastView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-3).priorityLow();
            }];
        }
    }
    
    [super updateConstraints];
}

- (WG_IconButton *)wg_button {
    WG_IconButton *button = [WG_IconButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    button.space = 12;
    button.titleLabel.font = kFont_13;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:kColor_Orange forState:UIControlStateNormal];
    
    UIImage *backImage = [[[UIImage wg_imageWithColor:[UIColor clearColor] size:CGSizeMake(10, 10) ] wg_imageWithCornerRadius:3 borderWidth:kLineHeight borderColor:kColor_Orange] wg_resizedImage];
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    return button;
}

- (UILabel *)labtitle {
    if (!_labtitle) {
        _labtitle = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black];
    }
    return _labtitle;
}
- (UILabel *)labcontent {
    if (!_labcontent) {
        _labcontent = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black_Sub];
        _labcontent.numberOfLines = 0;
    }
    return _labcontent;
}
@end
