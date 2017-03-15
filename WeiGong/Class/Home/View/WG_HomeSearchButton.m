//
//  WG_HomeSearchButton.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/13.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_HomeSearchButton.h"

@implementation WG_HomeSearchButton
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
        float offsetX = 10;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, offsetX, 0, -offsetX);
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted {}
@end
