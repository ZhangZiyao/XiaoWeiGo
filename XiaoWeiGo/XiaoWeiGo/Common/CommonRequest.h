//
//  CommonRequest.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonRequest : NSObject

/**
 *
 *  机构服务收藏接口
 */
+ (void)collectDataWithParams:(NSDictionary *)params block:(void(^)(BOOL success))block;
/**
 *
 *  机构服务点赞接口
 */
+ (void)setServiceLikeWithParams:(NSDictionary *)params block:(void(^)(BOOL success))block;
/**
 *
 *  评论点赞接口
 */
+ (void)setCommentLikeWithParams:(NSDictionary *)params block:(void(^)(BOOL success))block;

@end
