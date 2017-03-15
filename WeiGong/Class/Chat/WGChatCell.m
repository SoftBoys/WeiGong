//
//  WGChatCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/28.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChatCell.h"

@implementation WGChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(id<IMessageModel>)model {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier model:model];
    if (self) {
        
        self.avatarSize = 30;
        
        self.avatarCornerRadius = self.avatarSize/2.0;
        
        UIImage *sendImage = [[UIImage imageNamed:@"chat_send_nor"] stretchableImageWithLeftCapWidth:34 topCapHeight:28];
        sendImage = [[UIImage imageNamed:@"chat_send_nor"] wg_resizedImage];
        self.sendBubbleBackgroundImage = sendImage;
        
        UIImage *receiveImage = [[UIImage imageNamed:@"chat_recive_nor"] stretchableImageWithLeftCapWidth:34 topCapHeight:28];
        receiveImage = [[UIImage imageNamed:@"chat_recive_nor"] wg_resizedImage];
        self.recvBubbleBackgroundImage = receiveImage;
        
        float top = 10, left = 15, right = 15, bottom = 10;
        
        self.rightBubbleMargin = UIEdgeInsetsMake(top, left, bottom, right);
        self.leftBubbleMargin = UIEdgeInsetsMake(top, right, bottom, left);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //        self.bubbleView.backgroundImageView.backgroundColor = [UIColor redColor];
        ////
        //        self.bubbleView.textLabel.backgroundColor = [UIColor orangeColor];
        //
        //        NSLog(@"margin:%@", NSStringFromUIEdgeInsets(self.bubbleView.margin));
        
        self.bubbleView.textLabel.textAlignment = NSTextAlignmentLeft;
        self.bubbleView.textLabel.numberOfLines = 0;
        
        // 隐藏已读控件
        self.hasRead.hidden = YES;
    }
    return self;
}

- (void)setModel:(id<IMessageModel>)model {
    NSDictionary *ext = model.message.ext;
    model.nickname = ext[kChatNickName];
    model.avatarURLPath = ext[kIconUrl];
    
    [super setModel:model];
    
    //    NSLog(@"isSender:%d  %@", self.model.isSender, self.model.text);
    //    NSLog(@"isSender:%d  %@", self.model.isSender, self.model.message.ext);
    if (self.model.isSender) {
        self.messageTextColor = [UIColor whiteColor];
    } else {
        self.messageTextColor = [UIColor blackColor];
    }
    
}

@end
