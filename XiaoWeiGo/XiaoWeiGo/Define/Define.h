//
//  Define.h
//  XiaoWei
//
//  Created by dingxin on 2018/1/26.
//  Copyright © 2018年 xwjy. All rights reserved.
//
// 0正式版，1测试版
#define ProductType 0

// 正式版自动使用正式环境
#ifdef OFFICIAL
#undef ProductType
#define ProductType 0
#endif

#if (DEBUG || TESTCASE)
#define FxLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define FxLog(format, ...)
#endif

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define APPDELEGATE     ((AppDelegate *)[UIApplication sharedApplication].delegate)
// 设备类型判断
#define IsiPad     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsiPhone   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IsRetain   ([[UIScreen mainScreen] scale] >= 2.0)


#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define ScreenMaxLength (MAX(ScreenWidth, ScreenHeight))
#define ScreenMinLength (MIN(ScreenWidth, ScreenHeight))
#define kScaleW    (1/750.0*ScreenWidth)
#define kScaleH   (1/1334.0*ScreenHeight)
// 消息通知
#define RegisterNotify(_name, _selector)                    \
[[NSNotificationCenter defaultCenter] addObserver:self  \
selector:_selector name:_name object:nil];

#define RemoveNofify            \
[[NSNotificationCenter defaultCenter] removeObserver:self];

#define SendNotify(_name, _object)  \
[[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object];

#pragma mark - 颜色
/**
 eg:0xffffff 白色,16进制
 */
#define UIColorFromRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 eg:255,255,255,1 白色，透明度为
 */
#define UIColorFromRGB10(R,G,B,A) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(A)]
// 设置颜色值
#define RgbColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define navColor  UIColorFromRGB16(0X3b78d8)

// 主题颜色
#define mainColor  [UIColor colorWithRed:59/255.0 green:120/255.0 blue:216/255.0 alpha:1]
// 主题颜色背景
#define mainColorGray  [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]

// 背景色 f4f2f2
#define bgColor  [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]

// 分割线 灰色 #b2b2b2
#define LineColor  [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]

//字符串相加
#define  StringPush(string1,string2,string3)   [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",string1,string2,string3]]
//获取地址
#define  StringPushUrl(string1)   [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@",_baseUrl,string1]]


//是否为空或是［NSNull null］


#define NotNilAndNull(_ref)    (((_ref)!=nil)&&(![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)     (((_ref)==nil)||([(_ref) isEqual:[NSNull null]]))

//字符串是否为空

#define IsStrEmpty(_ref)   (((_ref)==nil)||([(_ref) isEqual:[NSNull null]])||([(_ref)isEqualToString:@""])||([(_ref)isEqualToString:@"<null>"])|([(_ref)isEqualToString:@"(null)"]))
//是不是验证码
#define IsStrCode(_ref)   ((_ref).length==6)
//数组是否为空
#define IsArrEmpty(_ref)   (((_ref)==nil)||([(_ref) isEqual:[NSNull null]])||([(_ref) count] == 0))

// iOS系统版本
#define IOSBaseVersion11     11.0
#define IOSBaseVersion10     10.0
#define IOSBaseVersion9      9.0
#define IOSBaseVersion8     8.0
#define IOSBaseVersion7     7.0
#define IOSBaseVersion6     6.0
//NSUserDefaults
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#ifndef Define_h
#define Define_h


#endif /* Define_h */
