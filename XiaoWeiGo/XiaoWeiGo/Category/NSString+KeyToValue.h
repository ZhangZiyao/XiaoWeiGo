//
//  NSString+KeyToValue.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KeyToValue)

+ (NSString *)getImageNameWithCategory:(int)key;

+ (NSString *)getCategoryNameWithCategory:(int)key;

@end