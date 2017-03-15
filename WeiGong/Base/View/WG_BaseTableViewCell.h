//
//  WG_BaseTableViewCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WG_BaseTableViewCell : UITableViewCell
/** 复用Cell的初始化方法 */
+ (instancetype)wg_cellWithTableView:(UITableView *)tableView;
/** 复用Cell的初始化方法 */
+ (instancetype)wg_cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
/** 初始化子控件 */
- (void)wg_setupSubViews;
@end
