//
//  WGWorkMessageListItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/18.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 
 status = 1,
	openFlag = 0,
	updateDate = 2016-09-28 13:25:39,
	msgTitle = 身份认证成功,
	openTitle = ,
	msgContent = 身份认证成功,
	userMsgId = 588,
	createDate = 2016-09-20 15:41:36
 */
@interface WGWorkMessageListItem : NSObject
/** 0:未读 1:已读 */
@property (nonatomic, assign) NSInteger status;
/** 0:无点击 1:打开详情 2:打开webview 3:打电话 */
@property (nonatomic, assign) NSInteger openFlag;
/** 更新时间 */
@property (nonatomic, copy) NSString *updateDate;
/** 消息标题 */
@property (nonatomic, copy) NSString *msgTitle;
/** 链接标题 */
@property (nonatomic, copy) NSString *openTitle;
/** 消息内容 */
@property (nonatomic, copy) NSString *msgContent;
/** 对应的jobid 或 url 或 电话号码 */
@property (nonatomic, copy) NSString *openContent;
@property (nonatomic, assign) NSInteger userMsgId;
/** yyyy-MM-dd hh:mm:ss */
@property (nonatomic, copy) NSString *createDate;

@end
