//
//  WG_MineViewController+WG_Extension.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineViewController+WG_Extension.h"
#import "WG_MineCellItem.h"

#import "WG_MineUser.h"

@implementation WG_MineViewController (WG_Extension)

- (NSArray<NSArray *> *)wg_cellItemSectionsNoLogin {
    
    NSMutableArray *sections = [NSMutableArray new];
    
    NSArray *array1 = [self wg_cellItem2];
    WG_MineCellItem *item = [array1 firstObject];
    item.cellType = 1;
    
    [sections addObject:[self wg_cellItem0]];
    [sections addObject:array1];
    [sections addObject:[self wg_cellItem3]];
    [sections addObject:[self wg_cellItem4]];
    
    return [sections copy];
}
- (NSArray<NSArray *> *)wg_cellItemSectionsNoAgile {
    
    WG_MineUser *user = [self valueForKey:@"user"];
    
    if (user == nil) {
        return [self wg_cellItemSectionsNoLogin];
    } else {
        NSMutableArray *sections = [NSMutableArray new];
        [sections addObject:[self wg_cellItem0]];
        [sections addObject:[self wg_cellItem2]];
        [sections addObject:[self wg_cellItem3]];
        [sections addObject:[self wg_cellItem4]];
        return [sections copy];
    }
}
- (NSArray<NSArray *> *)wg_cellItemSectionsHaveAgile {
    WG_MineUser *user = [self valueForKey:@"user"];
    
    if (user == nil) {
        return [self wg_cellItemSectionsNoLogin];
    } else {
        NSMutableArray *sections = [NSMutableArray new];
        [sections addObject:[self wg_cellItem0]];
        [sections addObject:[self wg_cellItem1]];
        [sections addObject:[self wg_cellItem2]];
        [sections addObject:[self wg_cellItem3]];
        [sections addObject:[self wg_cellItem4]];
        return [sections copy];
    }
}

- (NSArray <WG_MineCellItem *>*)wg_cellItem0 {
    WG_MineUser *user = [self valueForKey:@"user"];
    NSString *title = nil;
    if (user.accountTotal) {
        title = kStringAppend(user.accountTotal, @"元");
    } else {
        title = kStringAppend(@(0), @"元");
    }
    
    NSArray *titles = @[title];
    NSArray *images = @[[UIImage imageNamed:@"mine_account"]];
    NSMutableArray *items = [NSMutableArray new];
    for (NSInteger i = 0; i < titles.count; i++) {
        WG_MineCellItem *item = [WG_MineCellItem new];
        item.cellType = 0;
        item.name_left = titles[i];
        item.icon = images[i];
        [items addObject:item];
    }
    return [items copy];
}
- (NSArray <WG_MineCellItem *>*)wg_cellItem1 {
    NSArray *titles = @[@"灵活就业"];
    NSArray *images = @[[UIImage imageNamed:@"mine_easywork"]];
    NSMutableArray *items = [NSMutableArray new];
    for (NSInteger i = 0; i < titles.count; i++) {
        WG_MineCellItem *item = [WG_MineCellItem new];
        item.name_left = titles[i];
        item.icon = images[i];
        item.cellType = 1;
        item.type = 1;
        [items addObject:item];
    }
    return [items copy];
}
- (NSArray <WG_MineCellItem *>*)wg_cellItem2 {
    NSArray *titles = @[@"身份认证", @"基本信息"];
    NSArray *images = @[[UIImage imageNamed:@"mine_identify"], [UIImage imageNamed:@"mine_info"]];
    NSMutableArray *items = [NSMutableArray new];
    WG_MineUser *user = [self valueForKey:@"user"];
    for (NSInteger i = 0; i < titles.count; i++) {
        WG_MineCellItem *item = [WG_MineCellItem new];
        item.name_left = titles[i];
        item.icon = images[i];
        item.cellType = i == 0 ? 2:1;
        item.name_right = [self rightnameWithCheckFlag:user.checkFlag];
        item.type = i + 2;
        [items addObject:item];
    }
    return [items copy];
}
- (NSArray <WG_MineCellItem *>*)wg_cellItem3 {
    NSArray *titles = @[@"签到签退", @"我的工作"];
    NSArray *images = @[[UIImage imageNamed:@"mine_signup"], [UIImage imageNamed:@"mine_mywork"]];
    NSMutableArray *items = [NSMutableArray new];
    for (NSInteger i = 0; i < titles.count; i++) {
        WG_MineCellItem *item = [WG_MineCellItem new];
        item.name_left = titles[i];
        item.icon = images[i];
        item.cellType = 1;
        item.type = i + 4;
        [items addObject:item];
    }
    return [items copy];
}
- (NSArray <WG_MineCellItem *>*)wg_cellItem4 {
    NSArray *titles = @[@"工作订单"];
    NSArray *images = @[[UIImage imageNamed:@"mine_expense"], [UIImage imageNamed:@"mine_expense"]];
    NSMutableArray *items = [NSMutableArray new];
    for (NSInteger i = 0; i < titles.count; i++) {
        WG_MineCellItem *item = [WG_MineCellItem new];
        item.name_left = titles[i];
        item.icon = images[i];
        item.cellType = 1;
        item.type = i + 6;
        [items addObject:item];
    }
    return [items copy];
}

- (NSString *)rightnameWithCheckFlag:(NSUInteger)checkFlag {
    NSString *name = @"未认证";
    switch (checkFlag) {
        case 0:
            name = @"未认证";
            break;
        case 1:
            name = @"认证审核中";
            break;
        case 2:
            name = @"认证通过";
            break;
        case 3:
            name = @"认证失败";
            break;
            
        default:
            name = @"认证失败";
            break;
    }
    return name;
}

@end
