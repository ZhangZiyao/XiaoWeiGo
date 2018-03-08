//
//  XWDemandViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWDemandViewController.h"

@interface XWDemandViewController ()

@end

@implementation XWDemandViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布需求";
    [self showBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - 获取数据列表
- (void)getDataEvaluateInfo {
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"sId":@"1"
                                             }];
    
    [manager POSTRequestUrlStr:kGetDmdList parms:params success:^(id responseData) {
        NSLog(@"获取数据  %@",responseData);
//        if ([responseData isKindOfClass:[NSArray class]]) {
//            NSArray *array = [NSArray arrayWithArray:responseData];
//            if (array.count > 0) {
//                self.evluateDataSource = [XWEvaluateModel mj_objectArrayWithKeyValuesArray:array];
//            }
//        }
//        if (self.evluateDataSource.count > 0) {
//            [self.tableView reloadData];
//        }
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
