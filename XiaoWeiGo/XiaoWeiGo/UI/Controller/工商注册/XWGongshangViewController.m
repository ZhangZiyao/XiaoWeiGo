//
//  XWGongshangViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWGongshangViewController.h"

@interface XWGongshangViewController ()

@end

@implementation XWGongshangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工商注册";
    [self showBackItem];
    NSDictionary *dict = @{@"title":@"工商注册",@"topImage":@"registered_img_banner",@"images":@[@"registered_icon_nav9",@"registered_icon_nav8",@"registered_icon_nav7"]};
    [self loadHeadView:dict];
    [self loadTableViewWithData:@"9" type:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
