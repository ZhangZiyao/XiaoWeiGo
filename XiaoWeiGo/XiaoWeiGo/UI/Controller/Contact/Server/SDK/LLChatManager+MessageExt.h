//
//  LLChatManager+MessageExt.h
//  LLWeChat
//
//  Created by GYJZH on 9/4/16.
//  Copyright © 2016 GYJZH. All rights reserved.
//

#import "LLChatManager.h"

@interface LLChatManager (MessageExt)

- (NSMutableDictionary *)encodeGifMessageExtForEmotionModel:(LLEmotionModel *)emotionModel;

- (NSData *)gifDataForGIFMessageModel:(LLMessageModel *)model;

@end
