//
//  UIButton+Addition.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/29.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "UIButton+Addition.h"
#import <objc/runtime.h>

const void *kBlockKey;
@implementation UIButton (Addition)

+ (instancetype)wg_buttonWithImage:(UIImage *)image hightImage:(UIImage *)hightImage backImage:(UIImage *)backImage touchBlock:(TouckBlock)block {
    UIButton *button = [self wg_buttonWithImage:image hightImage:hightImage backImage:backImage target:self action:@selector(touchClick:)];
    button.block = block;
    return button;
}
+ (instancetype)wg_buttonWithImage:(UIImage *)image hightImage:(UIImage *)hightImage backImage:(UIImage *)backImage target:(id)target action:(SEL)action {
    UIButton *button = [[[self class] alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:hightImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (instancetype)wg_buttonWithTitle:(NSString *)title normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor textFont:(UIFont *)textFont touchBlock:(TouckBlock)block {
    UIButton *button = [self wg_buttonWithTitle:title normalColor:normalColor selectColor:selectColor textFont:textFont target:self action:@selector(touchClick:)];
    button.block = block;
    return button;
}
+ (instancetype)wg_buttonWithTitle:(NSString *)title normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor textFont:(UIFont *)textFont target:(id)target action:(SEL)action {
    UIButton *button = [[[self class] alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectColor forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (void)touchClick:(UIButton *)button {
    if (button.block) {
        __weak typeof(button) weakself = button;
        button.block(weakself);
    }
}

#pragma mark - getter && setter
- (TouckBlock)block {
    return objc_getAssociatedObject(self, kBlockKey);
}
- (void)setBlock:(TouckBlock)block {
    objc_setAssociatedObject(self, kBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end



//static char *kHighlightedKey;
//@implementation UIButton (State)
//- (void)setDisableHighlightedState:(BOOL)disableHighlightedState {
//    objc_setAssociatedObject(self, &kHighlightedKey, @(disableHighlightedState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (BOOL)disableHighlightedState {
//    return [objc_getAssociatedObject(self, &kHighlightedKey) boolValue];
//}
//- (void)setHighlighted:(BOOL)highlighted {
//    if (self.disableHighlightedState == NO) {
//        [super setHighlighted:highlighted];
//    }
//}
//@end

