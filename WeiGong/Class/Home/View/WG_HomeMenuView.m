//
//  WG_HomeMenuView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_HomeMenuView.h"

#import "WG_DropDownMenu.h"
#import "WG_HomeMenuItem.h"

@interface WG_HomeMenuView () <WG_DropDownMenuDelegate, WG_DropDownMenuDataSource>
@property (nonatomic, strong) WG_DropDownMenu *menu;
@end
@implementation WG_HomeMenuView
+ (CGFloat)menuHeight {
    return 40;
}
- (instancetype)init {
    if (self = [super init]) {
//        self.backgroundColor = [UIColor redColor];
        WG_DropDownMenu *menu = [WG_DropDownMenu dropDownWithoOrigin:CGPointZero height:[WG_HomeMenuView menuHeight]];
        menu.delegate = self;
        menu.dataSource = self;
        [self addSubview:menu];
        self.menu = menu;
        
        [menu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}
- (NSArray *)testArray {
    return @[@[@"全部1", @"文本11", @"文本12", @"文本13"],
             @[@"全部2", @"文本21", @"文本22", @"文本32"],
             @[@"全部3", @"文本31", @"文本32", @"文本33", @"文本33", @"文本33", @"文本33", @"文本33", @"文本33", @"文本33", @"文本33"]];
}
- (void)setItems:(NSArray<WG_HomeMenuItem *> *)items {
    _items = [items copy];
    [self.menu reloadData];
}
#pragma mark - WG_DropDownMenuDataSource
- (NSInteger)numberOfColumnsInMenu:(WG_DropDownMenu *)menu {
    return [self.items count];
}
- (NSInteger)menu:(WG_DropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    WG_HomeMenuItem *item = self.items[column];
    return [item.menuItemList count];
}
- (NSString *)menu:(WG_DropDownMenu *)menu titleForColumn:(NSInteger)column {
    WG_HomeMenuItem *item = self.items[column];
    return item.selectItem.title;
}
- (NSString *)menu:(WG_DropDownMenu *)menu titleForRow:(NSInteger)row inColumn:(NSInteger)column {
    WG_HomeMenuItem *item = self.items[column];
    WG_HomeMenuItem *subItem = item.menuItemList[row];
    return subItem.title;
}
#pragma mark - WG_DropDownMenuDelegate
- (void)menu:(WG_DropDownMenu *)menu didSelectColumn:(NSInteger)column {
    
    UITableView *tableView = (UITableView *)self.superview;
//    WGLog(@"%@ %@ %@", NSStringFromCGRect(tableView.frame),NSStringFromCGPoint(tableView.contentOffset), NSStringFromUIEdgeInsets(tableView.contentInset));
    
    CGRect frame = [menu convertRect:menu.bounds toView:tableView];
    
    if ([tableView isKindOfClass:[UITableView class]]) {
        CGPoint contentOffset = tableView.contentOffset;
        contentOffset.y = frame.origin.y;
        [tableView setContentOffset:contentOffset animated:YES];
    }
}
- (void)menu:(WG_DropDownMenu *)menu didSelectRow:(NSInteger)row inColumn:(NSInteger)column {
    
    WG_HomeMenuItem *item = self.items[column];
    WG_HomeMenuItem *subItem = item.menuItemList[row];
    item.selectItem = subItem;
    
    [self.menu reloadData];
    
    if ([self.delegate respondsToSelector:@selector(wg_updateData)]) {
        [self.delegate wg_updateData];
    }
}
- (void)didTapCancel {
    
}
- (void)wg_tapBackView {
    [self.menu performSelector:NSSelectorFromString(@"wg_tapClick")];
}
@end
