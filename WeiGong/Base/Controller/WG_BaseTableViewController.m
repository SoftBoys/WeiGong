//
//  WG_BaseTableViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"
#import "WG_BaseTableViewCell.h"
#import <UIScrollView+EmptyDataSet.h>
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "NSAttributedString+Addition.h"
#import "WGRequestManager.h"

@interface WG_BaseTableViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, strong) WG_BaseTableView *tableView;
@end

@implementation WG_BaseTableViewController
#pragma mark - 初始化方法
- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        self.tableView = [WG_BaseTableView wg_tableViewWithStyle:style];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:self.tableView atIndex:0];
    self.tableView.frame = self.view.frame;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if (self.fd_prefersNavigationBarHidden) {
        self.tableView.contentInset = UIEdgeInsetsMake(kTopBarHeight, 0, 0, 0);
        //        self.tableView.top = kTopBarHeight;
    }
    
    self.tableView.backgroundColor = [UIColor wg_red:236 green:236 blue:236];
    self.tableView.backgroundColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
    
    self.sepLineColor = kColor_NavLine;
    self.sepLineColor = [UIColor wg_colorWithHexString:@"#ededed"];
    //    self.sepLineColor = [UIColor orangeColor];
    
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
    [self wg_startEmpty];
//    
//    self.tableView.separatorColor = kColor_Line;
//    self.tableView.separatorColor = kColor(233, 233, 233);
}

- (void)setNeedCellSepLine:(BOOL)needCellSepLine {
    //    _needCellSepLine = needCellSepLine;
    self.tableView.separatorStyle = needCellSepLine ? UITableViewCellSeparatorStyleSingleLine:UITableViewCellSeparatorStyleNone;
}
- (BOOL)needCellSepLine {
    return self.tableView.separatorStyle == UITableViewCellSeparatorStyleSingleLine;
}
- (void)setSepLineColor:(UIColor *)sepLineColor {
    if (!self.needCellSepLine) return;
    _sepLineColor = sepLineColor;
    self.tableView.separatorColor = sepLineColor;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(wg_cellAtIndexPath:)]) {
        return [self wg_cellAtIndexPath:indexPath];
    }
    WG_BaseTableViewCell *cell = [WG_BaseTableViewCell wg_cellWithTableView:tableView];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(wg_numberOfSections)]) {
        return [self wg_numberOfSections];
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(wg_numberOfRowsInSection:)]) {
        return [self wg_numberOfRowsInSection:section];
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(wg_headerAtSection:)]) {
        return [self wg_headerAtSection:section];
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(wg_footerAtSection:)]) {
        [self wg_footerAtSection:section];
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(wg_sectionHeaderHeightAtSection:)]) {
        return [self wg_sectionHeaderHeightAtSection:section];
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(wg_sectionFooterHeightAtSection:)]) {
        return [self wg_sectionFooterHeightAtSection:section];
    }
    return 0.01;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([self respondsToSelector:@selector(wg_rowHeightAtIndexPath:)]) {
//        return [self wg_rowHeightAtIndexPath:indexPath];
//    }
//    return 44;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WG_BaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self respondsToSelector:@selector(wg_didSelectCellAtIndexPath:cell:)]) {
        [self wg_didSelectCellAtIndexPath:indexPath cell:cell];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.needCellSepLine) return;
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    if ([self respondsToSelector:@selector(wg_sepLineEdgeInsetsAtIndexPath:)]) {
        edgeInsets = [self wg_sepLineEdgeInsetsAtIndexPath:indexPath];
    }
    tableView.separatorInset = edgeInsets;
    tableView.layoutMargins = edgeInsets;
    
    cell.separatorInset = edgeInsets;
    cell.layoutMargins = edgeInsets;
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self wg_tableViewDidScroll:self.tableView];
}
#pragma mark - 需在子类中重写
- (NSInteger)wg_numberOfSections {
    return 1;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WG_BaseTableViewCell *cell = [WG_BaseTableViewCell wg_cellWithTableView:self.tableView];
    return cell;
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)wg_sectionFooterHeightAtSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)wg_rowHeightAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(0, 15, 0, 0);
}
- (UIView *)wg_headerAtSection:(NSInteger)section {
    return nil;
}
- (UIView *)wg_footerAtSection:(NSInteger)section {
    return nil;
}
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    
}
- (void)wg_tableViewDidScroll:(WG_BaseTableView *)tableView {
    
}


