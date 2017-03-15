//
//  WGBaseNoHightButton.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBaseNoHightButton.h"

@implementation WGBaseNoHightButton

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += self.insets.left + self.insets.right;
    size.height += self.insets.top + self.insets.bottom;
    return size;
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
