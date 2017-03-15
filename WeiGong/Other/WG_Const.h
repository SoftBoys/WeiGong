//
//  WG_Const.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//
#import "WGCategory.h"
#import "MBProgressHUD+WG_Extension.h"
#import "WGDownloadImageManager.h"

void WGLog(NSString *format, ...);

// app版本号
#define kAppVersion     [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]

// 设备
#define IS_IPhone4      (kScreenWidth == 320 && kScreenHeight == 640)
#define IS_IPhone5      (kScreenWidth == 320 && kScreenHeight == 568)
#define IS_IPhone6      (kScreenWidth == 375 && kScreenHeight == 667)
#define IS_IPhone6P     (kScreenWidth == 414 && kScreenHeight == 736)

#define  IS_IOS(a) ([[[UIDevice currentDevice] systemVersion] floatValue] >= a)

#pragma mark - 颜色
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]
#define kColor_Navbar  [UIColor wg_colorWithHexString:@"#f5f5f5"]
#define kColor_NavLine [UIColor wg_colorWithHexString:@"#d2d2d2"]
#define kColor_Title  [UIColor wg_red:72 green:72 blue:72]
// 颜色
#define kColor(r,g,b)        [UIColor wg_red:r green:g blue:b]
#define kColorWithA(r,g,b,a) [UIColor wg_red:r green:g blue:b alpha:a]
#define kColor_Orange       [UIColor wg_colorWithHexString:@"#ff7e1d"]
#define kColor_Black        [UIColor wg_colorWithHexString:@"#363636"]
#define kColor_Black_Sub    [UIColor wg_colorWithHexString:@"#808080"]
#define kColor_Gray_Sub     [UIColor wg_colorWithHexString:@"#aaaaaa"]
#define kColor_PlaceHolder  [UIColor wg_colorWithHexString:@"#c7c7c7"]
#define kColor_Line         [UIColor wg_colorWithHexString:@"#d2d2d2"]
#define kColor_Gray_Back    [UIColor wg_colorWithHexString:@"#f0f0f0"]
#define kColor_Gray_Nav     [UIColor wg_colorWithHexString:@"#f5f5f5"]
#define kColor_White        [UIColor wg_colorWithHexString:@"#ffffff"]
#define kColor_Blue         [UIColor wg_colorWithHexString:@"#259cdd"]
#define kColor_OrangeRed    [UIColor wg_colorWithHexString:@"#ff5000"]

#pragma mark - 系统UI
#define kNavigationBarHeight 44
#define kStatusBarHeight 20
#define kTopBarHeight 64
#define kToolBarHeight 44
#define kTabBarHeight 49
#define kLineHeight (1 / [UIScreen mainScreen].scale)
#define kiPhone4_W 320
#define kiPhone4_H 480
#define kiPhone5_W 320
#define kiPhone5_H 568
#define kiPhone6_W 375
#define kiPhone6_H 667
#define kiPhone6P_W 414
#define kiPhone6P_H 736
/** 屏幕宽度 */
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
/** 屏幕高度 */
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


#pragma mark - 字体

/** PingFangSC-Regular   PingFangSC-Light 细体  PingFangSC-Medium 粗体 */
//#define FontName @"PingFangSC-Regular"

#define FontName (IS_IOS(9) ? @"PingFangSC-Light" : @"HelveticaNeue-Light")
#define BoldFontName (IS_IOS(9) ? @"PingFangSC-Medium" : @"HelveticaNeue-Bold")

/** 平方字体 */
#define kBoldFont_PingFang(fontSize) [UIFont fontWithName:BoldFontName size:(fontSize)]
#define kFont_PingFang(fontSize) [UIFont fontWithName:FontName size:(fontSize)]

/** 普通字体 */
//#define kFont(fontSize) [UIFont systemFontOfSize:(fontSize)]
#define kFont(fontSize) kFont_PingFang(fontSize)
/** 粗体 */
//#define kBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#define kBoldFont(fontSize) kBoldFont_PingFang(fontSize)



#define kFont_Nav           kFont(18)
#define kFont_24            [UIFont fontWithName:@"PingFangSC-Light" size:24]
#define kFont_17            kFont(17)
#define kFont_16            kFont(16)
#define kFont_15            kFont(15)
#define kFont_13            kFont(13)
#define kFont_12            kFont(12)
#define kFont_10            kFont(10)

#pragma mark - 字符串转化
/** 空字符串 */
#define kEmptyStr @""
/** Int型转字符串 */
#define kIntToStr(i) [NSString stringWithFormat:@"%@", @(i)]
#define kStringAppend(stringA,stringB) [NSString stringWithFormat:@"%@%@", stringA, stringB]


extern NSString *const kAppStoreUrl; //
extern NSString *const kCommentUrl; // 评论页面
// 接受推送消息通知
extern NSString *const kNoti_ReceiveNoti;
extern NSString *const kReceiveNotiKey;

// 更新未读消息通知
extern NSString *const kNoti_UpdateUnreadMessageCount;

extern NSString *const kNoti_BossOrderStateChanged;

extern NSString *const kConversionExtTitleKey; // 会话列表 ext 标题key

// 
extern NSString *const kBaseUrl;

// 请求超时时间
extern const NSTimeInterval kWGRequestTimeoutSeconds;
// 登陆过期
extern NSString *const kNoti_LoginIsOutDate;

