//
//  AppDelegate.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSString *systemVersion;
@property (nonatomic, strong) Reachability *hostReach;

@property (nonatomic, assign) int isReachable;

@property (nonatomic, assign) BOOL isOnline;

@property (nonatomic, strong) UserModel *user;

@end

