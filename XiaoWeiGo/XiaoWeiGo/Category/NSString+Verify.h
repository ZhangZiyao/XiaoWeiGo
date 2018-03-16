//
//  NSString+Verify.h
//  ucupay
//
//  Created by dingxin on 2017/7/12.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)
+ (BOOL)isNoTeShuZiFu:(NSString *)string;
//是不是正确卡号
+(BOOL)isCorrectCardNumber:(NSString *)str;
//是不是正确卡密
+(BOOL)isCorrectCardPwd:(NSString *)str;
//是不是正确支付宝账号
+(BOOL)isCorrectAlipayAccount:(NSString *)str;
//
+(BOOL)isCorrectRealName:(NSString *)str;
+ (BOOL)isPureInt:(NSString *)string;
+ (NSString *)ifNull:(NSString *)string;
//是否为空字符串
+(BOOL)isEmpty:(NSString *)str;
//手机号规则
+ (BOOL)valiMobileNum:(NSString *)mobileNum;
//验证网址
+ (BOOL)valiUrl:(NSString *)url;
//验证客服电话
+ (BOOL)valiServiceMobileNum:(NSString *)mobileNum;
//6位纯数字
//+ (BOOL)isPureInt:(NSString *)string;
//身份证号
+(bool)isNameID:(NSString *)str;
//是不是六位纯数字
+(BOOL)isSixPureNumber:(NSString *)str;
//登录密码规则
+(BOOL)MatchLetter:(NSString *)str;
//银行卡
+(BOOL)isBankCard:(NSString *)cardNumber;
- (BOOL)isUserName;

- (BOOL)isEmailAddress;
- (BOOL)isValidQQnum;
- (BOOL)isValidUrl;

- (BOOL)isValidPassword;

- (BOOL)isValidWechat;

- (BOOL)isValidWechatOrQQ;
//判断是否是特殊字符
- (BOOL)evaluateString;

@end
