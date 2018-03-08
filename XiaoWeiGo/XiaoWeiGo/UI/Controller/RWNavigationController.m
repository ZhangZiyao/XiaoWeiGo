//
//  RWNavigationController.m
//  ucupay
//
//  Created by dingxin on 2017/9/13.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "RWNavigationController.h"

@interface RWNavigationController ()

@end

@implementation RWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    // 删除系统自带的tabBarButton
//    for (UIView *tabBar in self.tabBarController.tabBar.subviews) {
//        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabBar removeFromSuperview];
//        }
//    }
//}

@end
