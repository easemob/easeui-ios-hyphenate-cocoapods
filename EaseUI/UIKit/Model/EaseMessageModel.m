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

#import "EaseMessageModel.h"

#import "EaseEmotionEscape.h"
#import "EaseConvertToCommonEmoticonsHelper.h"

@implementation EaseMessageModel

- (instancetype)initWithMessage:(EMMessage *)message
{
    self = [super init];
    if (self) {
        _cellHeight = -1;
        _message = message;
        _firstMessageBody = message.body;
        _isMediaPlaying = NO;
        
        _nickname = message.from;
        _isSender = message.direction == EMMessageDirectionSend ? YES : NO;
        
        switch (_firstMessageBody.type) {
            case EMMessageBodyTypeText:
            {
                EMTextMessageBody *textBody = (EMTextMessageBody *)_firstMessageBody;
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper convertToSystemEmoticons:textBody.text];
                self.text = didReceiveText;
            }
                break;
            case EMMessageBodyTypeImage:
            {
                EMImageMessageBody *imgMessageBody = (EMImageMessageBody *)_firstMessageBody;
                NSData *imageData = [NSData dataWithContentsOfFile:imgMessageBody.localPath];
                if (imageData.length) {
                    self.image = [UIImage imageWithData:imageData];
                }
                
                if ([imgMessageBody.thumbnailLocalPath length] > 0) {
                    self.thumbnailImage = [UIImage imageWithContentsOfFile:imgMessageBody.thumbnailLocalPath];
                }
                else{
                    self.thumbnailImage = [self scaleImage:self.image toScale:0.1];
                }
                
                self.thumbnailImageSize = self.thumbnailImage.size;
                self.imageSize = imgMessageBody.size;
                self.fileLocalPath = imgMessageBody.localPath;
                if (!_isSender) {
                    self.fileURLPath = imgMessageBody.remotePath;
                }
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                EMLocationMessageBody *locationBody = (EMLocationMessageBody *)_firstMessageBody;
                self.address = locationBody.address;
                self.latitude = locationBody.latitude;
                self.longitude = locationBody.longitude;
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                EMVoiceMessageBody *voiceBody = (EMVoiceMessageBody *)_firstMessageBody;
                self.mediaDuration = voiceBody.duration;
                self.isMediaPlayed = NO;
                if (message.ext) {
                    self.isMediaPlayed = [[message.ext objectForKey:@"isPlayed"] boolValue];
                }
                
                // 音频路径
                self.fileLocalPath = voiceBody.localPath;
                self.fileURLPath = voiceBody.remotePath;
            }
                break;
            case EMMessageBodyTypeVideo:
            {
                EMVideoMessageBody *videoBody = (EMVideoMessageBody *)message.body;
                self.thumbnailImageSize = videoBody.thumbnailSize;
                if ([videoBody.thumbnailLocalPath length] > 0) {
                    NSData *thumbnailImageData = [NSData dataWithContentsOfFile:videoBody.thumbnailLocalPath];
                    if (thumbnailImageData.length) {
                        self.thumbnailImage = [UIImage imageWithData:thumbnailImageData];
                    }
                    self.image = self.thumbnailImage;
                }
                
                // 视频路径
                self.fileLocalPath = videoBody.localPath;
                self.fileURLPath = videoBody.remotePath;
            }
                break;
            case EMMessageBodyTypeFile:
            {
                EMFileMessageBody *fileMessageBody = (EMFileMessageBody *)_firstMessageBody;
                self.fileIconName = @"chat_item_file";
                self.fileName = fileMessageBody.displayName;
                self.fileSize = fileMessageBody.fileLength;
                
                if (self.fileSize < 1024) {
                    self.fileSizeDes = [NSString stringWithFormat:@"%fB", self.fileSize];
                }
                else if(self.fileSize < 1024 * 1024){
                    self.fileSizeDes = [NSString stringWithFormat:@"%.2fkB", self.fileSize / 1024];
                }
                else if (self.fileSize < 2014 * 1024 * 1024){
                    self.fileSizeDes = [NSString stringWithFormat:@"%.2fMB", self.fileSize / (1024 * 1024)];
                }
            }
                break;
            default:
                break;
        }
    }
    
    return self;
}

- (NSString *)messageId
{
    return _message.messageId;
}

- (EMMessageStatus)messageStatus
{
    return _message.status;
}

- (EMChatType)messageType
{
    return _message.chatType;
}

- (EMMessageBodyType)bodyType
{
    return self.firstMessageBody.type;
}

- (BOOL)isMessageRead
{
    return _message.isReadAcked;
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
