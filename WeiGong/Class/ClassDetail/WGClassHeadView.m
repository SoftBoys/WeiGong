//
//  WGClassHeadView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/16.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGClassHeadView.h"
#import "WGBaseLabel.h"
#import "NSAttributedString+Addition.h"

@interface WGClassButtonView : UIButton
@property (nonatomic, assign) BOOL isStrench;
@property (nonatomic, strong) UIImage *image_top;
@property (nonatomic, strong) UIImage *image_bottom;
@end
@implementation WGClassButtonView
- (void)setIsStrench:(BOOL)isStrench {
    _isStrench = isStrench;
    if (_isStrench) {
        [self setImage:self.image_top forState:UIControlStateNormal];
    } else {
        [self setImage:self.image_bottom forState:UIControlStateNormal];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = kFont(15);
        [self setTitleColor:kWhiteColor forState:UIControlStateNormal];
        
        CGSize size = CGSizeMake(12, 6);
//        self.image_bottom = [self arrowImageWithColor:kWhiteColor size:size arrowW:kLineHeight isStretch:NO];
//        self.image_top = [self arrowImageWithColor:kWhiteColor size:size arrowW:kLineHeight isStretch:YES];
        
        self.image_bottom = [UIImage wg_arrowImageWithColor:kWhiteColor size:size arrowW:kLineHeight arrowType:WGArrowImageTypeBottom];
        self.image_top = [UIImage wg_arrowImageWithColor:kWhiteColor size:size arrowW:kLineHeight arrowType:WGArrowImageTypeTop];
        self.isStrench = NO;
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize size = self.currentImage.size;
    CGFloat spaceR = 15;
    CGFloat imageX = CGRectGetWidth(self.frame)-spaceR-size.width;
    CGFloat imageY = (CGRectGetHeight(self.frame)-size.height)*0.5;
    return (CGRect){imageX, imageY, size};
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 12, titleY = 0;
    CGFloat titleW = kScreenWidth/2.0;
    CGFloat titleH = CGRectGetHeight(self.frame);
    return (CGRect){titleX, titleY, titleW, titleH};
    
}

@end


@interface WGClassHeadView ()
@property (nonatomic, copy) void (^tableViewHandle)(WGClassHeadView *header, CGFloat height);
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) WGClassButtonView *titleView;
@property (nonatomic, strong) WGBaseLabel *contentView;

@property (nonatomic, assign) CGFloat selfHeight;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) BOOL isStrench;

@end
@implementation WGClassHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        self.iconView = [UIImageView new];
//        self.iconView.backgroundColor = kBlueColor;
        [self addSubview:self.iconView];
        
        __weak typeof(self) weakself = self;
        self.titleView = [WGClassButtonView new];
        self.titleView.backgroundColor = [kBlackColor colorWithAlphaComponent:0.4];
        [self.titleView setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
//            strongself.titleView.isStrench = !strongself.titleView.isStrench;
            [strongself clickTitleView];
            
        }];
        [self addSubview:self.titleView];
        
        
        self.contentView = [WGBaseLabel wg_labelWithFont:kFont(12) textColor:kBlackColor];
//        self.contentView.backgroundColor = kGreenColor;
        self.contentView.numberOfLines = 0;
//        self.contentView.font = kFont(13);
        [self addSubview:self.contentView];
        
        CGFloat iconViewH = kScreenWidth * 0.40;
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(iconViewH);
        }];
        
        CGFloat titleViewH = 28;
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.iconView.mas_bottom);
            make.height.mas_equalTo(titleViewH);
        }];
        
        CGFloat contentLeft = 12, contentTop = 10;
        self.contentView.preferredMaxLayoutWidth = kScreenWidth-contentLeft*2;
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.titleView.mas_bottom).offset(contentTop);
            
            make.left.mas_equalTo(contentLeft);
            make.right.mas_equalTo(-contentLeft);
            make.bottom.mas_equalTo(self).offset(-contentTop);
            
            make.height.mas_equalTo(0);
        }];
        
        
//        [self.titleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView2)]];
        
//        [self updateFrameWithIsStrench:self.isStrench];
        
        CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        self.selfHeight = height;
        self.wg_height = height;
        
        
    }
    return self;
}

- (void)setClassItem:(WG_HomeClassItem *)classItem {
    _classItem = classItem;
    if (_classItem) {
        
        [WGDownloadImageManager downloadImageWithUrl:_classItem.nameUrlDefault completeHandle:^(BOOL finished, UIImage *image) {
            if (image) {
                self.iconView.image = image;
            }
        }];
        
        [self.titleView setTitle:_classItem.name forState:UIControlStateNormal];
        
        NSString *string = _classItem.nameContent;
        UIFont *font = kFont(12);
//        NSAttributedString *attStr = [NSAttributedString wg_attStringWithString:string keyWord:nil highlightFont:nil font:font highlightColor:nil textColor:kColor_Title lineSpace:3 searhType:kAttributedSearchTypeSingle];
//        self.contentView.attributedText = attStr;
        
        self.contentView.preferredMaxLayoutWidth = kScreenWidth-12*2;
        self.contentView.font = font;
        self.contentView.text = string;
        
//        self.contentHeight = height;
//        self.contentView.backgroundColor = kRedColor;
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
}

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    if (_tableView) {
        _tableView.tableHeaderView = self;
    }
}

- (void)clickTitleView {
    self.isStrench = !self.isStrench;
    
    self.contentView.text = self.isStrench ? _classItem.nameContent : nil;
    
    
    self.titleView.isStrench = self.isStrench;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self updateFrameWithIsStrench:self.isStrench];
    
//    self.view3.hidden = !self.isStrench;

}
- (void)updateConstraints {
    [super updateConstraints];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.isStrench) {
            
            make.top.mas_equalTo(self.titleView.mas_bottom).offset(10);
            
//            make.height.mas_equalTo(self.contentHeight);
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
            make.bottom.mas_equalTo(self).offset(-10);
        } else {
            make.height.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self).offset(0);
            make.top.mas_equalTo(self.titleView.mas_bottom).offset(0);
        }
    }];
    
}
- (void)updateFrameWithIsStrench:(BOOL)isStrench {
    self.isStrench = isStrench;
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.selfHeight = height;
    
    self.wg_height = self.selfHeight;
    self.tableView.tableHeaderView = self;
//     [self.tableViewlayoutIfNeeded];
//    self.tableViewHandle = self.tableViewHandle;
}
@end
