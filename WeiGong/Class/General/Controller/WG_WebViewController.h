//
//  WG_WebViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/13.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseWebViewController.h"

@interface WG_WebViewController : WG_BaseWebViewController
/** 请求的Url */
@property (nonatomic, copy) NSString *webUrl;

@end

@interface WG_WebViewController (JavaScript)
/** OC 与 JS 交互 */
- (void)setJavaScript;
@end
