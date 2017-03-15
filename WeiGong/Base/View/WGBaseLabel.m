//
//  WGBaseLabel.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/14.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBaseLabel.h"

@implementation WGBaseLabel

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += self.insets.left + self.insets.right;
    size.height += self.insets.top + self.insets.bottom;
    return size;
}

@end
