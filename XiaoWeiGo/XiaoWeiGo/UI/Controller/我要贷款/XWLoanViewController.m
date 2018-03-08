//
//  XWLoanViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWLoanViewController.h"

@interface XWLoanViewController ()


@end

@implementation XWLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要贷款";
    [self showBackItem];
    
    self.categoryType = 1;
    NSDictionary *dict = @{@"title":@"我要贷款",@"topImage":@"loan_img_banner",@"images":@[@"loan_img_nav1",@"loan_img_nav2",@"loan_img_nav3"]};
    [self loadHeadView:dict];
    
    [self loadTableViewWithData:@"1" type:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
