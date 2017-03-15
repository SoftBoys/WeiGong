//
//  WG_HomeBanner.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_HomeBanner.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "WG_HomeBannerItem.h"
#import "WG_WebViewController.h"
#import "WG_JobDetailViewController.h"

#import "WG_HomeClassItem.h"
#import "WGBaseVerticalButton.h"

#import "WG_BaseViewController.h"

@interface WG_HomeBanner () <SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (nonatomic, copy) NSArray *bannerItems;
@property (nonatomic, assign) NSInteger requestId;
@property (nonatomic, strong) UIView *classBackView;
@property (nonatomic, strong) NSMutableArray <WG_HomeClassButton *>*buttonList;
@property (nonatomic, strong) NSMutableArray <WG_HomeClassButton *>*availableButtonList;
@end
@implementation WG_HomeBanner
+ (CGFloat)bannerHeight {
    return kScreenWidth * 0.46;
}
+ (CGFloat)classHeight {
    return 100;
}
- (NSMutableArray<WG_HomeClassButton *> *)availableButtonList {
    if (!_availableButtonList) {
        _availableButtonList = @[].mutableCopy;
    }
    return _availableButtonList;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kClearColor;
        
        [self addSubview:self.banner];
        [self addSubview:self.classBackView];
        
        [self.banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo([WG_HomeBanner bannerHeight]);
        }];
        [self.classBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo([WG_HomeBanner classHeight]);
        }];

    }
    return self;
}
- (void)setupBannerItems:(NSArray<WG_HomeBannerItem *> *)bannerItems {
    self.bannerItems = bannerItems;
    NSMutableArray *imageUrls = @[].mutableCopy;
    for (WG_HomeBannerItem *item in bannerItems) {
        [imageUrls wg_addObject:item.imgUrl];
    }
    self.banner.imageURLStringsGroup = [imageUrls copy];
}

- (void)setupClassItems:(NSArray<WG_HomeClassItem *> *)classItems {
    
    if (self.buttonList == nil) {
        self.buttonList = @[].mutableCopy;
    }
    self.classBackView.hidden = classItems.count == 0;
    self.wg_height = classItems.count == 0 ? [WG_HomeBanner bannerHeight]:[WG_HomeBanner bannerHeight]+[WG_HomeBanner classHeight];
    if (self.buttonList.count < classItems.count) {
        __weak typeof(self) weakself = self;
        for (NSInteger i = self.buttonList.count; i < classItems.count; i++) {
            WG_HomeClassButton *button = [WG_HomeClassButton new];
//            button.backgroundColor = kRedColor;
            button.tapHandle = ^(WG_HomeClassItem *item) {
                __strong typeof(weakself) strongself = weakself;
                if ([strongself.delegate respondsToSelector:@selector(tapClassButtonWithItem:)]) {
                    [strongself.delegate tapClassButtonWithItem:item];
                }
            };
            [self.classBackView addSubview:button];
            [self.buttonList wg_addObject:button];
        }
    }
    [self.availableButtonList removeAllObjects];
    [self.buttonList enumerateObjectsUsingBlock:^(WG_HomeClassButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < classItems.count) {
            WG_HomeClassItem *item = classItems[idx];
            obj.hidden = NO;
            obj.item = item;
            [self.availableButtonList addObject:obj];
        } else {
            obj.hidden = YES;
        }
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}
- (void)updateConstraints {
    [super updateConstraints];
    
    NSInteger count = self.availableButtonList.count;
    CGFloat buttonW = kScreenWidth/count;
    CGFloat buttonH = [WG_HomeBanner classHeight];
    
    __block UIView *lastView = nil;
    [self.availableButtonList enumerateObjectsUsingBlock:^(WG_HomeClassButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(buttonW);
            make.height.mas_equalTo(buttonH);
            make.top.mas_equalTo(0);
            if (lastView) {
                make.left.mas_equalTo(lastView.mas_right);
            } else {
                make.left.mas_equalTo(0);
            }
        }];
        
        lastView = obj;
    }];
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (index < self.bannerItems.count) {
        WG_HomeBannerItem *item = [self.bannerItems objectAtIndex:index];
        if (item.actFlag == 1) {
            WG_WebViewController *webVC = [WG_WebViewController new];
            webVC.webUrl = [self wg_appUrlWithLinkUrl:item.linkUrl];
            webVC.title = item.title;
            [(WG_BaseViewController *)[self wg_topViewController] wg_pushVC:webVC];

        } else if (item.actFlag == 2) {
            
            // TODO: 跳转到详情页面
            WG_HomeItem *homeItem = [WG_HomeItem new];
            homeItem.enterpriseJobId = item.linkUrl;

            WG_JobDetailViewController *detailVC = [WG_JobDetailViewController new];
            detailVC.homeItem = homeItem;
            [(WG_BaseViewController *)[self wg_topViewController] wg_pushVC:detailVC];
        }
    }
}
/** APP端专用链接Url */
- (NSString *)wg_appUrlWithLinkUrl:(NSString *)linkUrl {
    if (linkUrl == nil || linkUrl.length == 0) {
        return nil;
    }
    NSMutableString *muLink = linkUrl.mutableCopy;
    if ([muLink rangeOfString:@"?"].location == NSNotFound) {
        [muLink appendString:@"?"];
    }
    
    if (![muLink hasSuffix:@"&"]) {
        [muLink appendString:@"&"];
    }
    [muLink appendString:@"dtype=2"];
    
    return muLink;
}
#pragma mark - getter && setter
- (SDCycleScrollView *)banner {
    if (_banner == nil) {
        CGRect frame = CGRectZero;
        _banner = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
        _banner.currentPageDotColor = kWhiteColor;
        _banner.pageDotColor = [kWhiteColor colorWithAlphaComponent:0.5];
//        _banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _banner.placeholderImage = [UIImage imageNamed:@"back_placeholder"];
//        _banner.titlesGroup = @[];
    }
    return _banner;
}
- (UIView *)classBackView {
    if (!_classBackView) {
        _classBackView = [UIView new];
        _classBackView.backgroundColor = kWhiteColor;
    }
    return _classBackView;
}
@end

@implementation WG_HomeClassButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        
        CGFloat imageW = 45;
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(imageW);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(-10);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
            make.left.right.mas_equalTo(0);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (void)tapClick {
    __weak typeof(self) weakself = self;
    if (self.tapHandle) {
        self.tapHandle(weakself.item);
    }
}
- (void)setItem:(WG_HomeClassItem *)item {
    _item = item;
    if (_item) {
        [WGDownloadImageManager downloadImageWithUrl:item.nameUrl completeHandle:^(BOOL finished, UIImage *image) {
            if (image) {
                self.imageView.image = image;
            } else {
//                self.imageView.image = [[UIImage wg_imageWithColor:kOrangeColor] wg_resizedImage];
            }
        }];
        self.titleLabel.text = item.name;
    }
}
#pragma mark - getter && setter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel wg_labelWithFont:kFont(12) textColor:kColor_Title];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
