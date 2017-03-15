//
//  AppDelegate+UMeng.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (UMeng)
/** 配置友盟统计参数 */
- (void)setUMeng;
/** 配置友盟推送参数 */
- (void)setUMessageWithOptions:(NSDictionary *)launchOptions;
@end


@interface WG_UserInfo : NSObject
/** 0:  1:我的申请 2:工作安排 3:首页 4:我的钱包 5:消息 6: 7:我的消费券 8:详情页 9:网页 */
@property (nonatomic, assign) NSInteger info_id;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *title;


@property (nonatomic, copy) NSString *jobId;
@property (nonatomic, copy) NSString *jobName;

@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, copy) NSString *sendUrl;

@end