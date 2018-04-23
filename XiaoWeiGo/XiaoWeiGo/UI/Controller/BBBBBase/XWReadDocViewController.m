//
//  XWReadDocViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/28.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWReadDocViewController.h"
#import "QuickLookViewController.h"
#import "XWAttachmentModel.h"

@interface XWReadDocViewController ()<UIWebViewDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>
{
    UIWebView *openFileWebView;
}
@property (nonatomic,strong)NSURL *fileURL;
@end

@implementation XWReadDocViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.attName;
    [self showBackItem];
    //    [self readDocfile];
    [self openPDF];
}
-(void)openPDF{
    NSLog(@"///////////   %@",self.urlString);
    openFileWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    openFileWebView.delegate = self;
    [openFileWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    centerBtn.backgroundColor = [UIColor orangeColor];
//    centerBtn.frame = CGRectMake(0, 0, 200, 50);
//    centerBtn.center = self.view.center;
//    [centerBtn addTarget:self action:@selector(openPDF:) forControlEvents:UIControlEventTouchUpInside];
//    [centerBtn setTitle:@"打开一个远程PDF" forState:UIControlStateNormal];
//    [self.view addSubview:centerBtn];
//
//}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
#pragma mark - Web代理
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSURL *targetURL = [NSURL URLWithString:self.urlString];
    
    NSString *docPath = [self documentsDirectoryPath];
    NSString *pathToDownloadTo = [NSString stringWithFormat:@"%@/%@", docPath, [targetURL lastPathComponent]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL hasDownLoad= [fileManager fileExistsAtPath:pathToDownloadTo];
    if (hasDownLoad) {
        self.fileURL = [NSURL fileURLWithPath:pathToDownloadTo];
        QLPreviewController *qlVC = [[QLPreviewController alloc]init];
        qlVC.delegate = self;
        qlVC.dataSource = self;
        [self.navigationController pushViewController:qlVC animated:YES];
        //
    }
    else {
        NSURL *targetURL = [NSURL URLWithString:self.urlString];
        
        NSData *fileData = [[NSData alloc] initWithContentsOfURL:targetURL];
        // Get the path to the App's Documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        [fileData writeToFile:[NSString stringWithFormat:@"%@/%@", documentsDirectory, [targetURL lastPathComponent]] atomically:YES];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [openFileWebView loadRequest:request];
    }
    
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
    
    
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.fileURL;
}

- (void)previewControllerWillDismiss:(QLPreviewController *)controller {
    NSLog(@"previewControllerWillDismiss");
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    NSLog(@"previewControllerDidDismiss");
}

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item{
    return YES;
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id <QLPreviewItem>)item inSourceView:(UIView * __nullable * __nonnull)view{
    return CGRectZero;
}

- (NSString *)documentsDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return documentsDirectoryPath;
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//- (void)readDocfile{
//    NSString * ducumentLocation = [[NSBundle mainBundle]pathForResource:@"小微加油" ofType:@"doc"];
//    NSURL *url = [NSURL fileURLWithPath:ducumentLocation];
//
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
//    webView.delegate = self;
//    webView.multipleTouchEnabled = YES;
//    webView.scalesPageToFit = YES;
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
//
//    [self.view addSubview:webView];
//    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//    }];
//}
@end
