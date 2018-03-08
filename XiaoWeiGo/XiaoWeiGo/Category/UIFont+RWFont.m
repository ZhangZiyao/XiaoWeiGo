//
//  UIFont+RWFont.m
//  ucupay
//
//  Created by dingxin on 2017/9/13.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "UIFont+RWFont.h"

@implementation UIFont (RWFont)
/**
 PingFangSC-Regular
 */
+ (UIFont *)rw_regularFontSize:(CGFloat)fontsize{
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= IOSBaseVersion9) {
       return [UIFont fontWithName:@"PingFangSC-Regular" size:fontsize];
    }else{
        return [UIFont systemFontOfSize:fontsize];
    }
}
/**
 PingFangSC-Medium
 */
+ (UIFont *)rw_mediumFontSize:(CGFloat)fontsize{
    
    if ([APPDELEGATE.systemVersion compare:@"9.0"] != NSOrderedAscending) {
        return [UIFont fontWithName:@"PingFangSC-Medium" size:fontsize];
    }else{
        return [UIFont systemFontOfSize:fontsize];
    }
}
@end
