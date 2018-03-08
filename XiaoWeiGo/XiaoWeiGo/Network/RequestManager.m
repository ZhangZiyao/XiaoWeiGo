//
//  RequestManager.m
//  ucupay
//
//  Created by dingxin on 2017/7/18.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "RequestManager.h"
#import "RequestModel.h"
#import "FBEncryptorDES.h"
#import "RWEnvironmentManager.h"
//#import "AFHTTPRequestOperationManager.h"

#define ErrorDomin @"com.ucupay.com"
typedef NS_ENUM(NSInteger, RWResponsetCode){
    RWResponseSuccess = 0,               // 请求成功 statecode = 200,
    RWResponseTimeout = 1,               // 请求超时 statecode = 4xx,
    RWResponseServerRefuse = 2,          // 请求拒绝 statecode =
    RWResponseServerNoResponse = 3,      // 服务器拒绝  1.签名不通过 2.服务器未响应
    RWResponseFormatError  = -101,        // 服务器返回格式错误，一般是服务器异常
};
@interface RequestManager ()
{
    MBProgressHUD *_requestLoadingHud;
    MBProgressHUD *_requestFailHud;
//    AFHTTPSessionManager *manager;
}
@end

@implementation RequestManager
- (instancetype)init
{
    self = [super init];
    [self initProperty];
    return self;
}
- (void)tokenInvalid{
//    self.failString = @"登录失效，请重新登录";
//    [APPDELEGATE showHomePage:1];
//    [[RWUserInfoManager manager] cleanUserInfo];
//    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    [defaults setObject:@"" forKey:baseUrlkey];
//    [defaults setObject:@"" forKey:useraccountkey];
//    [defaults setObject:@"" forKey:systemTypeKey];
//    [defaults setObject:@"" forKey:imeikey];
//    [defaults setBool:NO forKey:NormalLogin];
//    [CacheUtils getUser].loginName = @"";
//    [CacheUtils getUser].token = @"";
}
- (void)GETRequestUrlStr:(NSString *)urlStr success:(TYRequestSuccessBlock)RequestSuccess fail:(TYRequestFailBlock)RequestFail{
    [self GETRequestUrlStr:urlStr
                      parms:nil
                    success:RequestSuccess
                       fail:RequestFail];
}

- (void)GETRequestUrlStr:(NSString *)urlStr parms:(NSDictionary *)parms success:(TYRequestSuccessBlock)RequestSuccess fail:(TYRequestFailBlock)RequestFail{
    [self GETRequestUrlStr:urlStr
                 signParms:parms
                   success:RequestSuccess
                      fail:RequestFail];
}

- (void)GETRequestUrlStr:(NSString *)urlStr signParms:(NSDictionary *)signParms success:(TYRequestSuccessBlock)RequestSuccess fail:(TYRequestFailBlock)RequestFail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置接收的response类型 服务器默认 ‘text/plain’ 格式，需要接受的是’application/json‘
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",@"text/xml",nil];
    // 设置发送的body体格式
    manager.requestSerializer = [AFHTTPRequestSerializer new];
    // 设置通用请求头
    // 设置接收类型
    [manager.requestSerializer setValue:@"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    // 设置时间戳
//    NSString *timestamp = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
//    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [manager.requestSerializer setTimeoutInterval:10];
    
    if (self.isShowLoading) {
        // 展示加载框
        [self showLoading];
    }
    NSLog(@"%@  %@",urlStr,signParms);
//    WS(weakSelf);
    NSString *realUrl = [NSString stringWithFormat:@"%@%@",[RWEnvironmentManager host],urlStr];
    realUrl = [realUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:realUrl parameters:signParms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self dismissLoading];
        
        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *responseDict = [self dictionaryWithJsonString:[response objectForKey:@"d"]];
        NSLog(@"成功返回responseObject：%@",responseDict);
        RequestSuccess(responseDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dealFailError:error];
        NSLog(@"失败返回responseObject：%@",error);
        RequestFail(error);
        NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"服务器的错误原因:%@",str);
    }];
}

- (void)POSTRequestUrlStr:(NSString *)urlStr success:(TYRequestSuccessBlock)RequestSuccess fail:(TYRequestFailBlock)RequestFail
{
    [self POSTRequestUrlStr:urlStr
                      parms:nil
                    success:RequestSuccess
                       fail:RequestFail];
}


- (void)POSTRequestUrlStr:(NSString *)urlStr parms:(NSDictionary *)parms success:(TYRequestSuccessBlock)RequestSuccess fail:(TYRequestFailBlock)RequestFail
{
    
    [self POSTRequestUrlStr:urlStr
                  signParms:parms
                    success:RequestSuccess
                       fail:RequestFail];
    
}


