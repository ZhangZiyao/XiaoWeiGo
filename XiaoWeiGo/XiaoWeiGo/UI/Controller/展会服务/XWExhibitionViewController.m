//
//  XWExhibitionViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWExhibitionViewController.h"

@interface XWExhibitionViewController ()

@end

@implementation XWExhibitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"展会服务";
    [self showBackItem];
    NSDictionary *dict = @{@"title":@"展会服务",@"topImage":@"exhibition_img_banner",@"images":@[@"exhibition_icon_nav1",@"exhibition_icon_nav2",@"exhibition_icon_nav3"]};
    [self loadHeadView:dict];
    [self loadTableViewWithData:@"8" type:0];
}

- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
