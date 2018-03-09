//
//  XWRegisterFirStepController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWRegisterFirStepController.h"

@interface XWRegisterFirStepController ()

@end

@implementation XWRegisterFirStepController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self showBackItem];
}
- (void)layoutSubviews{
    
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
