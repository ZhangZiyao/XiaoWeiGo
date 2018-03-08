//
//  XWRightsViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWRightsViewController.h"

@interface XWRightsViewController ()

@end

@implementation XWRightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"知识产权";
    [self showBackItem];
    self.categoryType = 3;
    NSDictionary *dict = @{@"title":@"知识产权",@"topImage":@"property_img_banner",@"images":@[@"property_icon_nav1",@"property_icon_nav2",@"property_icon_nav3"]};
    [self loadHeadView:dict];
    [self loadTableViewWithData:@"3" type:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
