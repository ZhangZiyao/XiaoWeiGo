//
//  XWBaseViewController.m
//  XiaoWei
//
//  Created by dingxin on 2018/1/26.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseViewController.h"
#import "XWLoginViewController.h"

@interface XWBaseViewController ()

@end

@implementation XWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = bgColor;
    
    //设置导航标题文字颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont rw_mediumFontSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //在iOS 7中，苹果引入了一个新的属性，叫做[UIViewController setEdgesForExtendedLayout:]，它的默认值为UIRectEdgeAll。当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt。
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    //设置导航栏背景色
//    [self.navigationController.navigationBar setBackgroundColor:navColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UITextField appearance] setTintColor:UIColorFromRGB16(0x999999)];
    //    设置导航栏下的阴影线
    //    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"line_h"]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //iOS11 解决SafeArea的问题，同时能解决pop时上级页面scrollView抖动的问题
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; //iOS11 解决SafeArea的问题，同时能解决pop时上级页面scrollView抖动的问题
    }
    [self layoutSubviews];
}
- (void)layoutSubviews{
    
}
- (void)showLogin{
    [MBProgressHUD alertInfo:@"请先登录～"];
    XWLoginViewController *loginVc = [[XWLoginViewController alloc] init];
    RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:loginVc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)showLeftItemWithItemImage:(NSString *)itemImage
{
    self.navigationItem.leftBarButtonItem = nil;
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 0, 65, 44);
    but.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //    [but setBackgroundImage:[UIImage imageNamed:itemImage] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:itemImage] forState:UIControlStateNormal];
    //    but.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;// 让按钮内部的所有内容左对齐
    [but addTarget:self action:@selector(navLeftItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)showRightItemWithItemImage:(NSString *)itemImage
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 0, 44, 44);
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;// 让按钮内部的所有内容右对齐
    but.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [but setImage:[UIImage imageNamed:itemImage] forState:UIControlStateNormal];
    //    [but setBackgroundImage:[UIImage imageNamed:itemImage] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(navRightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)showBackItem{
    [self showLeftItemWithItemImage:@"fanhui_white"];
}

- (void)navLeftItemClick
{
}

- (void)navRightItemClick
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc
{
    NSLog(@"dealloc ==== %@",[self class]);
    RemoveNofify;
}
@end
