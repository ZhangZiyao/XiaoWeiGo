//
//  XWReadDocViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/28.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWReadDocViewController.h"

@interface XWReadDocViewController ()<UIWebViewDelegate>

@end

@implementation XWReadDocViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小微加油";
    [self showBackItem];
    [self readDocfile];
}
- (void)readDocfile{
    NSString * ducumentLocation = [[NSBundle mainBundle]pathForResource:@"小微加油" ofType:@"doc"];
    NSURL *url = [NSURL fileURLWithPath:ducumentLocation];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.delegate = self;
    webView.multipleTouchEnabled = YES;
    webView.scalesPageToFit = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
