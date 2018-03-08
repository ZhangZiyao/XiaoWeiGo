//
//  UIColor+Extension.m
//  ucupay
//
//  Created by dingxin on 2017/9/13.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+ (UIColor *)colorwithHexString:(NSString*)stringToConvert
{
    NSString *valueString = stringToConvert;
    valueString = [valueString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([valueString hasPrefix:@"0x"]){
        valueString = [stringToConvert substringFromIndex:2];
    }
    if (valueString.length != 8 && valueString.length != 6){
        return nil;
    }
    
    unsigned color = 0;
    unsigned alpha = 255;
    if (valueString.length == 6){
        NSScanner *scanner = [NSScanner scannerWithString:valueString];
        [scanner scanHexInt:&color];
    }else{
        NSScanner *scanner = [NSScanner scannerWithString:[valueString substringToIndex:6]];
        [scanner scanHexInt:&color];
        scanner = [NSScanner scannerWithString:[valueString substringFromIndex:6]];
        [scanner scanHexInt:&alpha];
    }
    
    return [UIColor colorWithHex:color alpha:alpha/255.0f];
}

+ (UIColor *)colorWithHex:(NSString *)stringToConvert
{
    return [self colorwithHexString:stringToConvert];
}
+(UIColor *)colorWithHex:(NSUInteger)color alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((color & 0xff0000) >> 16) / 255.0f
                           green:((color & 0xff00) >> 8) / 255.0f
                            blue:(color & 0xff) / 255.0f
                           alpha:alpha];
}
@end
