//
//  GuideViewController.m
//  GJW_BaseViewController
//
//  Created by dfhb@rdd on 16/3/31.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideCell.h"

static NSString *identify = @"GuideCellId";
@interface GuideViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,GuideCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, copy) NSArray <UIImage *> *images;
@property (nonatomic, assign) BOOL isHiddenNextButton;  // 隐藏下一步按钮
@property (nonatomic, copy) void (^complete)();
@property (nonatomic, strong) UIButton *button;
//@property (nonatomic, assign) UIButton *button;
@end
@implementation GuideViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

+ (instancetype)guideViewWithImages:(NSArray<UIImage *> *)images complete:(void (^)())complete {
    GuideViewController *guideVC = [[GuideViewController alloc] init];
    guideVC.images = images;
    guideVC.complete = complete;
    return guideVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHiddenNextButton = YES;
    
    [self buildCollectionView];

    [self buildPageControl];
    
    self.type = AnimationType2;
    
}
                           
- (void)buildCollectionView {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[GuideCell class] forCellWithReuseIdentifier:identify];
}

- (void)buildPageControl {
    
//    CGRect framePage = CGRectMake(0, CGRectGetHeight(bounds) - 50, CGRectGetWidth(bounds), 20);
    self.pageControl = [[UIPageControl alloc] init];
//    self.pageControl.frame = framePage;
    self.pageControl.numberOfPages = self.images.count;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = kColor_Gray_Back;
    self.pageControl.currentPageIndicatorTintColor = kColor_Orange;
    [self.view addSubview:self.pageControl];
    
    float pageH = 20;
    float bottom = 50;
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(pageH);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-bottom);
    }];
    
}
#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.image = self.images[indexPath.row];
    cell.delegate = self;
    if (indexPath.row != self.images.count - 1) {
        cell.isHiddenNextButton = YES;
    } else {
        if (self.type == AnimationType1) {
            cell.isHiddenNextButton = self.isHiddenNextButton;
        } else if (self.type == AnimationType2) {
            cell.isHiddenNextButton = NO;
        }
        self.button = [cell valueForKey:@"nextButton"];
    }
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}
#pragma mark - UISrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offX = 0.5; // 偏移量
    NSInteger index = scrollView.contentOffset.x /(kScreenWidth) + offX;
    self.pageControl.currentPage = index;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x + kScreenWidth >= scrollView.contentSize.width) {
        NSLog(@"yes");
        if (self.type == AnimationType1) {
            if (self.isHiddenNextButton) {
                self.button.hidden = NO;
                self.button.alpha = 0.0;

                [UIView animateWithDuration:0.8 animations:^{
                    self.button.alpha = 1.0;

                } completion:^(BOOL finished) {

                }];
            }
        } else if (self.type == AnimationType2) {
            if (self.isHiddenNextButton) {
                self.button.hidden = NO;
                self.button.alpha = 1.0;
                
                NSTimeInterval duration = 0.5f;
                [UIView animateWithDuration:duration animations:^{
                    self.button.transform = CGAffineTransformMakeScale(1.2, 1.2);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:duration animations:^{
                        self.button.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    }];
                }];
            }
        }
    }
}

#pragma mark - 点击下一步按钮
- (void)nextFinished {
    if (self.complete) {
        self.complete();
    }
}
@end
