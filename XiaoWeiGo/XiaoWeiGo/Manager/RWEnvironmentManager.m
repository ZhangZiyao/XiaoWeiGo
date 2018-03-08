//
//  RWEnvironmentManager.m
//  ucupay
//
//  Created by dingxin on 2017/7/11.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "RWEnvironmentManager.h"

#define LocalHost   @"http://172.16.0.216:7777/app/"
#define OnlineHost  @"https://api.yysmzx.net/api/HTWebInterface.asmx"//正式
#define DeveloperHost @"http://47.96.188.205/api/HTWebInterface.asmx"//http://47.96.188.205/api/HTWebInterface.asmx

@interface RWEnvironmentManager ()

@property (nonatomic ,assign) RWEnvironmentType eType;

@end

@implementation RWEnvironmentManager

// 默认线上 ， 防止出错
- (RWEnvironmentType)eType
{
    if (_eType) {
        return _eType;
    }
    return RWEnvironmentOnline;
}

+ (instancetype)manager
{
    static RWEnvironmentManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[RWEnvironmentManager alloc] init];
    });
    return _manager;
}

- (void)setEnvironmentType:(RWEnvironmentType)type
{
    _eType = type;
}

+ (NSString *)host
{
    NSString *host = nil;
    switch ([RWEnvironmentManager manager].eType) {
        case RWEnvironmentLocal:
        {
            host = LocalHost;
            break;
        }
        case RWEnvironmentDevelop:
        {
            host = DeveloperHost;
            break;
        }
        case RWEnvironmentOnline:
        {
            host = OnlineHost;
            break;
        }
        default:
            break;
    }
    return host;
}

@end
