/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseRefreshTableViewController.h"

#import "EaseConversationModel.h"
#import "EaseConversationCell.h"

#import "EMSDK.h"

typedef NS_ENUM(int, DXDeleteConvesationType) {
    DXDeleteConvesationOnly,
    DXDeleteConvesationWithMessages,
};

@class EaseConversationListViewController;

@protocol EaseConversationListViewControllerDelegate <NSObject>

/*!
 @method
 @brief 获取点击会话列表的回调
 @discussion 获取点击会话列表的回调后,点击会话列表用户可以根据conversationModel自定义处理逻辑
 @param conversationListViewController 当前会话列表视图
 @param IConversationModel 会话模型
 @result
 */
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel;

@optional

//- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
//                 didDeleteConversation:(id<IConversationModel>)conversation
//                          deletionMode:(DXDeleteConvesationType)deletionType;
//
//- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
//           didFailDeletingConversation:(id<IConversationModel>)conversation
//                          deletionMode:(DXDeleteConvesationType)deletionType;


@end

@protocol EaseConversationListViewControllerDataSource <NSObject>

- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                        modelForConversation:(EMConversation *)conversation;

@optional

/*!
 @method
 @brief 获取最后一条消息显示的内容
 @discussion 用户根据conversationModel实现,实现自定义会话中最后一条消息文案的显示内容
 @param conversationListViewController 当前会话列表视图
 @param IConversationModel 会话模型
 @result 返回用户最后一条消息显示的内容
 */
- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
      latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel;

/*!
 @method
 @brief 获取最后一条消息显示的时间
 @discussion 用户可以根据conversationModel,自定义实现会话列表中时间文案的显示内容
 @param conversationListViewController 当前会话列表视图
 @param IConversationModel 会话模型
 @result 返回用户最后一条消息时间的显示文案
 */
- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel;

@end


@interface EaseConversationListViewController : EaseRefreshTableViewController <EMChatManagerDelegate,EMGroupManagerDelegate>

@property (weak, nonatomic) id<EaseConversationListViewControllerDelegate> delegate;
@property (weak, nonatomic) id<EaseConversationListViewControllerDataSource> dataSource;

/*!
 @method
 @brief 下拉加载更多
 @discussion
 @result
 */
- (void)tableViewDidTriggerHeaderRefresh;

/*!
 @method
 @brief 内存中刷新页面
 @discussion
 @result
 */
- (void)refreshAndSortView;

@end
