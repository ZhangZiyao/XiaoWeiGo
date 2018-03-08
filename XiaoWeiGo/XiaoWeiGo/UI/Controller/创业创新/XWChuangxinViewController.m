//
//  XWChuangxinViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWChuangxinViewController.h"

@interface XWChuangxinViewController ()

@end

@implementation XWChuangxinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创业创新";
    [self showBackItem];
    self.categoryType = 2;
    NSDictionary *dict = @{@"title":@"创业创新",@"topImage":@"innovation_img_banner",@"images":@[@"innovation_icon_nav1",@"innovation_icon_nav2",@"innovation_icon_nav3"]};
    //innovation_img_avatar  cellimage
    [self loadHeadView:dict];
    [self loadTableViewWithData:@"2" type:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
