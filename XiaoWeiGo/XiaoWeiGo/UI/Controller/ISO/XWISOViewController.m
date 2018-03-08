//
//  XWISOViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWISOViewController.h"

@interface XWISOViewController ()

@end

@implementation XWISOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ISO认证";
    [self showBackItem];
    NSDictionary *dict = @{@"title":@"ISO认证",@"topImage":@"iso_img_banner",@"images":@[@"certification_icon_nav1",@"certification_icon_nav2",@"certification_icon_nav3"]};
    [self loadHeadView:dict];
    [self loadTableViewWithData:@"7" type:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
