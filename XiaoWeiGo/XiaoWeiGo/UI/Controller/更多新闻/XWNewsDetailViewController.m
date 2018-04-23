//
//  XWNewsDetailViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWNewsDetailViewController.h"
#import "NewsModel.h"

@interface XWNewsDetailViewController ()
{
    NewsModel *newsDDModel;
}
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation XWNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = IsStrEmpty(self.model.aTitle)?@"新闻详情":self.model.aTitle;
    [self showBackItem];
    
    [self getNewsDetailInfo];
}
- (void)layoutSubviews{
//    [self.view addSubview:self.contentLabel];
//    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(100*kScaleH);
//        make.left.equalTo(self.view).offset(30*kScaleW);
//        make.right.equalTo(self.view).offset(-30*kScaleW);
//    }];
//
//    if (!IsStrEmpty(self.model.aContent)) {
//        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.aContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//        self.contentLabel.attributedText = attrStr;
//
//        self.contentLabel.font = [UIFont rw_regularFontSize:16];
//    }
    
    _webView = [[UIWebView alloc] init];
    _webView.backgroundColor = bgColor;
    [_webView loadHTMLString:self.model.aContent baseURL:nil];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = UIColorFromRGB16(0x666666);
        _contentLabel.font = [UIFont rw_regularFontSize:16];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
#pragma mark - 获取新闻内容
- (void)getNewsDetailInfo{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"aId":@(self.model.ID)//文章表ID
                                             }];//self.model.ID
    
    [manager POSTRequestUrlStr:kGetNewsInfoDetail parms:params success:^(id responseData) {
        NSLog(@"获取新闻内容  %@",responseData);
        newsDDModel = [NewsModel mj_objectWithKeyValues:responseData[0]];
        [_webView loadHTMLString:newsDDModel.aContent baseURL:nil];
    } fail:^(NSError *error) {
        
    }];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getAddServiceLink];
}
#pragma mark -   增加文章浏览量
- (void)getAddServiceLink {
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"aId":@(self.model.ID),//服务表ID
                                             @"defAdd":@"1"//增量数，传1就加1浏览量
                                             }];
    
    [manager POSTRequestUrlStr:kSetArticlePageView parms:params success:^(id responseData) {
        NSLog(@"获取数据  %@",responseData);
        //        if ([responseData[0] isEqualToString:@"success"]) {
        //
        //        }
        
    } fail:^(NSError *error) {
        
    }];
}
@end
