//
//  XWLawServiceViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWLawServiceViewController.h"

@interface XWLawServiceViewController ()

@end

@implementation XWLawServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"法律服务";
    [self showBackItem];
    self.categoryType = 5;
    NSDictionary *dict = @{@"title":@"法律服务",@"topImage":@"legal_img_banner",@"images":@[@"legal_icon_nav1",@"legal_icon_nav2",@"legal_icon_nav3"]};
    [self loadHeadView:dict];
    [self loadTableViewWithData:@"5" type:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
