//
//  WGAddAccountCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGAddAccountItem;

@protocol WGAddAccountCellDelegate <NSObject>

- (void)chooseBankWithItem:(WGAddAccountItem *)item;

@end

@interface WGAddAccountCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGAddAccountItem *item;
@property (nonatomic, weak) id<WGAddAccountCellDelegate> delegate;
@end

@interface WGAddAccountItem : NSObject

@property (nonatomic, copy) NSString *name_left;

@property (nonatomic, copy) NSString *name_content;

@property (nonatomic, copy) NSString *placeholer;

@property (nonatomic, assign) BOOL canInput;

@property (nonatomic, assign) NSInteger index;

@end
