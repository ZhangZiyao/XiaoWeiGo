//
//  RWEnvironmentManager.h
//  ucupay
//
//  Created by dingxin on 2017/7/11.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 环境配置不能为0
 */
typedef NS_ENUM(NSInteger, RWEnvironmentType){
    RWEnvironmentLocal = 1,     // 本地环境
    RWEnvironmentDevelop = 2,   // 开发环境
    RWEnvironmentOnline = 3,    // 线上环境
};

@interface RWEnvironmentManager : NSObject

+ (instancetype)manager;

- (void)setEnvironmentType:(RWEnvironmentType)type;

+ (NSString *)host;

@end
