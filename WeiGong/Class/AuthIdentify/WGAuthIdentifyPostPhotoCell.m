//
//  WGAuthIdentifyPostPhotoCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGAuthIdentifyPostPhotoCell.h"
#import "WGAuthIdentify.h"
#import "WGAuthIdentifyPostPhotoView.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "WG_BaseViewController.h"
#import "WG_BaseNavViewController.h"
#import "WGRequestManager.h"
#import "WGAuthSubmitPhotoParam.h"

#import "UIViewController+ImagePicker.h"

@interface WGAuthIdentifyPostPhotoCell () <WGAuthIdentifyPostPhotoViewDelegate, MWPhotoBrowserDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *photoViewList;
@property (nonatomic, copy) NSArray *photoItems;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, strong) WGAuthIdentifyPostPhotoItem *currentPhotoItem;
@end
@implementation WGAuthIdentifyPostPhotoCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.photoViewList = @[].mutableCopy;
    NSInteger count = 3;
    for (NSInteger i = 0; i < count; i++) {
        WGAuthIdentifyPostPhotoView *postView = [WGAuthIdentifyPostPhotoView new];
        postView.delegate = self;
        [self.contentView addSubview:postView];
        [self.photoViewList addObject:postView];
    }
}


- (void)setIdentify:(WGAuthIdentify *)identify {
    _identify = identify;
    if (_identify) {
        NSMutableArray *photoItems = @[].mutableCopy;
        
        NSArray *titles = @[@"上传正面照",@"上传背面照",@"上传手持照"];
        if (_identify.agileFlag == 0) { // 显示三张
            for (NSInteger i = 0; i < titles.count; i++) {
                NSString *imageUrl = _identify.identityCardUrl;
                NSString *placeholder = @"identityCard_front";
                if (i == 1) {
                    imageUrl = _identify.identityCardUrl2;
                    placeholder = @"identityCard_back";
                } else if (i == 2) {
                    imageUrl = _identify.identityCardUrl3;
                    placeholder = @"person_card";
                }
                
                WGAuthIdentifyPostPhotoItem *item = [WGAuthIdentifyPostPhotoItem new];
                item.index = i;
                item.title = titles[i];
                item.imageUrl = imageUrl;
                item.placeholderImage = [UIImage imageNamed:placeholder];
                item.showButton = (_identify.checkFlag==0||_identify.checkFlag==3);
                [photoItems addObject:item];
            }
            
        } else {
            titles = @[@"上传手持照"];
            NSString *imageUrl = _identify.identityCardUrl3;
            NSString *placeholder = @"person_card";
            WGAuthIdentifyPostPhotoItem *item = [WGAuthIdentifyPostPhotoItem new];
            item.index = 2;
            item.title = titles[0];
            item.imageUrl = imageUrl;
            item.placeholderImage = [UIImage imageNamed:placeholder];
            item.showButton = (_identify.checkFlag==0||_identify.checkFlag==3);
            [photoItems addObject:item];
        }
        
        self.photoItems = photoItems;
        
        self.photos = @[].mutableCopy;
        for (NSInteger i = 0; i < self.photoItems.count; i++) {
            WGAuthIdentifyPostPhotoItem *item = self.photoItems[i];
            MWPhoto *photo = nil;
            if (item.imageUrl) {
                photo = [MWPhoto photoWithURL:[NSURL URLWithString:item.imageUrl]];
            } else {
                photo = [MWPhoto photoWithImage:item.placeholderImage];
            }
            
            [self.photos addObject:photo];
        }
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
}
- (void)updateConstraints {
    [super updateConstraints];
    CGFloat spaceX = 8;
    CGFloat photoViewW = (kScreenWidth-spaceX*(self.photoItems.count+1))/self.photoItems.count;
    
    
    __block UIView *lastView = nil;
    [self.photoViewList enumerateObjectsUsingBlock:^(WGAuthIdentifyPostPhotoView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = NO;
        if (idx >= self.photoItems.count) {
            obj.hidden = YES;
            return ;
        }
        
        [obj mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(photoViewW);
//            make.height.mas_equalTo(item.height);
            if (lastView) {
                make.left.mas_equalTo(lastView.mas_right).offset(spaceX);
            } else {
                make.left.mas_equalTo(spaceX);
            }
        }];
        lastView = obj;
        
        WGAuthIdentifyPostPhotoItem *item = self.photoItems[idx];
        
        CGFloat imageH = photoViewW * (142.0/230.0);
        item.imageH = imageH;
        obj.item = item;
    }];
}

