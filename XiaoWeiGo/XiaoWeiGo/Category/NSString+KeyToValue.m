//
//  NSString+KeyToValue.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "NSString+KeyToValue.h"

@implementation NSString (KeyToValue)

+ (NSString *)getImageNameWithCategory:(int)key{
    NSArray *imageArr = @[@"loan_img_avatar",@"innovation_img_avatar",@"property_img_avatar",@"shared_img_avatar",@"legal_img_avatar",@"discount_img_avatar",@"certification_img_avatar",@"exhibition_img_avatar",@"registered_img_avatar",@"other_img_avatar"];
    return key==0?imageArr[0]:imageArr[key-1];
}
+ (NSString *)getCategoryNameWithCategory:(int)key{
    if (key == 0) {
        key = 1;
    }
    NSArray *array = @[@"银企对接",@"创业创新",@"知识产权",@"共享会计",@"法律服务",@"优惠政策",@"ISO认证",@"展会服务",@"登记注册",@"其他服务"];
    return array[key-1];
}
@end
