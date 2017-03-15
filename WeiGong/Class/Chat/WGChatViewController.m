//
//  WGChatViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChatViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "WGChatSetViewController.h"

#import "WGChatCell.h"

#import "EaseEmotionManager.h"
#import "EaseEmoji.h"
#import <EMSDK.h>
#import "WG_MineUserTool.h"
#import "WG_MineUser.h"
#import "WG_UserDefaults.h"


@interface WGChatViewController () <EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource, EMClientDelegate>
@property (nonatomic, strong) NSMutableDictionary *emotionDic;
@property (nonatomic, assign) BOOL isGroup;
@property (nonatomic, copy) NSString *chatter;
@end

@implementation WGChatViewController
+ (instancetype)wg_chatWithChatter:(NSString *)chatter {
    return [self wg_chatWithChatter:chatter isGroup:YES];
}
+ (instancetype)wg_chatWithChatter:(NSString *)chatter isGroup:(BOOL)isGroup {
    EMConversationType type = isGroup ? EMConversationTypeGroupChat : EMConversationTypeChat;
    return [[WGChatViewController alloc] initWithConversationChatter:chatter conversationType:type];
}
- (instancetype)initWithConversationChatter:(NSString *)conversationChatter conversationType:(EMConversationType)conversationType {
    if (self = [super initWithConversationChatter:conversationChatter conversationType:conversationType]) {
        self.isGroup = conversationType == EMConversationTypeGroupChat;
        self.chatter = conversationChatter;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    self.tableView.backgroundColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
    
    [self setupItems];
    [self setupchatBarMoreView];
    if (self.title) {
        NSDictionary *ext = @{kConversionExtTitleKey:self.title};
        self.conversation.ext = ext;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAllMessages) name:RemoveAllMessages object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitGroup) name:ExitGroup object:nil];
    
}
- (void)deleteAllMessages {
    NSString *groupId = self.chatter;
    BOOL isDelete = [groupId isEqualToString:self.conversation.conversationId];
    if (isDelete) {
        
        self.messageTimeIntervalTag = -1;
        [self.conversation deleteAllMessages:nil];
        [self.dataArray removeAllObjects];
        [self.messsagesSource removeAllObjects];
        
        [self.tableView reloadData];
        
    }
}
- (void)exitGroup {
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addMessageToDataSource:(EMMessage *)message progress:(id)progress {
    
    if (message.direction == EMMessageDirectionSend) {
        WG_UserDefaults *user = [WG_UserDefaults shareInstance];
        if (user) {
            NSString *nickname = user.userName ?: kStringAppend(@"匿名",[WG_UserDefaults shareInstance].userId);
            NSString *iconUrl = user.iconUrl ?: kEmptyStr;
            NSDictionary *ext = @{kChatNickName:nickname, kIconUrl:iconUrl};
            message.ext = ext;
        }
    }
    [super addMessageToDataSource:message progress:progress];
}
#pragma mark - EaseMessageViewControllerDelegate
- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)messageModel {
    NSString *identifier = [EaseMessageCell cellIdentifierWithModel:messageModel];
    WGChatCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[WGChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier model:messageModel];
    }
    cell.model = messageModel;
    return cell;
}
- (BOOL)messageViewController:(EaseMessageViewController *)viewController canLongPressRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (BOOL)messageViewController:(EaseMessageViewController *)viewController didLongPressRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.dataArray[indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
    }
    return YES;
}
// 点击了头像
- (void)messageViewController:(EaseMessageViewController *)viewController didSelectAvatarMessageModel:(id<IMessageModel>)messageModel {
    
}

