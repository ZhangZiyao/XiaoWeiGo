//
//  AppDelegate.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "AppDelegate.h"
#import "XWHomeViewController.h"
#import "RWEnvironmentManager.h"
#import "XWLoginViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AppDelegate ()
{
    BMKMapManager  *_mapManager;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    if([UserModel isLogin]){
//        [self initInfo];
//    }
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:USERLOGINNAMEKEY]) {
        XWHomeViewController *homeVc = [[XWHomeViewController alloc] init];
        RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:homeVc];
        self.window.rootViewController = nav;
//    }else{
//        XWLoginViewController *homeVc = [[XWLoginViewController alloc] init];
//        RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:homeVc];
//        self.window.rootViewController = nav;
//    }
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    self.systemVersion = version;
    
    if (ProductType == 0) {
        [[RWEnvironmentManager manager] setEnvironmentType:RWEnvironmentOnline];
    }else{
        [[RWEnvironmentManager manager] setEnvironmentType:RWEnvironmentDevelop];
    }
    //开启网络状况的监听
    self.isReachable = 1;//默认为wifi网络
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    
    //开始监听，会启动一个run loop
    [self.hostReach startNotifier];
    
    //环信
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:EASE_MOB_APP_KEY];
    options.apnsCertName = @"develop";//develop,distribution
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    //百度地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BAIDU_MAP_APP_KEY  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    return YES;
}

-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    
    NetworkStatus status = [currReach currentReachabilityStatus];
    
    //如果没有连接到网络就弹出提醒实况
    
    
    switch (status) {
        case NotReachable:
            self.isReachable = 0;//无连接
            break;
        case ReachableViaWiFi:
            self.isReachable = 1;//Wi-Fi网络
            break;
        case ReachableViaWWAN:
            self.isReachable = 2;//数据流量
            break;
        default:
            break;
    }
}
//- (void)initInfo{
//    NSDictionary *params = @{@"uId":[USER_DEFAULT objectForKey:USERIDKEY]};
//    //        WS(weakSelf);
//    RequestManager *request = [[RequestManager alloc] init];
//    [request POSTRequestUrlStr:kGetUserInfo parms:params success:^(id responseData) {
//
//        NSLog(@" responseData  %@ ",[responseData class]);
//
//
//        self.isOnline = YES;
//
//        UserModel *model = [UserModel mj_objectWithKeyValues:responseData[0]];
//
//        [RWCache setUser:model];
//
//    } fail:^(NSError *error) {
//
//    }];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
