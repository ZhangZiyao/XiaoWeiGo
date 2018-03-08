//
//  XWRegisterViewController.m
//  XiaoWei
//
//  Created by dingxin on 2018/1/26.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWRegisterViewController.h"
#import "RWFactionUI.h"
#import "RegisterInfoViewController.h"

@interface XWRegisterViewController ()

@end

@implementation XWRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self showBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews{
    
    UILabel *label = [RWFactionUI createLabelWith:CGRectMake(0, 0, ScreenWidth, 40) text:@"注册专项特权" textColor:[UIColor colorWithHex:@"296DD5"] textFont:[UIFont rw_regularFontSize:18] textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    
    UILabel *label1 = [RWFactionUI createLabelWith:CGRectMake(0, 0, ScreenWidth, 40) text:@"请选择注册类型 " textColor:[UIColor colorWithHex:@"999999"] textFont:[UIFont rw_regularFontSize:14] textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label1];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(110*kScaleH);
        make.left.equalTo(self.view).offset(30*kScaleW);
        make.right.equalTo(self.view).offset(-30*kScaleW);
    }];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(40*kScaleH);
        make.left.equalTo(self.view).offset(30*kScaleW);
        make.right.equalTo(self.view).offset(-30*kScaleW);
    }];
    CGFloat height = 92*kScaleH;
    CGFloat width = 519*kScaleW;
    CGFloat padding = 40*kScaleH;
    for (int i = 0; i < 3; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i+4;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"register_img%d",i+1]] forState:UIControlStateNormal];
        [btn setContentMode:UIViewContentModeScaleAspectFit];
        btn.adjustsImageWhenHighlighted = NO;
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(340*kScaleH+(height+padding)*i);
//            make.left.equalTo(self.view).offset(100*kScaleW);
//            make.right.equalTo(self.view).offset(-100*kScaleW);
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(width);
            make.centerX.equalTo(self.view);
        }];
    }
}
- (void)clickBtnAction:(UIButton *)sender{
    RegisterInfoViewController *registerVc = [[RegisterInfoViewController alloc] init];
    registerVc.type = (int)sender.tag;
    [self.navigationController pushViewController:registerVc animated:YES];
    
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
