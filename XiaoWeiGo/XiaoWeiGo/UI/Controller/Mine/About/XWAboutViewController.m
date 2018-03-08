//
//  XWAboutViewController.m
//  XiaoWeiGo
//
//  Created by Ziyao on 2018/2/12.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWAboutViewController.h"

@interface XWAboutViewController ()

@end

@implementation XWAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于小微加油";
    [self showBackItem];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
