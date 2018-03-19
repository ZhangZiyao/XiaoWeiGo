//
//  UserModel.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "UserModel.h"

static NSString *const ISLOGIN  = @"ISLOGIN";
//static NSString *const USERINFO = @"USERINFO";
static NSString *const UDATA    = @"data";
static NSString *const USTATE   = @"state";
static NSString *const UUSERID  = @"userid";
static NSString *const UMSG     = @"msg";
@implementation UserModel
+ (UserModel *)share
{
    static UserModel *user = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        user = [[self alloc] init];
    });
//    if ([self isLogin])
//    {
//        user = [UserModel modelOfDictionary:[self userInfo]];
//    }
//    else
//    {
//        user = [UserModel modelOfDictionary:[self userInfo]];
//    }
    return user;
}

+ (BOOL)isLogin
{
    return [USER_DEFAULT boolForKey:ISLOGIN];
}

//+ (NSDictionary *)userInfo
//{
//    return [USER_DEFAULT objectForKey:USERINFO];
//}

//+ (void)saveUserInfo:(NSDictionary *)userInfo
//{
//    [USER_DEFAULT setObject:userInfo forKey:USERINFO];
//    [USER_DEFAULT setBool:YES forKey:ISLOGIN];
//}

+ (void)logout
{
//    [USER_DEFAULT removeObjectForKey:USERINFO];
    [USER_DEFAULT setBool:NO forKey:ISLOGIN];
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"环信退出成功");
    }
}

/**
 *
 *  用户用到的接口
 *
 *  @param params 需要的参数
 *  @param block   回掉
 */
+ (void)loginWithParams:(NSDictionary *)params block:(void(^)(BOOL isLogin))block
{
    RequestManager *request = [[RequestManager alloc] init];
    [request POSTRequestUrlStr:kLogin parms:params success:^(id responseData) {
        NSString *message = responseData[0];
        if ([message containsString:@"notfound"]) {
            [MBProgressHUD alertInfo:@"账号不存在"];
            block(NO);
        }else if ([message containsString:@"pwdErr"]) {
            [MBProgressHUD alertInfo:@"密码不正确"];
            block(NO);
        }else{
            [MBProgressHUD alertInfo:@"登录成功"];
            EMError *error = [[EMClient sharedClient] loginWithUsername:[params objectForKey:@"name"] password:[params objectForKey:@"name"]];
            if (!error) {
                NSLog(@"环信登录成功");
                //设置自动登录
//                [[EMClient sharedClient].options setIsAutoLogin:YES];
            }
            block(YES);
            [USER_DEFAULT setBool:YES forKey:ISLOGIN];
            [USER_DEFAULT setObject:message forKey:USERIDKEY];
            [UserModel getUserData];
        }
    } fail:^(NSError *error) {
        block(NO);
    }];
}

+ (void)registWithUrl:(NSString *)urlString params:(NSDictionary *)params block:(void (^)(BOOL success))block
{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    [manager POSTRequestUrlStr:urlString parms:params success:^(id responseData) {
        
        NSString *message = responseData[0];
        if ([message containsString:@"success"]) {
            [MBProgressHUD alertInfo:@"注册成功"];
            EMError *error = [[EMClient sharedClient] registerWithUsername:[params objectForKey:@"name"] password:[params objectForKey:@"name"]];
            if (error==nil) {
                NSLog(@"环信注册成功");
            }
            block(YES);
        }else if ([NSString isPureInt:message] && [message intValue] > -1) {
            [MBProgressHUD alertInfo:@"注册成功"];
            EMError *error = [[EMClient sharedClient] registerWithUsername:[params objectForKey:@"name"] password:[params objectForKey:@"name"]];
            if (error==nil) {
                NSLog(@"环信注册成功");
            }
            block(YES);
        }else if ([message intValue] == -1){
            [MBProgressHUD alertInfo:@"注册成功"];//用户注册成功,但需要管理员审核(用户不可用)
            block(YES);
        }else if ([message containsString:@"repeat"]){
            [MBProgressHUD alertInfo:@"用户名已被注册"];
            block(NO);
        }else if ([message containsString:@"danger"]){
            [MBProgressHUD alertInfo:@"用户名或者密码有注入字符串,失败"];
            block(NO);
        }else if ([message containsString:@"failed"]){
            [MBProgressHUD alertInfo:@"注册失败，请稍后重试"];
            block(NO);
        }else if ([message containsString:@"typeError"]){
            [MBProgressHUD alertInfo:@"注册用户类型出错"];
            block(NO);
        }else{
            [MBProgressHUD alertInfo:message];
            block(NO);
        }
        
    } fail:^(NSError *error) {
        block(NO);
    }];
}
+ (void)getUserData{
    NSDictionary *params = @{@"uId":[USER_DEFAULT objectForKey:USERIDKEY]};
    
    //        WS(weakSelf);
    RequestManager *request = [[RequestManager alloc] init];
    [request POSTRequestUrlStr:kGetUserInfo parms:params success:^(id responseData) {
        
        NSLog(@" responseData  %@ ",[responseData class]);
        if (responseData) {
            UserModel *user = [UserModel mj_objectWithKeyValues:responseData[0]];
            user.uId = [USER_DEFAULT objectForKey:USERIDKEY];
//            [RWCache setUser:user];
            APPDELEGATE.user = user;
            EMError *error = [[EMClient sharedClient] loginWithUsername:[params objectForKey:@"name"] password:[params objectForKey:@"name"]];
            if (!error) {
                NSLog(@"环信登录成功");
                //设置自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
            }
//            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
//            if (!isAutoLogin) {
//                EMError *error = [[EMClient sharedClient] loginWithUsername:user.name password:user.name];
//                if (!error) {
//                    NSLog(@"环信登录成功");
//                }
//            }
        }else{
        }
        
    } fail:^(NSError *error) {
    }];
}
/**
 *
 *  用户修改密码接口
 */
+ (void)resetPwdWithParams:(NSDictionary *)params block:(void(^)(BOOL success))block{
    RequestManager *request = [[RequestManager alloc] init];
    [request POSTRequestUrlStr:KForgetPwd parms:params success:^(id responseData) {
        NSString *message = responseData[0];
        if ([message containsString:@"notfound"]) {
            [MBProgressHUD alertInfo:@"账号不存在"];
            block(NO);
        }else if ([message containsString:@"pwdErr"]) {
            [MBProgressHUD alertInfo:@"密码不正确"];
            block(NO);
        }else if ([message containsString:@"success"]) {
            [MBProgressHUD alertInfo:@"密码修改成功"];
            block(YES);
        }else{
            [MBProgressHUD alertInfo:message];
            block(NO);
        }
    } fail:^(NSError *error) {
        block(NO);
    }];
}
/*!
 *  自动登录返回结果
 *
 *  @param error 错误信息
 */
//- (void)autoLoginDidCompleteWithError:(EMError *)error{
//
//}

//添加回调监听代理: [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
+ (BOOL)isData:(id)data
{
    UserModel *model = [UserModel modelOfDictionary:data];
    if ([model.data count] > 0) {
        return YES;
    }
    return NO;
}
@end