#pragma mark - WGAuthIdentifyPostPhotoViewDelegate
- (void)didClickImageWithItem:(WGAuthIdentifyPostPhotoItem *)item {
    NSInteger index = item.index;
    if (index >= self.photos.count) {
        index = 0;
    }
    [self showPhotosWithIndex:index];
}
- (void)didClickUpdateButtonWithItem:(WGAuthIdentifyPostPhotoItem *)item {
    self.currentPhotoItem = item;
    NSString *title = @"请选择方式";
    NSString *message = nil;
    NSString *cancel = @"取消";
    NSArray *others = @[@"相册"];
    // 支持拍照
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        others = @[@"相机", @"相册"];
    }
    [UIAlertController wg_actionSheetWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger index) {
        // 相册
        if (index == others.count && index > 0) {
            [self pickViewWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        // 相机
        else if (index == others.count-1 && index > 0) {
            [self pickViewWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }
    } cancel:cancel others:others];
}
- (void)pickViewWithSourceType:(UIImagePickerControllerSourceType)type {
    
    if (type == UIImagePickerControllerSourceTypePhotoLibrary) {
        if ([UIDevice wg_isAccessPhoto]) {
            UIViewController *topVC = [self wg_topViewController];
            [topVC wg_presentImagePickerWithSourceType:WGImagePickerPhoto completionHandle:^(UIImage *image, NSDictionary *editingInfo) {
                [self updateImage:image];
            }];
        } else {
            [UIDevice wg_showPhotoAlert];
        }
    } else if (type == UIImagePickerControllerSourceTypeCamera) {
        if ([UIDevice wg_isAccessCamera]) {

            UIViewController *topVC = [self wg_topViewController];
            [topVC wg_presentImagePickerWithSourceType:WGImagePickerCamera completionHandle:^(UIImage *image, NSDictionary *editingInfo) {
                [self updateImage:image];
            }];
        } else {
            [UIDevice wg_showCameraAlert];
        }
    }
}

#pragma mark - 展现相册
- (void)showPhotosWithIndex:(NSInteger)index {
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.enableSwipeToDismiss = NO;
    
    // Customise selection images to change colours if required
    //    browser.customImageSelectedIconName = @"ImageSelected.png";
    //    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:index];
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    WG_BaseNavViewController *nav = [[WG_BaseNavViewController alloc] initWithRootViewController:browser];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [(WG_BaseViewController *)[self wg_topViewController] wg_presentVC:nav];
    
}
#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [(WG_BaseViewController *)[self wg_topViewController] wg_dismiss];
}

- (void)updateImage:(UIImage *)image {
    if (image) {
        // 压缩图片
        float height = 600;
        float width = height * image.size.width/image.size.height;
        CGSize size = CGSizeMake(width, height);
        UIImage *sizeImage = [image wg_resizedImageWithNewSize:size];
        
        WGAuthSubmitPhotoParam *param = [WGAuthSubmitPhotoParam new];
        param.picFlag = self.currentPhotoItem.index + 1;
        
        [MBProgressHUD wg_showHub_CanTap];
        NSString *url = @"/linggb-ws/ws/0.1/file/uploadIdentityClient";
        WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
        request.wg_parameters = [param wg_keyValues];
        request.wg_imageArray = @[sizeImage];
        [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
            
            if (response.responseJSON) {
                //                    NSString *content = response.responseJSON[@"content"];
                NSString *url = response.responseJSON[@"url"];
                //                    if (content.length) {
                //                        [MBProgressHUD wg_message:content];
                //                    }
                // 上传成功
                if ([url length]) {
                    self.currentPhotoItem.imageUrl = url;
                    WGAuthIdentifyPostPhotoView *currentPhotoView = nil;
                    for (WGAuthIdentifyPostPhotoView *photoView in self.photoViewList) {
                        if (photoView.item.index == self.currentPhotoItem.index) {
                            currentPhotoView = photoView;
                            break;
                        }
                    }
                    if (currentPhotoView) {
                        [WGDownloadImageManager downloadImageWithUrl:url completeHandle:^(BOOL finished, UIImage *image) {
                            [MBProgressHUD wg_hideHub];
                            if (image) {
                                currentPhotoView.imageView.image = image;
                            }
                        }];
                        
                    }
                    
                }
            } else {
                [MBProgressHUD wg_hideHub];
            }
        }];
        
    }
}

- (void)dealloc {
    NSString *url = @"/linggb-ws/ws/0.1/file/uploadIdentityClient";
    [WGRequestManager cancelTaskWithUrl:url];
    [MBProgressHUD wg_hideHub];
}

@end
