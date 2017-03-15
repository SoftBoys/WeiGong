//
//  WGRewardShare.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/15.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGRewardShare : NSObject
@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, strong) UIImage *icon;
@end

@interface WGReward : NSObject
@property (nonatomic, copy) NSString *invitationUrl;
@property (nonatomic, copy) NSString *inviteContent;
@property (nonatomic, copy) NSString *inviteCode;
@end