- (void)POSTRequestUrlStr:(NSString *)urlStr signParms:(NSDictionary *)signParms success:(TYRequestSuccessBlock)RequestSuccess fail:(TYRequestFailBlock)RequestFail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    // 设置接收的response类型 服务器默认 ‘text/plain’ 格式，需要接受的是’application/json‘
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",nil];
    // 设置发送的body体格式
    manager.requestSerializer = [AFJSONRequestSerializer new];
    // 设置通用请求头
    // 设置接收类型
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    // 设置时间戳
//    NSString *timestamp = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
//    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [manager.requestSerializer setTimeoutInterval:10];
    
    if (self.isShowLoading) {
        // 展示加载框
        [self showLoading];
    }
    
    NSString *realUrl = [NSString stringWithFormat:@"%@%@",[RWEnvironmentManager host],urlStr];
    realUrl = [realUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@  \n %@ ",realUrl,signParms);
//    WS(weakSelf);
    [manager POST:realUrl
       parameters:signParms
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              [self dismissLoading];
              
              id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              NSDictionary *responseDict = [self dictionaryWithJsonString:[response objectForKey:@"d"]];
              NSLog(@"成功返回responseObject：%@",responseDict);
              RequestSuccess(responseDict);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [self dealFailError:error];
              NSLog(@"失败返回responseObject：%@",error);
              RequestFail(error);
              NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
              NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"服务器的错误原因:%@",str);
          }];

}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//- (NSString *)signWithDict:(NSMutableDictionary *)dict
//{
//    NSLog(@"Dict === %@",dict);
//    NSArray * allKeys = dict.allKeys;
//    NSArray * orderArray = [allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
//    NSMutableString *md5String = [NSMutableString new];
//    for (int i = 0; i < orderArray.count; i++) {
//        [md5String appendFormat:@"%@=%@&",orderArray[i], [dict objectForKey:orderArray[i]]];
//    }
////    [md5String appendFormat:@"key=%@",UCUpay_API_Key];
//
//    NSLog(@"签名前排序 === %@",md5String);
//    return [md5String rw_md5WithString];
//}

- (void)_dealSuccessfulResponse:(id)responseObject
{
    [self dismissLoading];
//    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
//    BASE_ERROR_FUN(@"网络请求成功");
//    BASE_ERROR_FUN(jsonString);
//    
//    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
//    NSMutableDictionary *dict = [jsonParser objectWithString:jsonString];
//    if ([[dict objectForKey:@"status"] boolValue]) {
//        
//        
//    }else{
//        self.failString = [dict objectForKey:@"message"];
//        [self showErrorInfo];
//        
//    }
    
//    if([jsonString rangeOfString:@"无效的token"].location !=NSNotFound){
//        
////        [_delegate opFail:@"登录失效"];
//        
//        UserModel *user = [CacheUtils getUser];
//        user.loginName = @"";
//        //        TimeOutLoginController *timeOutLoginController =[[TimeOutLoginController alloc] init];
//        //        [timeOutLoginController setLogin:[_opInfo objectForKey:@"url"] param2: [_opInfo objectForKey:@"body"] delegate:_delegate];
//        self.failString = @"登录失效";
//        [self showErrorInfo];
//        return;
//    }
}
- (void)dealFailError:(NSError *)error
{
    NSLog(@"fail ==== %@",error);
    [self dismissLoading];
    if (error) {
        RequestModel * model = [[RequestModel alloc] init];
        model.errorCode = error.code;
        switch (error.code) {
            case NSURLErrorCancelled:
            {
                model.message = @"网络请求取消";
                break;
            }
            case NSURLErrorTimedOut:
            {
                model.message = @"网络请求超时，请稍后重试";
                break;
            }
            case -2102:
            {
                model.message = @"网络请求超时，请稍后重试";
                break;
            }
            case NSURLErrorCannotConnectToHost:
            {
                model.message = @"网络连接失败，请稍后重试";
                break;
            }
            case NSURLErrorNotConnectedToInternet:
            {
                model.message = @"没有网络";
                break;
            }
            default:
            {
                model.message = @"网络繁忙，请稍后重试";
                break;
            }
        }
        model.status = false;
        self.failString = model.message;
        [self showErrorInfo];
    }
}

- (void)initProperty
{
    self.isShowLoading = YES;
    self.isShowFailResult = YES;
    self.userInteractionEnabledRequestFail = YES;
    self.userInteractionEnabledRequestLoading = YES;
    self.loadingString = @"加载中...";
    self.failString = @"服务器异常，请稍后重试。";
    self.showFailInfoInterval = 3.0f;
    self.showView = [UIApplication sharedApplication].keyWindow;
}

- (void)showLoading
{
    _requestLoadingHud = [MBProgressHUD showHUDAddedTo:self.showView animated:YES];
    _requestLoadingHud.label.text = self.loadingString;
    _requestLoadingHud.label.numberOfLines = 0;
    _requestFailHud.backgroundColor = [UIColor clearColor];
    _requestFailHud.backgroundView.backgroundColor = [UIColor clearColor];
    if (self.userInteractionEnabledRequestLoading) _requestLoadingHud.userInteractionEnabled = NO;
}

- (void)dismissLoading
{
    if (_requestLoadingHud) {
        [_requestLoadingHud hideAnimated:YES];
    }
}

