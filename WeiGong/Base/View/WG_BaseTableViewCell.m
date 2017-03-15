//
//  WG_BaseTableViewCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@implementation WG_BaseTableViewCell

+ (instancetype)wg_cellWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *identifier = [NSStringFromClass(self.class) stringByAppendingString:@"ID"];
    return [self wg_cellWithTableView:tableView identifier:identifier];
}
+ (instancetype)wg_cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    
    if (tableView == nil) {
        return [[self alloc] init];
    }
    
    [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self wg_setupSubViews];
    }
    return self;
}
- (void)wg_setupSubViews {
    
}

@end
