//
//  WGApplyJobDateCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGApplyJobDateCell.h"
#import "WGApplyJobCollectionView.h"
#import "WGApplyJobListItem.h"
#import "WGApplyJobCollectionViewCell.h"
#import "WGApplyJobCollectionHeader.h"
#import "WGBaseNoHightButton.h"

#import "NSAttributedString+Addition.h"

@interface WGApplyJobDateCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) WGApplyJobCollectionView *collectionView;
@property (nonatomic, strong) UILabel *labcount;
@property (nonatomic, strong) WGBaseNoHightButton *button_selectAll;
@property (nonatomic, assign) CGFloat collectionH;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger needUpdate;

@end

@implementation WGApplyJobDateCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.labcount];
    [self.contentView addSubview:self.button_selectAll];
    self.collectionView.backgroundColor = kWhiteColor;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
    }];
    [self.labcount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(self.collectionView.mas_bottom);
        make.height.mas_equalTo(35);

    }];
    [self.button_selectAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.collectionView.mas_bottom);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(0);
    }];

    self.needUpdate = YES;
}
- (void)checkSelectDaysAndStateButton {
    
    BOOL isSelectAll = YES;
    for (WGApplyJobCollectionItem *item in self.dataArray) {
        if (item.enabled && item.isSelected == NO) {
            isSelectAll = NO;
        }
    }
    NSInteger count_select = 0;
    for (NSArray *itemList in _item.monthList) {
        for (WGApplyJobCollectionItem *item in itemList) {
            if (item.enabled && item.isSelected) {
                count_select ++;
            }
        }
    }
    
    self.labcount.attributedText = [self attStringWithCount:count_select];
    self.button_selectAll.selected = isSelectAll;
    [self.collectionView reloadData];
    
}
- (void)setItem:(WGApplyJobListItem *)item {
    _item = item;
    if (_item) {
        NSArray *monthList = _item.monthList;
        self.date = [self dateWithIndex:self.index];
        self.dataArray = monthList[self.index];
        
        [self checkSelectDaysAndStateButton];
        
        [self.collectionView layoutIfNeeded];
        CGFloat height = self.collectionView.contentSize.height;
        self.collectionH = height;
        
        if (self.needUpdate) {
            if (self.refreshHandle) {
                self.refreshHandle();
            }
            self.needUpdate = NO;
        }
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
}
- (NSDate *)dateWithIndex:(NSInteger)index {
    NSCalendar *calendar = [self wg_calendar];
    NSCalendarUnit kCalendarUnit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:kCalendarUnit fromDate:[NSDate date]];
    components.month = components.month + index;
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}
- (NSCalendar *)wg_calendar {
    static NSCalendar *calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
            calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        } else {
            calendar = [NSCalendar currentCalendar];
        }
        //        NSLog(@"calendar");
    });
    return calendar;
}
#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WGApplyJobCollectionItem *item = self.dataArray[indexPath.item];
    WGApplyJobCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.item = item;
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray count];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        WGApplyJobCollectionHeader *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier forIndexPath:indexPath];
        headView.title = [self.date wg_stringWithDateFormat:@"yyyy年MM月"];
        __weak typeof(self) weakself = self;
        headView.previousHandle = ^() {
            __strong typeof(weakself) strongself = weakself;
            
            if (strongself.index > 0) {
                strongself.index --;
//                strongself.date = [strongself.date wg_lastMonth];
                if (strongself.refreshHandle) {
                    strongself.refreshHandle();
                }
            }
            
        };
        headView.nextHandle = ^() {
            __strong typeof(weakself) strongself = weakself;
            NSInteger count = strongself.item.monthList.count;
            if (strongself.index < count - 1) {
                strongself.index ++;
//                strongself.date = [strongself.date wg_nextMonth];
                if (strongself.refreshHandle) {
                    strongself.refreshHandle();
                }
            }
            
            
        };
        
        return headView;
    }
    return nil;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WGApplyJobCollectionItem *item = self.dataArray[indexPath.item];
    if (item.enabled) {
        item.selected = !item.isSelected;
        [self checkSelectDaysAndStateButton];
    }
//    WGApplyJobCollectionViewCell *cell = (WGApplyJobCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.item = item;
    
    
}
- (NSAttributedString *)attStringWithCount:(NSInteger)count {
    NSString *name1 = @"已选择", *key = kIntToStr(count), *name2 = @"天";
    NSAttributedString *attString = [NSAttributedString wg_attStringWithString:[NSString stringWithFormat:@"%@%@%@",name1,key,name2] keyWord:key font:kFont(15) highlightColor:kColor_Blue textColor:kColor_Black];
    return attString;
}
#pragma mark - getter && setter  
- (WGApplyJobCollectionView *)collectionView {
    if (!_collectionView) {
        __weak typeof(self) weakself = self;
        WGApplyJobCollectionView *collection = [[WGApplyJobCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        collection.delegate = self;
        collection.dataSource = self;
        [collection registerClass:[WGApplyJobCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        [collection registerClass:[WGApplyJobCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier];
        
        self.date = [NSDate date];
        self.index = 0;
        
        _collectionView = collection;
    }
    return _collectionView;
}
- (UILabel *)labcount {
    if (!_labcount) {
        _labcount = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
        _labcount.text = @"已选择0天";
    }
    return _labcount;
}
- (WGBaseNoHightButton *)button_selectAll {
    if (!_button_selectAll) {
        WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(15);
        [button setTitle:@"全选" forState:UIControlStateNormal];
        [button setTitleColor:kColor_Black forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"applyjob_nor"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"applyjob_sel"] forState:UIControlStateSelected];
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            strongself.button_selectAll.selected = !strongself.button_selectAll.isSelected;
            BOOL isQuanxuan = strongself.button_selectAll.isSelected;
            [strongself clickQuanxuan:isQuanxuan];
            
        }];
        _button_selectAll = button;
    }
    return _button_selectAll;
}
#pragma mark - 点击全选按钮
- (void)clickQuanxuan:(BOOL)isQuanxuan {
    BOOL isSelectAll = isQuanxuan;
    for (WGApplyJobCollectionItem *item in self.dataArray) {
        if (item.enabled) {
            item.selected = isSelectAll;
        }
    }
    [self checkSelectDaysAndStateButton];
}
- (void)updateContentViewSize {
    
    [self.collectionView layoutIfNeeded];
    CGFloat height = self.collectionView.contentSize.height;
    self.collectionH = height;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    [super updateConstraints];

    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(self.collectionH);

    }];
    
}
@end
