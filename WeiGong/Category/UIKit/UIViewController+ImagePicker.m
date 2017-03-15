//
//  UIViewController+ImagePicker.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "UIViewController+ImagePicker.h"
#import <objc/runtime.h>

@interface UIViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end
char imageKey;
@implementation UIViewController (ImagePicker)
- (void)setHandle:(WGImagePickerHandle)handle {
    objc_setAssociatedObject(self, &imageKey, handle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (WGImagePickerHandle)handle {
    return objc_getAssociatedObject(self, &imageKey);
}

- (void)wg_presentImagePickerWithCompletionHandle:(WGImagePickerHandle)handle {
    [self wg_presentImagePickerWithSourceType:WGImagePickerPhoto completionHandle:handle];
}
- (void)wg_presentImagePickerWithSourceType:(WGImagePickerSourceType)sourceType completionHandle:(WGImagePickerHandle)handle {
    [self wg_presentImagePickerWithSourceType:sourceType allowEditing:NO completionHandle:handle];
}
- (void)wg_presentImagePickerWithSourceType:(WGImagePickerSourceType)sourceType allowEditing:(BOOL)allowEditing completionHandle:(WGImagePickerHandle)handle {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = (UIImagePickerControllerSourceType)sourceType;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = allowEditing;
    [self setHandle:handle];
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:^{
        if ([self handle]) {
            [self handle](image, editingInfo);
        }
    }];
}
@end
