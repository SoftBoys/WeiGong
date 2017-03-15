//
//  WG_JobRequireCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobRequireCell.h"
#import "WG_JobDetail.h"

@implementation WG_JobRequireCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setDetail:(WG_JobDetail *)detail {
    _detail = detail;
}
@end
