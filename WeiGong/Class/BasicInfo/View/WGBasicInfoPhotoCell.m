//
//  WGBasicInfoPhotoCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoPhotoCell.h"
#import "WGBasicInfo.h"

#import "WGActionSheet.h"

@interface WGBasicInfoPhotoCell ()
@property (nonatomic, strong) NSMutableArray *phoneButtonList;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation WGBasicInfoPhotoCell
@synthesize cellItem = _cellItem;
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.addButton];
    
    CGFloat spaceX = 10, spaceY = 10;
    NSInteger maxCount = 5;
    CGFloat buttonW = (kScreenWidth-(maxCount + 1)*spaceX)/maxCount;
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceX);
        make.width.height.mas_equalTo(buttonW);
        make.top.mas_equalTo(spaceY);
        make.bottom.mas_equalTo(-spaceY);
    }];
}

- (void)setCellItem:(WGBasicInfoCellItem *)cellItem {
    _cellItem = cellItem;
    if (_cellItem) {
        
        NSArray<WGBasicInfoPhotoItem *> *photoItemList = _cellItem.photoItemList;
        self.addButton.hidden = photoItemList.count >= 5;
        
        [self.phoneButtonList enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
            button.tag = 100 + idx;
            if (idx < photoItemList.count) {
                WGBasicInfoPhotoItem *item = photoItemList[idx];
                
                [WGDownloadImageManager downloadImageWithUrl:item.picUrlS completeHandle:^(BOOL finished, UIImage *image) {
                    [button setBackgroundImage:image forState:UIControlStateNormal];
                }];
                button.hidden = NO;
                
            } else {
                button.hidden = YES;
            }
            
        }];
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
    }
}
- (void)updateConstraints {
    [super updateConstraints];
    NSArray<WGBasicInfoPhotoItem *> *photoItemList = _cellItem.photoItemList;
    CGFloat spaceX = 10;
    NSInteger maxCount = 5;
    CGFloat buttonW = (kScreenWidth-(maxCount + 1)*spaceX)/maxCount;
    CGFloat addX = spaceX +(buttonW + spaceX)*photoItemList.count;
    [self.addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addX);
    }];
    
}
- (UIButton *)getPhotoButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longImage:)];
    longPress.minimumPressDuration = 0.5; //定义按的时间
    [button addGestureRecognizer:longPress];
    
    __weak typeof(self) weakself = self;
    [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
        NSInteger index = sender.tag - 100;
        if (index < _cellItem.photoItemList.count) {
            WGBasicInfoPhotoItem *item = _cellItem.photoItemList[index];
            __strong typeof(weakself) strongself = weakself;
            if ([strongself.delegate respondsToSelector:@selector(wg_clickPicLifeWithItem:)]) {
                [strongself.delegate wg_clickPicLifeWithItem:item];
            }
        }
        
    }];
    [self.contentView addSubview:button];
    return button;
}

- (void)longImage:(UILongPressGestureRecognizer *)longPress {
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIButton *button = (UIButton *)[longPress view];
        NSArray<WGBasicInfoPhotoItem *> *photoItemList = _cellItem.photoItemList;
        NSInteger index = button.tag - 100;
        
        if (index < photoItemList.count) {
            WGBasicInfoPhotoItem *item = photoItemList[index];
            if ([self.delegate respondsToSelector:@selector(wg_deletePicLifeWithItem:)]) {
                [self.delegate wg_deletePicLifeWithItem:item];
            }
            
        }
    }
    
    
    
}

#pragma mark - getter && setter 
- (UIButton *)addButton {
    if (!_addButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *imageback = [[[UIImage wg_imageWithColor:kWhiteColor size:CGSizeMake(20, 20)] wg_imageWithCornerRadius:3 borderWidth:kLineHeight borderColor:kColor_Orange] wg_resizedImage];
        [button setImage:[UIImage imageNamed:@"info_addphone"] forState:UIControlStateNormal];
        [button setBackgroundImage:imageback forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if ([strongself.delegate respondsToSelector:@selector(wg_addPicLife)]) {
                [strongself.delegate wg_addPicLife];
            }
        }];
        _addButton = button;
    }
    return _addButton;
}
- (NSMutableArray *)phoneButtonList {
    if (!_phoneButtonList) {
        NSMutableArray *buttonList = @[].mutableCopy;
        __block UIView *lastView = nil;
        for (NSInteger i = 0; i < 5; i++) {
            UIButton *button = [self getPhotoButton];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.width.height.mas_equalTo(self.addButton);
                if (lastView) {
                    make.left.mas_equalTo(lastView.mas_right).offset(10);
                } else {
                    make.left.mas_equalTo(10);
                }
            }];
            lastView = button;
            [buttonList wg_addObject:button];
        }
        _phoneButtonList = buttonList;
    }
    return _phoneButtonList;
}
@end
