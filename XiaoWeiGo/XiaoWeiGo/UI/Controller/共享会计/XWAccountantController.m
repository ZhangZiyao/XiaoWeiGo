//
//  XWAccountantController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWAccountantController.h"

@interface XWAccountantController ()

@end

@implementation XWAccountantController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"共享会计";
    [self showBackItem];
    self.categoryType = 4;
    NSDictionary *dict = @{@"title":@"共享会计",@"topImage":@"shared_img_banner",@"images":@[@"shared_icon_nav1",@"shared_icon_nav2",@"shared_icon_nav3"]};
    [self loadHeadView:dict];
    [self loadTableViewWithData:@"4" type:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
