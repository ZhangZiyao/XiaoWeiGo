//
//  XWSupplyDetailViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWSupplyDetailViewController.h"

@interface XWSupplyDetailViewController ()

@end

@implementation XWSupplyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门服务";
    [self showBackItem];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