- (void)showErrorInfo
{
    if (self.isShowFailResult) {
        _requestFailHud = [MBProgressHUD showHUDAddedTo:self.showView animated:YES];
        _requestFailHud.mode = MBProgressHUDModeText;
        _requestFailHud.label.text = self.failString;
        _requestFailHud.label.numberOfLines = 0;
        [_requestFailHud hideAnimated:YES afterDelay:self.showFailInfoInterval];
        if (self.userInteractionEnabledRequestFail) _requestFailHud.userInteractionEnabled = NO;
    }
}
- (NSString *)getMessageWithStatus:(int)errorCode{
    NSString *message = nil;
//    if ([errorCode isEqualToString:@"LACK_PARAMS"]) {
//        message = @"缺少必要的请求参数";
//    }
    if (errorCode == 1017) {
        message = @"未配置价格";
    }
    if (errorCode == 1001) {
        message = @"用户状态异常";
    }
    if (errorCode == 1005) {
        message = @"产品不存在";
    }
    if (errorCode == 1008) {
        message = @"产品不可用";
    }
    if (errorCode == 1009) {
        message = @"订单已存在";
    }
    if (errorCode == 16001) {
        message = @"会员信息修改失败";
    }
    if (errorCode == 17001) {
        message = @"订单提交失败，需要查单";
    }
    if (errorCode == 17018) {
        message = @"销卡有效期过短";
    }
    if (errorCode == 18004) {
        message = @"卡号卡密规则有误";
    }
    if (errorCode == 18005) {
        message = @"无法判断归属地";
    }
    if (errorCode == 18006) {
        message = @"面值预判不符";
    }
    if (errorCode == 18007) {
        message = @"提交卡号|卡密已经成功过";
    }
    if (errorCode == 18008) {
        message = @"销卡价格不符";
    }
    if (errorCode == 90001) {
        message = @"后台请求超时";
    }
    if (errorCode == 90002) {
        message = @"后台读取超时";
    }
    if (errorCode == 90004) {
        message = @"登录超时";
    }
    if (errorCode == 90007) {
        message = @"操作频繁";
    }
    if (errorCode == 90008) {
        message = @"操作失败";
    }
    if (errorCode == 90009) {
        message = @"不在访问时段内";
    }
    if (errorCode == 90999) {
        message = @"系统错误";
    }
    if (errorCode == 16030) {
        message = @"参数不存在";
    }
    if (errorCode == 15031) {
        message = @"批次内存在重复卡";
    }
    if (errorCode == 15032) {
        message = @"卡号或者卡密为空";
    }
    if (errorCode == 15033) {
        message = @"批量提交卡超过100张";
    }
    if (errorCode == 15032) {
        message = @"卡号或者卡密为空";
    }
    if (errorCode == 8001) {
        message = @"信息入库失败";
    }
    if (errorCode == 8002) {
        message = @"该用户没有配置商品";
    }
    if (errorCode == 1006) {
        message = @"加密错误";
    }
    if (errorCode == 9998) {
        message = @"参数错误";
    }
    if (errorCode == 9999) {
        message = @"系统错误";
    }
    if (errorCode == 40001) {
        message = @"供货商登录失败";
    }
    if (errorCode == 99999) {
        message = @"未知异常";
    }
    if (errorCode == 21001) {
        message = @"卡密失败次数过多";
    }
    if (errorCode == 21005) {
        message = @"卡号、卡密解密失败";
    }
    if (errorCode == 21008) {
        message = @"参数有误";
    }
    if (errorCode == 21009) {
        message = @"签名错误";
    }
    if (errorCode == 21010) {
        message = @"不支持的面值";
    }
    if (errorCode == 21011) {
        message = @"不支持的运营商";
    }
    if (errorCode == 21014) {
        message = @"充值失败,卡密已经成功过";
    }
    if (errorCode == 21015) {
        message = @"相同卡密正在处理中";
    }
    if (errorCode == 21017) {
        message = @"卡号卡密规则错误";
    }
    if (errorCode == 21018) {
        message = @"请求号重复";
    }
    if (errorCode == 25000) {
        message = @"系统异常";
    }
    if (errorCode == 23000) {
        message = @"销卡成功";
    }
    if (errorCode == 23001) {
        message = @"卡号密码有误";
    }
    if (errorCode == 23002) {
        message = @"卡号密码失效";
    }
    if (errorCode == 23003) {
        message = @"销卡失败";
    }
    if (errorCode == 23005) {
        message = @"未尝试销卡";
    }
    if (errorCode == 23006) {
        message = @"处理中";
    }
    if (errorCode == 24000) {
        message = @"订单不存在";
    }
    return message;
}

#pragma mark - 移除网址中的空格
- (NSString *)removeUrlBlackSpace:(NSString *)url
{
    NSString *realUrl = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
#if DEBUG
    NSLog(@"url === %@",url);
    NSAssert([realUrl isEqualToString:url], @"网址中有空格");
#else
#endif
    return realUrl;
}

@end