#pragma mark - EaseMessageViewControllerDataSource
// 自定义表情
- (NSArray *)emotionFormessageViewController:(EaseMessageViewController *)viewController {
    NSMutableArray *emotions = [NSMutableArray array];
    for (NSString *name in [EaseEmoji allEmoji]) {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
    }
    EaseEmotion *temp = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    NSMutableArray *emotionGifs = [NSMutableArray array];
    _emotionDic = [NSMutableDictionary dictionary];
    NSArray *names = @[@"icon_002",@"icon_007",@"icon_010",@"icon_012",@"icon_013",@"icon_018",@"icon_019",@"icon_020",@"icon_021",@"icon_022",@"icon_024",@"icon_027",@"icon_029",@"icon_030",@"icon_035",@"icon_040"];
    int index = 0;
    for (NSString *name in names) {
        index++;
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:[NSString stringWithFormat:@"[示例%d]",index] emotionId:[NSString stringWithFormat:@"em%d",(1000 + index)] emotionThumbnail:[NSString stringWithFormat:@"%@_cover",name] emotionOriginal:[NSString stringWithFormat:@"%@",name] emotionOriginalURL:@"" emotionType:EMEmotionGif];
        [emotionGifs addObject:emotion];
        [_emotionDic setObject:emotion forKey:[NSString stringWithFormat:@"em%d",(1000 + index)]];
    }
    EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionGif emotionRow:2 emotionCol:4 emotions:emotionGifs tagImage:[UIImage imageNamed:@"icon_002_cover"]];
    
    return @[managerDefault,managerGif];
}
- (BOOL)isEmotionMessageFormessageViewController:(EaseMessageViewController *)viewController messageModel:(id<IMessageModel>)messageModel {
    BOOL flag = NO;
    if ([messageModel.message.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
        return YES;
    }
    return flag;
}
- (EaseEmotion*)emotionURLFormessageViewController:(EaseMessageViewController *)viewController messageModel:(id<IMessageModel>)messageModel {
    NSString *emotionId = [messageModel.message.ext objectForKey:MESSAGE_ATTR_EXPRESSION_ID];
    EaseEmotion *emotion = [_emotionDic objectForKey:emotionId];
    if (emotion == nil) {
        emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:emotionId emotionThumbnail:@"" emotionOriginal:@"" emotionOriginalURL:@"" emotionType:EMEmotionGif];
    }
    return emotion;
}
- (NSDictionary*)emotionExtFormessageViewController:(EaseMessageViewController *)viewController easeEmotion:(EaseEmotion*)easeEmotion {
    return @{MESSAGE_ATTR_EXPRESSION_ID:easeEmotion.emotionId,MESSAGE_ATTR_IS_BIG_EXPRESSION:@(YES)};
}
#pragma mark - EMClientDelegate
- (void)userAccountDidLoginFromOtherDevice {
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}
- (void)userAccountDidRemoveFromServer {
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}
- (void)userDidForbidByServer {
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

#pragma mark - private
- (void)setupItems {
    __weak typeof(self) weakself = self;
    UIImage *backImage = [UIImage imageNamed:@"btn_back_normal"];
    UIBarButtonItem *backItem = [UIBarButtonItem wg_itemWithImage:backImage highlightImage:nil touchBlock:^(id obj) {
        __strong typeof(weakself) strongself = weakself;
        [strongself wg_backAction];
    }];
    CGFloat left = 8;
    [(UIButton *)backItem.customView setImageEdgeInsets:UIEdgeInsetsMake(0, -left, 0, left)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIImage *setImage = [UIImage imageNamed:@"message_set"];
    UIBarButtonItem *setItem = [UIBarButtonItem wg_itemWithImage:setImage highlightImage:nil touchBlock:^(id obj) {
        __strong typeof(weakself) strongself = weakself;
        WGChatSetViewController *setVC = [WGChatSetViewController new];
        setVC.title = @"咨询组设置";
        setVC.chatter = strongself.chatter;
        setVC.isGroup = strongself.isGroup;
        [strongself.navigationController pushViewController:setVC animated:YES];
    }];
    CGFloat setR = 8;
    [(UIButton *)setItem.customView setImageEdgeInsets:UIEdgeInsetsMake(0, setR, 0, -setR)];
    self.navigationItem.rightBarButtonItem = setItem;
}
- (void)wg_backAction {
    
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].roomManager removeDelegate:self];
    
    if (self.deleteConversationIfNull) {
        //判断当前会话是否为空，若符合则删除该会话
        EMMessage *message = [self.conversation latestMessage];
        if (message == nil) {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId isDeleteMessages:NO completion:nil];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)setupchatBarMoreView {
    EaseChatBarMoreView *moreView = self.chatBarMoreView;
    if (moreView) {
        [moreView removeItematIndex:4];
        [moreView removeItematIndex:3];
        [moreView removeItematIndex:1];
        
        [moreView updateItemWithImage:[UIImage imageNamed:@"message_picture"] highlightedImage:nil title:nil atIndex:0];
        [moreView updateItemWithImage:[UIImage imageNamed:@"message_takePicture"] highlightedImage:nil title:nil atIndex:1];
    }
}

- (void)dealloc {
    WGLog(@"dealloc--%@", [self class]);
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].roomManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
