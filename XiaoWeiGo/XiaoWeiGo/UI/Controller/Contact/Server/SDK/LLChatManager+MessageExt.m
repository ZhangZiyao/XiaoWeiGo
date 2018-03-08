//
//  LLChatManager+MessageExt.m
//  LLWeChat
//
//  Created by GYJZH on 9/4/16.
//  Copyright © 2016 GYJZH. All rights reserved.
//

#import "LLChatManager+MessageExt.h"
#import "LLUtils.h"
#import "LLEmotionModelManager.h"

@implementation LLChatManager (MessageExt)

- (NSMutableDictionary *)encodeGifMessageExtForEmotionModel:(LLEmotionModel *)emotionModel {
    NSMutableDictionary *ext = [NSMutableDictionary dictionary];
    ext[@"groupName"] = emotionModel.group.groupName;
    ext[@"codeId"] = emotionModel.codeId;
    ext[MESSAGE_EXT_TYPE_KEY] = MESSAGE_EXT_GIF_KEY;
    
    return ext;
}

- (NSData *)gifDataForGIFMessageModel:(LLMessageModel *)model {
    return [[LLEmotionModelManager sharedManager] gifDataForEmotionGroup:model.ext[@"groupName"] codeId:model.ext[@"codeId"]];
}

@end
