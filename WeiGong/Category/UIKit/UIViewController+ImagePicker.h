//
//  UIViewController+ImagePicker.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WGImagePickerHandle)(UIImage *image, NSDictionary *editingInfo);
typedef NS_ENUM(NSUInteger, WGImagePickerSourceType) {
    WGImagePickerPhoto = UIImagePickerControllerSourceTypePhotoLibrary,
    WGImagePickerCamera = UIImagePickerControllerSourceTypeCamera,
    WGImagePickerSavedPhotosAlbum = UIImagePickerControllerSourceTypeSavedPhotosAlbum
};

@interface UIViewController (ImagePicker)
- (void)wg_presentImagePickerWithCompletionHandle:(WGImagePickerHandle)handle;
- (void)wg_presentImagePickerWithSourceType:(WGImagePickerSourceType)sourceType completionHandle:(WGImagePickerHandle)handle;
- (void)wg_presentImagePickerWithSourceType:(WGImagePickerSourceType)sourceType allowEditing:(BOOL)allowEditing completionHandle:(WGImagePickerHandle)handle;
@end
