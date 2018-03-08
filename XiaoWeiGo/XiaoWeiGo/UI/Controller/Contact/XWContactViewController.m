//
//  XWContactViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWContactViewController.h"

@interface XWContactViewController ()

@end

@implementation XWContactViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"陈女士";
    [self showBackItem];
    self.view.backgroundColor = [UIColor colorWithHex:@"ebebeb"];
}
- (void)layoutSubviews{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView setImage:[UIImage imageNamed:@"contact_img"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
