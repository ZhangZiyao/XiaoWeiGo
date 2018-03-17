//
//  UIColor+OCRColor.m
//  OilCardRecyle
//
//  Created by dingxin on 2018/2/7.
//  Copyright © 2018年 dingxin. All rights reserved.
//

#import "UIColor+OCRColor.h"

@implementation UIColor (OCRColor)

+ (UIColor *)lineColor{
    return UIColorFromRGB16(0xd2d2d2);
}
+ (UIColor *)OCRMainColor{
    return UIColorFromRGB16(0xe2e2e2);
}
+ (UIColor *)backGroundColor{
    return UIColorFromRGB16(0xf2f3f7);
}
+ (UIColor *)textBlackColor{
    return UIColorFromRGB16(0x666666);
}
+ (UIColor *)textGrayColor{
    return UIColorFromRGB16(0x999999);
}
@end
