//
//  XWOtherSeviceController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWOtherSeviceController.h"

@interface XWOtherSeviceController ()

@end

@implementation XWOtherSeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"其他服务";
    [self showBackItem];
    NSDictionary *dict = @{@"title":@"其他服务",@"topImage":@"other_img_banner",@"images":@[@"other_icon_nav1",@"other_icon_nav2",@"other_icon_nav3"]};
    [self loadHeadView:dict];
    
    [self loadTableViewWithData:@"10" type:HHShowPictureCellType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
