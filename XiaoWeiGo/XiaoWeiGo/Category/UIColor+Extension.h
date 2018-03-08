//
//  UIColor+Extension.h
//  ucupay
//
//  Created by dingxin on 2017/9/13.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SUPPORTS_UNDOCUMENTED_API	YES
#define DEFAULT_VOID_COLOR	[UIColor blackColor] //默认颜色为黑色

@interface UIColor (Extension)

+ (UIColor *)colorWithHex:(NSString*)stringToConvert;//通过16进制码获取颜色
+ (UIColor *)colorWithHex:(NSUInteger)color alpha:(CGFloat)alpha;
@end
