//
//  WGMessageHistoryViewController+More.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMessageHistoryViewController+More.h"
#import "WGMessageHistoryListCell.h"
#import <EMSDK.h>
#import "EaseConversationModel.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "NSDate+Category.h"

@implementation WGMessageHistoryViewController (More)
- (void)loadEaseDataWithCompletionHandle:(void (^)(NSArray<WGMessageHistoryListItem *> *))handle {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 获取所有会话列表
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSArray *sortConversations = [conversations sortedArrayUsingComparator:
                                      ^(EMConversation *obj1, EMConversation* obj2){
                                          EMMessage *message1 = [obj1 latestMessage];
                                          EMMessage *message2 = [obj2 latestMessage];
                                          if(message1.timestamp > message2.timestamp) {
                                              return(NSComparisonResult)NSOrderedAscending;
                                          }else {
                                              return(NSComparisonResult)NSOrderedDescending;
                                          }
                                      }];
        NSArray *models = [self modelsWithArray:sortConversations];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handle) {
                handle(models);
            }
        });
    });
    
}

- (NSArray *)modelsWithArray:(NSArray *)array {
    
    NSMutableArray *muArray = [NSMutableArray array];
    BOOL needUpdateUnreadCount = NO;
    for (EMConversation *conversion in array) {    
        if (conversion.conversationId.length == 0) {
            EMError *error = nil;
            [conversion deleteAllMessages:&error];
            [self removeEmptyConversationsFromDB];
            
            needUpdateUnreadCount = YES;
            continue;
        }
        WGMessageHistoryListItem *item = [[WGMessageHistoryListItem alloc]init];
        
        NSString *title = conversion.ext[kConversionExtTitleKey];
        if (title == nil) {
            // 默认为群组的id
            title = conversion.conversationId;
        }
        
        EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversion];
        if (model.conversation.type == EMConversationTypeChat) {
            
        } else if (model.conversation.type == EMConversationTypeGroupChat) {
            // 获取所有群组
            NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
            for (EMGroup *group in groupArray) {
                // 获取群名称
                NSString *groupId = group.groupId;
                if ([groupId isEqualToString:conversion.conversationId]) {
                    title = group.subject;
                    NSDictionary *ext = @{kConversionExtTitleKey:title};
                    conversion.ext = ext;
                    break;
                }
            }
        }
        
        item.name = title;
        item.detail = [self latestMessageTitleForConversationModel:model];
        item.time = [self lastMessageTimeByConversation:conversion];
        item.unreadCount = [self unreadMessageCountByConversation:conversion];
        item.groupID = conversion.conversationId;

        item.isGroup = conversion.type == EMConversationTypeGroupChat ? YES:NO;
        [muArray wg_addObject:item];
    }
    if (needUpdateUnreadCount) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNoti_UpdateUnreadMessageCount object:nil];
    }
    return muArray;
}


// 得到最后消息文字或者类型
- (NSString *)latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
//                if ([lastMessage.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
//                    latestMessageTitle = @"[动画表情]";
//                }
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    
    return latestMessageTitle;
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation {
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation {
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    return  ret;
}
// 从数据库中移除空的会话对象
- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.type == EMConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EMClient sharedClient].chatManager deleteConversations:needRemoveConversations isDeleteMessages:YES completion:nil];
    }
}

@end
