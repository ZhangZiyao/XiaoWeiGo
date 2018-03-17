//
//  XWCreditViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//
#define kGovUrl   @"http://www.gsxt.gov.cn/index.html"
#import "XWCreditViewController.h"
#import <WebKit/WebKit.h>
@interface XWCreditViewController ()
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation XWCreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用信息公示";
    [self showBackItem];
}
- (void)layoutSubviews{
    
    _wkWebView = [[WKWebView alloc] init];
    
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kGovUrl]]];
    [self.view addSubview:_wkWebView];
    [_wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    //进度条初始化
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.backgroundColor = UIColorFromRGB16(0xf5b522);
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    //self.progressView.hidden = YES;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    //self.progressView.hidden = YES;
}

- (void)navLeftItemClick{
    //    [self.navigationController popViewControllerAnimated:YES];/
    
//    NSLog(@"list %@",_wkWebView.backForwardList);
//
    NSURL *list =[_wkWebView.backForwardList itemAtIndex:0].initialURL;
    
    //webView.goBack;
    NSLog(@"%@",list);
    NSURL  *current =[_wkWebView.backForwardList currentItem].URL;//当前的URL
    NSURL *foreward = [_wkWebView.backForwardList forwardItem].URL;
    NSURL *back = [_wkWebView.backForwardList backItem].URL;//后退的URL
    NSLog(@"current=%@,foreward=%@,back=%@",current,foreward,back);
    NSArray *history = [_wkWebView.backForwardList backList];//历史记录的列表
//    循环遍历里面历史记录，根据标题返回到指定的历史记录中
//        for (WKBackForwardListItem *item in history) {
//            NSLog(@"000%@---111%@----222%@",item.URL,item.title,item.initialURL);
//            //标记  标题是我的资讯的时候，返回到指定的页面，下面是数组中的第一个元素，也就是说最先加载的一个地址
//            if ([item.title isEqualToString:@"我的资讯"]) {
//                [_webView goToBackForwardListItem:[_webView.backForwardList.backList firstObject]];
//            }
//        }
    
    if (history.count < 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [_wkWebView goToBackForwardListItem:history[history.count-1]];//跳转想对应网页的操作
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [self cleanCacheAndCookie];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    _wkWebView = nil;
}

/**清除缓存和cookie*/

- (void)cleanCacheAndCookie{
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
    
}

@end
