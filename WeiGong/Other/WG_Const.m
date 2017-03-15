//
//  WG_Const.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

//#import "WG_Const.h"

void WGLog(NSString *format, ...) {
#ifdef DEBUG
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}



NSString *const kAppStoreUrl = @"https://itunes.apple.com/us/app/wei-gong/id1005508381?l=zh&ls=1&mt=8"; // 第二种 itms-apps://itunes.apple.com/app/id1005508381

NSString *const kCommentUrl = @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1005508381&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"; // 只需要改一下id就行

NSString *const kNoti_ReceiveNoti = @"kNoti_ReceiveNoti";
NSString *const kReceiveNotiKey = @"kReceiveNotiKey";

NSString *const kNoti_UpdateUnreadMessageCount = @"kNoti_UpdateUnreadMessageCountKey";

NSString *const kConversionExtTitleKey = @"kConversionExtTitleKey";

#ifdef DEBUG
NSString *const kBaseUrl = @"https://m.vvgong.cn"; // :9443
#else
NSString *const kBaseUrl = @"https://m.vvgong.com";
#endif

const NSTimeInterval kWGRequestTimeoutSeconds = 30.0;

NSString *const kNoti_LoginIsOutDate = @"kNoti_LoginIsOutDate";

