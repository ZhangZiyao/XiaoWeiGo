//
//  XWDiscountViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWDiscountViewController.h"

@interface XWDiscountViewController ()

@end

@implementation XWDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠政策";
    [self showBackItem];
    NSDictionary *dict = @{@"title":@"优惠政策",@"topImage":@"discount_img_banner",@"images":@[@"discount_icon_nav1",@"discount_icon_nav2",@"discount_icon_nav3"]};
    [self loadHeadView:dict];
    [self loadTableViewWithData:@"6" type:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
