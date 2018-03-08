//
//  RequestManager.h
//  ucupay
//
//  Created by dingxin on 2017/7/18.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class RequestModel;


/**
 请求成功回调
 
 @param responseData 请求的业务信息
 */
typedef void (^TYRequestSuccessBlock)(id responseData);


/**
 请求失败回调
 
 @param error 错误信息
 */
typedef void (^TYRequestFailBlock)(NSError *error);

@interface RequestManager : NSObject

#pragma mark - 请求过程中展示相关(转菊花)
//****************************************请求过程中展示相关******************************************//


/**
 是否允许用户交互 网络请求的过程中 默认 YES
 */
@property (nonatomic ,assign) BOOL userInteractionEnabledRequestLoading;

/**
 菊花显示在哪个视图上 默认窗口(加载过程，和加载失败均显示在此视图上)
 */
@property (nonatomic ,strong) UIView *showView;

/**
 是否展示请求过程中的菊花 默认展示 isShowLoading = YES;
 */
@property (nonatomic ,assign) BOOL isShowLoading;

/**
 加载过程中展示的文字 默认展示 ‘努力加载中...’
 */
@property (nonatomic ,copy) NSString *loadingString;

/**
 是否允许用户交互当展示用户请求失败原因的时候 默认 YES
 */
@property (nonatomic ,assign) BOOL userInteractionEnabledRequestFail;

/**
 是否展示请求失败的原因   默认展示 isShowFailResult = YES;
 */
@property (nonatomic ,assign) BOOL isShowFailResult;

/**
 加载失败展示的文字  默认展示 ‘服务器异常，请稍后重试。’  展示规则 '接口中返回的错误信息'>>'默认错误信息“服务器异常，请稍后重试。”'>>'自定义信息'
 */
@property (nonatomic ,copy) NSString *failString;

/**
 展示错误信息的时间 默认展示3s
 */
@property (nonatomic ,assign) NSTimeInterval showFailInfoInterval;

//*************************************************************************************************//

#pragma mark - GET请求
/**
 GET 请求
 
 @param urlStr         请求网址
 @param RequestSuccess 请求成功
 @param RequestFail    请求失败
 */

- (void)GETRequestUrlStr:(NSString *)urlStr
                  success:(TYRequestSuccessBlock)RequestSuccess
                     fail:(TYRequestFailBlock)RequestFail;
/**
 GET 请求
 
 @param urlStr         请求网址
 @param parms          参数
 @param RequestSuccess 请求成功
 @param RequestFail    请求失败
 */

- (void)GETRequestUrlStr:(NSString *)urlStr
                   parms:(NSDictionary *)parms
                 success:(TYRequestSuccessBlock)RequestSuccess
                    fail:(TYRequestFailBlock)RequestFail;


#pragma mark - POST请求
/**
 POST 请求，不包含参数
 
 @param urlStr         请求网址
 @param RequestSuccess 请求成功
 @param RequestFail    请求失败
 */

- (void)POSTRequestUrlStr:(NSString *)urlStr
                  success:(TYRequestSuccessBlock)RequestSuccess
                     fail:(TYRequestFailBlock)RequestFail;

/**
 POST 请求， 包含参数 所有参数均参与签名
 
 @param urlStr         请求网址
 @param parms          参数
 @param RequestSuccess 请求成功
 @param RequestFail    请求失败
 */
- (void)POSTRequestUrlStr:(NSString *)urlStr
                    parms:(NSDictionary *)parms
                  success:(TYRequestSuccessBlock)RequestSuccess
                     fail:(TYRequestFailBlock)RequestFail;


/**
 POST 请求， 包含签名字段和非签名字段
 RequestModel
 @param urlStr         请求网址
 @param signParms      参与签名的字段
 @param RequestSuccess 请求成功
 @param RequestFail    请求失败
 */
- (void)POSTRequestUrlStr:(NSString *)urlStr
                signParms:(NSDictionary *)signParms
                  success:(TYRequestSuccessBlock)RequestSuccess
                     fail:(TYRequestFailBlock)RequestFail;

/**
 错误码
 */
//- (NSString *)getMessageWithText:(NSString *)errorCode;
@end
