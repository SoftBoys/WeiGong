//
//  UIBarButtonItem+Addition.m
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/1.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "UIBarButtonItem+Addition.h"
#import <objc/runtime.h>

const void *kBtnBlockKey;
const void *kItemBlockKey;
@implementation UIBarButtonItem (Addition)

+ (instancetype)wg_itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (highlightImage) {
        [button setImage:highlightImage forState:UIControlStateHighlighted];
    }
    button.frame = (CGRect){CGPointZero, button.currentImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[[self class] alloc] initWithCustomView:button];
    return barBtnItem;
}
+ (instancetype)wg_itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage touchBlock:(WGBarButtonTouchBlock)block {
    
    UIBarButtonItem *barBtnItem = [self wg_itemWithImage:image highlightImage:highlightImage target:self action:@selector(btnTouch:)];
    UIButton *button = (UIButton *)barBtnItem.customView;
    objc_setAssociatedObject(button, kBtnBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return barBtnItem;
}

+ (instancetype)wg_itemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor target:(id)target action:(SEL)action {
    UIBarButtonItem *barBtnItem = [[[self class] alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    barBtnItem.tintColor = tintColor;
    return barBtnItem;
}

+ (instancetype)wg_itemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor touchBlock:(WGBarButtonTouchBlock)block {
    UIBarButtonItem *barBtnItem = [self wg_itemWithTitle:title tintColor:tintColor target:self action:@selector(itemTouch:)];
    barBtnItem.block = block;
    return barBtnItem;
}


+ (void)btnTouch:(UIButton *)button {
    WGBarButtonTouchBlock block = objc_getAssociatedObject(button, kBtnBlockKey);
    if (block) {
        __weak typeof(button) weakbutton = button;
        block(weakbutton);
    }
}

+ (void)itemTouch:(UIBarButtonItem *)barBtnItem {
    if (barBtnItem.block) {
        __weak typeof(barBtnItem) weakself = barBtnItem;
        barBtnItem.block(weakself);
    }
}

- (WGBarButtonTouchBlock)block {
    return objc_getAssociatedObject(self, kItemBlockKey);
}
- (void)setBlock:(WGBarButtonTouchBlock)block {
    objc_setAssociatedObject(self, kItemBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
