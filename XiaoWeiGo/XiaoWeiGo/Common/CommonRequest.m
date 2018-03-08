//
//  CommonRequest.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "CommonRequest.h"

@implementation CommonRequest

+ (void)collectDataWithParams:(NSDictionary *)params block:(void(^)(BOOL success))block{
    RequestManager *request = [[RequestManager alloc] init];
    [request POSTRequestUrlStr:kAddServiceCollect parms:params success:^(id responseData) {
        NSString *message = responseData[0];
        if ([message containsString:@"success"]) {
            [MBProgressHUD alertInfo:@"已添加至我的收藏"];
            block(YES);
        }else if ([message containsString:@"repeat"]) {
            [MBProgressHUD alertInfo:@"已存在"];
            block(YES);
        }else{
            [MBProgressHUD alertInfo:@"失败"];
            block(NO);
        }
    } fail:^(NSError *error) {
        block(NO);
    }];
}
+ (void)setServiceLikeWithParams:(NSDictionary *)params block:(void(^)(BOOL success))block{
    RequestManager *request = [[RequestManager alloc] init];
    [request POSTRequestUrlStr:kSetServiceLink parms:params success:^(id responseData) {
        NSString *message = responseData[0];
        if ([message containsString:@"success"]) {
            [MBProgressHUD alertInfo:@"点赞成功"];
            block(YES);
        }else if ([message containsString:@"repeat"]) {
            [MBProgressHUD alertInfo:@"已经点过了哦～"];
            block(NO);
        }else{
            [MBProgressHUD alertInfo:@"点赞失败"];
            block(NO);
        }
    } fail:^(NSError *error) {
        block(NO);
    }];
}
+ (void)setCommentLikeWithParams:(NSDictionary *)params block:(void(^)(BOOL success))block{
    RequestManager *request = [[RequestManager alloc] init];
    [request POSTRequestUrlStr:kLinkEvaluate parms:params success:^(id responseData) {
        NSString *message = responseData[0];
        if ([message containsString:@"success"]) {
            [MBProgressHUD alertInfo:@"点赞成功"];
            block(YES);
        }else if ([message containsString:@"repeat"]) {
            [MBProgressHUD alertInfo:@"已经点过了哦～"];
            block(NO);
        }else{
            [MBProgressHUD alertInfo:@"点赞失败"];
            block(NO);
        }
    } fail:^(NSError *error) {
        block(NO);
    }];
}
//- (void)getFileWithParams:(NSDictionary *)params block:(void(^)(BOOL success))block{
//    RequestManager *request = [[RequestManager alloc] init];
//    [request POSTRequestUrlStr:kAddServiceCollect parms:params success:^(id responseData) {
//        NSString *message = responseData[0];
//        if ([message containsString:@"success"]) {
//            [MBProgressHUD alertInfo:@"已添加至我的收藏"];
//            block(YES);
//        }else if ([message containsString:@"repeat"]) {
//            [MBProgressHUD alertInfo:@"已存在"];
//            block(NO);
//        }else{
//            [MBProgressHUD alertInfo:@"失败"];
//            block(NO);
//        }
//    } fail:^(NSError *error) {
//        block(NO);
//    }];
//}
@end
