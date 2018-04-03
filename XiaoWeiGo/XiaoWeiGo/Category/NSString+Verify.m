//
//  NSString+Verify.m
//  ucupay
//
//  Created by dingxin on 2017/7/12.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)


+ (BOOL)isNoTeShuZiFu:(NSString *)string {
    NSString *regex = @"[^a-zA-Z0-9\u4E00-\u9FA5,.?:;()!{}<>#*-+=，。、？：；……（）！{}+=]➋➌➍➎➏➐➑➒1⃣️2⃣️3⃣️4⃣️🈚️5⃣️6⃣️7⃣️8⃣️9⃣️_😊🔟";
    NSRange urgentRange = [string rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: regex]];
    if (urgentRange.location == NSNotFound){
        return NO;
    }
    return YES;
}

+ (NSString *)ifNull:(NSString *)string{
    if (string==nil||string.length==0) {
        return @"— —";
    }
    return string;
}

//判断字符串是不是空
+(BOOL)isEmpty:(NSString *)str{
    
    if (str==nil||str.length==0) {
        return true;
    }
    return false;
}
//1.整型判断:
+ (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//2.浮点形判断：
- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
//验证网址
+ (BOOL)valiUrl:(NSString *)url{
    NSString *Match = @"^(https?|ftp|file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Match];
    return [regextestmobile evaluateWithObject:url];
}
//验证客服电话
+ (BOOL)valiServiceMobileNum:(NSString *)mobileNum{
//    NSString *MOBILE = @"^0[0-9]{2,3}[0-9]{7,8}$|^400[0-9]{7}$|^800[0-9]{7}$";
//    NSString *PHONE = @"^1[3|4|5|7|8][0-9]{9}$";
//
//    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    BOOL isMatch1 = [pred1 evaluateWithObject:mobileNum];
//    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHONE];
//    BOOL isMatch2 = [pred2 evaluateWithObject:mobileNum];
//
//    if (isMatch1 || isMatch2) {
//        return YES;
//    }else{
//        return NO;
//    }
    //验证输入的固话中带 "-"符号
    NSString * strNum = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    return [regextestmobile evaluateWithObject:mobileNum];
}
//验证手机号
+ (BOOL)valiMobileNum:(NSString *)mobileNum{
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";//包括176，177，178号段
    NSString *MOBILE = @"^1[3|4|5|7|8|9][0-9]{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}
//验证身份证号后8位
+ (BOOL)valiIdCardNo:(NSString *)str{
    NSString * MOBILE = @"(^\\d{8}$)|(^\\d{7}(\\d|X|x)$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:str] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//是不是正确卡号 是不是16位纯数字
+(BOOL)isSixPureNumber:(NSString *)str{
    NSString *pat = @"^\\d{6}$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pat];
    if ([regextestA evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}
//是不是正确卡密
+(BOOL)isCorrectCardPwd:(NSString *)str{
    NSString *pat = @"^\\d{20}$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pat];
    if ([regextestA evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}
//是不是正确支付宝账号
+(BOOL)isCorrectAlipayAccount:(NSString *)str{
    NSString *emailRegex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSString *phoneRegex = @"^1[345789]\\d{9}$";
    
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSPredicate *regextestB = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    if ([regextestA evaluateWithObject:self] == YES || [regextestB evaluateWithObject:self] == YES)
        return NO;
    else
        return YES;
}
//是不是真实姓名
+(BOOL)isCorrectRealName:(NSString *)str{
    NSString *pat = @"[0-9]";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pat];
    if ([regextestA evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}
//登录密码规则
+(BOOL)MatchLetter:(NSString *)str{
    //判断是否以字母开头
    NSString *pat = @"[\\da-zA-Z]{6,12}";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pat];
    NSString *patno = @".*\\d.*";
    NSPredicate *regextestB = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patno];
    NSString *paten = @".*[a-zA-Z].*";
    NSPredicate *regextestC = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", paten];
    
    //判断是否以字母开头
    NSString *ZIMU = @"[^0-9_][^: ]*";
    NSPredicate *regextestD = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES&&[regextestB evaluateWithObject:str] == YES&&[regextestC evaluateWithObject:str] == YES&&[regextestD evaluateWithObject:str] == YES)
        return NO;
    else
        return YES;
    
}
#pragma mark - 身份证号验证
+(bool)isNameID:(NSString *)str{
    NSString * MOBILE = @"(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:str] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (BOOL)isUserName
{
    NSString *    regex = @"(^[A-Za-z0-9]{3,20}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}
- (BOOL)isEmailAddress {
    NSString *emailRegex = @"^[a-zA-Z0-9]+([._\\-]*[a-zA-Z0-9])*@([a-zA-Z0-9]+[-a-zA-Z0-9]*[a-zA-Z0-9]+.){1,63}[a-zA-Z0-9]+$";
    return [self isValidateByRegex:emailRegex];
}
//QQ号  [1-9][0-9]{4,14} || [1-9]\\d{4,14}
- (BOOL)isValidQQnum{
    NSString *qqRegex = @"[1-9][0-9]{4,14}";
    return [self isValidateByRegex:qqRegex];
}
- (BOOL)isValidWechatOrQQ{
    NSString *wxRegex = @"^[a-zA-Z]{1}[-_a-zA-Z0-9]{5,19}+$";
    NSString *qqRegex = @"[1-9][0-9]{4,14}";
    NSString *MOBILE = @"^1[3|4|5|7|8][0-9]{9}$";
    
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", wxRegex];
    NSPredicate *regextestB = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", qqRegex];
    NSPredicate *regextestC = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestA evaluateWithObject:self] == YES&&[regextestB evaluateWithObject:self] == YES&&[regextestC evaluateWithObject:self] == YES)
        return NO;
    else
        return YES;
    
    return [self isValidateByRegex:wxRegex];
}
- (BOOL)isValidWechat{
    NSString *wxRegex = @"^[a-zA-Z]{1}[-_a-zA-Z0-9]{5,19}+$";
    return [self isValidateByRegex:wxRegex];
}
- (BOOL)isValidUrl {
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//(^[A-Za-z0-9]{6,20}$)
//- (BOOL)isValidPassword {
//    NSString *regex2 = @"[a-zA-Z0-9]{6,20}";
//    return [self isValidateByRegex:regex2];
//}
- (BOOL)isValidPassword {
    //只能包含“字母”，“数字”，“符号”，长度6~20，不能是纯数字 ^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}$
    NSString *regex = @"^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{6,20}$";
    return [self isValidateByRegex:regex];
}
- (BOOL)isValidateByRegex:(NSString *)regex {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}
#pragma mark 判断银行卡号是否合法
+(BOOL)isBankCard:(NSString *)cardNumber{
    if(cardNumber.length==0){
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++){
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}
//特殊字符
- (BOOL)evaluateString{
    //只能包含“字母”，“数字”，“中文”，不能是特殊符号
//    NSString *regex = @"[\u4e00-\u9fa5]";//匹配中文
//    NSString *regex1 = @"[\u4e00-\u9fa5]";//匹配字母
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";//中文、字母或数字
    return [self isValidateByRegex:regex];
}
@end
