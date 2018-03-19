//
//  XWCompanyDetailViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWCompanyDetailViewController.h"
#import "CompanyModel.h"

@interface XWCompanyDetailViewController ()

@end

@implementation XWCompanyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"企业名录";
    [self showBackItem];
}
- (void)layoutSubviews{
    self.title = self.company.orgName;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = self.company.orgSketch;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30*kScaleW);
        make.top.equalTo(self.view).offset(30*kScaleW);
        make.right.equalTo(self.view).offset(30*kScaleW);
    }];
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = self.company.telephone;
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30*kScaleW);
        make.top.equalTo(label.mas_bottom).offset(30*kScaleW);
        make.right.equalTo(self.view).offset(30*kScaleW);
    }];
}

- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