@end

@implementation WG_BaseTableViewController (EmptyView)

- (void)wg_startEmpty {
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
}
- (CGFloat)emptyOffsetY {
    return kStatusBarHeight;
}
- (NSString *)emptyRemindText {
    return @"暂无数据";
}
- (void)didTapEmptyView {
    
}
- (UIImage *)emptyIcon {
    UIImage *image = [UIImage imageNamed:@"empty_icon"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    [button setImage:image forState:UIControlStateNormal];
    CGFloat buttonW = image.size.width + 40;
    button.wg_size = CGSizeMake(buttonW, buttonW);
    button.backgroundColor = kWhiteColor;
    
    return [[UIImage wg_imageWithView:button] wg_circleImage];
    CGSize size = image.size;
    CGFloat width = 100;
    if (IS_IPhone6P) {
        width = 120;
    }
    CGFloat height = size.height * width/size.width;
    CGSize newSize = CGSizeMake(width, height);
    return [image wg_resizedImageWithNewSize:newSize];
    return [[UIImage wg_imageWithColor:kRedColor size:CGSizeMake(40, 40)] wg_resizedImage];
}
- (BOOL)emptyCanScroll {
    return YES;
}
#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = [self emptyRemindText];
    UIFont *font = kFont(16);
    NSAttributedString *attTitle = [NSAttributedString wg_attStringWithString:title keyWord:nil highlightFont:nil font:font highlightColor:nil textColor:kColor_Black_Sub lineSpace:2 alignment:NSTextAlignmentCenter searhType:kAttributedSearchTypeSingle];
    return attTitle;
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
    NSString *description = @"描述信息描述信息描述信息描述信息描述信息";
    UIFont *font = kFont(15);
    NSAttributedString *attDescription = [NSAttributedString wg_attStringWithString:description keyWord:nil highlightFont:nil font:font highlightColor:kColor_Black_Sub textColor:kColor_Black lineSpace:2 alignment:NSTextAlignmentCenter searhType:kAttributedSearchTypeSingle];
    return attDescription;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [self emptyIcon];
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
    NSString *title = @"空白标题";
    NSAttributedString *attTitle = [NSAttributedString wg_attStringWithString:title keyWord:nil font:kFont(17) highlightColor:nil textColor:kColor_Black];
    return attTitle;
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
    UIImage *image = [UIImage wg_imageWithColor:kBlueColor size:CGSizeMake(40, 40)];
    return image;
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
    UIImage *backImage = [[UIImage wg_imageWithColor:kGreenColor] wg_resizedImage];
    return backImage;
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor wg_colorWithHexString:@"f2f2f2"];
//    return kBlackColor;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    CGFloat offsetY = [self emptyOffsetY];
    return offsetY;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 20;
}
#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    WGLog(@"offsetY:%@", @(offsetY));
    contentOffset.y = 0 - scrollView.contentInset.top;
    [scrollView setContentOffset:contentOffset animated:NO];
//    if (offsetY > 0) {
//        [scrollView scrollRectToVisible:CGRectMake(0, 0.1, kScreenWidth, kScreenHeight) animated:NO];
//    }
    
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return [self emptyCanScroll];
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
//    return self.isLoading;
    return NO;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    WGLog(@"点击了空白页");
    [self didTapEmptyView];
//    [WGRequestManager cancelAllTask];
//    [self wg_loadData];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    WGLog(@"点击了按钮");
    [self didTapEmptyView];
//    [WGRequestManager cancelAllTask];
//    [self wg_loadData];
}

@end
