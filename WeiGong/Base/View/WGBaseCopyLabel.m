//
//  WGBaseCopyLabel.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/14.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBaseCopyLabel.h"

@implementation WGBaseCopyLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self pressAction];
    }
    return self;
}

- (void)pressAction {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longAction:)];
    longGesture.minimumPressDuration = 0.6;
    
    [self addGestureRecognizer:longGesture];
}

- (void)longAction:(UILongPressGestureRecognizer *)longGesture {
    if (longGesture.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"拷贝" action:@selector(wg_copy:)];
        menu.menuItems = @[copyItem];
        [menu setTargetRect:self.frame inView:self.superview];
        [menu setMenuVisible:YES animated:YES];
    }
}
- (void)wg_copy:(id)sender {
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = self.text;
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
