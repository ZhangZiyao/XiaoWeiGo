//
//  MySupplyViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "MySupplyViewController.h"

@interface MySupplyViewController ()

@end

@implementation MySupplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我发布的供应";
    [self showBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
