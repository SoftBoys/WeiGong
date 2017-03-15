//
//  WG_DropDownCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_DropDownCell.h"

@implementation WG_DropDownCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.separatorInset = UIEdgeInsetsZero;
        self.textLabel.font = kFont_15;
        self.textLabel.textColor = kColor_Black_Sub;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setText:(NSString *)text {
    self.textLabel.text = text;
}
@end
