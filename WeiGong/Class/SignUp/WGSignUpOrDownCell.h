//
//  WGSignUpOrDownCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGSignUpListItem;

@protocol WGSignUpOrDownCellDelegate <NSObject>

- (void)signUpOrDownWithItem:(WGSignUpListItem *)item;

@end

@interface WGSignUpOrDownCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGSignUpListItem *item;
@property (nonatomic, weak) id<WGSignUpOrDownCellDelegate> delegate;
@end
