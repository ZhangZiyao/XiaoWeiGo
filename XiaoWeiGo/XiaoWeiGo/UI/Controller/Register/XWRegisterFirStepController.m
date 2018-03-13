//
//  XWRegisterFirStepController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWRegisterFirStepController.h"
#import "XWScanViewController.h"

@interface XWRegisterFirStepController ()

@end

@implementation XWRegisterFirStepController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self showBackItem];
}
- (void)layoutSubviews{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_icon"]];
    [self.view addSubview:imageView];
    UILabel *label = [RWFactionUI createLabelWith:CGRectMake(0, 0, ScreenWidth, 50) text:@"请拿出您的营业执照，进行手机扫描" textColor:UIColorFromRGB16(0x666666) textFont:[UIFont rw_regularFontSize:14.0] textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    
    UIButton *scanBtn = [[UIButton alloc] init];
    [scanBtn setImage:[UIImage imageNamed:@"register_icon_scan"] forState:UIControlStateNormal];
    scanBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scanBtn];
    [scanBtn addTarget:self action:@selector(pushToScanVC) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100*kScaleH);
        make.size.mas_equalTo(CGSizeMake(53, 40));
        make.centerX.equalTo(self.view);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(40*kScaleH);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(120*kScaleH);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(280*kScaleH);
    }];
}
- (void)pushToScanVC{
    XWScanViewController *scanVc = [[XWScanViewController alloc] init];
    scanVc.type = self.type;
    [self.navigationController pushViewController:scanVc animated:YES];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
