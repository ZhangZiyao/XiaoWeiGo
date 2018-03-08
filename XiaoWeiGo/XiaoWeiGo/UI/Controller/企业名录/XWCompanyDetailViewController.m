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
#pragma mark -   增加机构服务点赞数量/浏览量
- (void)getAddServiceLink {
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"sId":@"0",//服务表ID
                                             @"defAdd":@"1"//增量数，传1就加1浏览量
                                             }];
    
    [manager POSTRequestUrlStr:kSetServiceLink parms:params success:^(id responseData) {
        NSLog(@"获取数据  %@",responseData);
        if ([responseData[0] isEqualToString:@"success"]) {
            
        }
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
