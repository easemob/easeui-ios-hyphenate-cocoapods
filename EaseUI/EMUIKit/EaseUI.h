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

#ifndef EASEUI_h
#define EASEUI_h

#if TARGET_OS_IPHONE

#import "EaseConversationListViewController.h"
#import "EaseMessageViewController.h"
#import "EaseUsersListViewController.h"
#import "EaseViewController.h"

#import "IModelCell.h"
#import "IModelChatCell.h"
#import "EaseMessageCell.h"
#import "EaseBaseMessageCell.h"
#import "EaseBubbleView.h"
#import "EaseUserCell.h"

#import "EaseChineseToPinyin.h"
#import "EaseEmoji.h"
#import "EaseEmotionEscape.h"
#import "EaseEmotionManager.h"
#import "EaseSDKHelper.h"
#import "EMCDDeviceManager.h"
#import "EaseConvertToCommonEmoticonsHelper.h"

#import "NSDate+Category.h"
#import "NSString+Valid.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+HUD.h"
#import "UIViewController+DismissKeyboard.h"
#import "EaseLocalDefine.h"

#else

#if ENABLE_LITE == 1
#import <EaseUILite/EaseConversationListViewController.h>
#import <EaseUILite/EaseMessageViewController.h>
#import <EaseUILite/EaseUsersListViewController.h>
#import <EaseUILite/EaseViewController.h>

#import <EaseUILite/IModelCell.h>
#import <EaseUILite/IModelChatCell.h>
#import <EaseUILite/EaseMessageCell.h>
#import <EaseUILite/EaseBaseMessageCell.h>
#import <EaseUILite/EaseBubbleView.h>
#import <EaseUILite/EaseUserCell.h>

#import <EaseUILite/EaseChineseToPinyin.h>
#import <EaseUILite/EaseEmoji.h>
#import <EaseUILite/EaseEmotionEscape.h>
#import <EaseUILite/EaseEmotionManager.h>
#import <EaseUILite/EaseSDKHelper.h>
#import <EaseUILite/EMCDDeviceManager.h>
#import <EaseUILite/EaseConvertToCommonEmoticonsHelper.h>

#import <EaseUILite/NSDate+Category.h>
#import <EaseUILite/NSString+Valid.h>
#import <EaseUILite/UIViewController+HUD.h>
#import <EaseUILite/UIViewController+DismissKeyboard.h>
#import <EaseUILite/EaseLocalDefine.h>
#else
#import <EaseUI/EaseConversationListViewController.h>
#import <EaseUI/EaseMessageViewController.h>
#import <EaseUI/EaseUsersListViewController.h>
#import <EaseUI/EaseViewController.h>

#import <EaseUI/IModelCell.h>
#import <EaseUI/IModelChatCell.h>
#import <EaseUI/EaseMessageCell.h>
#import <EaseUI/EaseBaseMessageCell.h>
#import <EaseUI/EaseBubbleView.h>
#import <EaseUI/EaseUserCell.h>

#import <EaseUI/EaseChineseToPinyin.h>
#import <EaseUI/EaseEmoji.h>
#import <EaseUI/EaseEmotionEscape.h>
#import <EaseUI/EaseEmotionManager.h>
#import <EaseUI/EaseSDKHelper.h>
#import <EaseUI/EMCDDeviceManager.h>
#import <EaseUI/EaseConvertToCommonEmoticonsHelper.h>

#import <EaseUI/NSDate+Category.h>
#import <EaseUI/NSString+Valid.h>
#import <EaseUI/UIViewController+HUD.h>
#import <EaseUI/UIViewController+DismissKeyboard.h>
#import <EaseUI/EaseLocalDefine.h>
#endif

#import <SDWebImage/UIImageView+WebCache.h>

#endif


#endif
