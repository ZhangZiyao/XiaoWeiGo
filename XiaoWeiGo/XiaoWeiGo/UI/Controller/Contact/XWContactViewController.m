//
//  XWContactViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWContactViewController.h"

#define BLACK_BAR_VIEW_TAG 1000
#define DIM_VIEW_TAG 1001

@interface XWContactViewController ()
@end

@implementation XWContactViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = self.conversationModel.nickName;
    [self showBackItem];
    self.view.backgroundColor = UIColorFromRGB16(0xebebeb);
}


- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
