//
//  WG_TableViewHeader.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/13.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_TableViewGifHeader.h"

@implementation WG_TableViewGifHeader


- (void)prepare {
    [super prepare];
    
    NSMutableArray *array = [NSMutableArray new];
    for (NSUInteger i = 0; i < 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"header_anim_0%zd", i++]];
        if (image) {
            [array addObject:image];
        }
    }
    
    [self setImages:@[[UIImage imageNamed:@"header_anim_01"]] forState:MJRefreshStateIdle];
    

    NSTimeInterval duration = 0.25;
    [self setImages:array duration:duration forState:MJRefreshStatePulling];
    
    [self setImages:array duration:duration forState:MJRefreshStateRefreshing];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
}

@end
