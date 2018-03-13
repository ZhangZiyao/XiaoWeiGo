//
//  XWAboutViewController.m
//  XiaoWeiGo
//
//  Created by Ziyao on 2018/2/12.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWAboutViewController.h"

@interface XWAboutViewController ()
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *copyright;
@property (nonatomic, strong) UILabel *version;
@end

@implementation XWAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于小微加油";
    [self showBackItem];
}
- (void)layoutSubviews{
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.version];
    [self.view addSubview:self.copyright];
    
    
    [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(160*kScaleH);
    }];
    [self.version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).offset(30*kScaleH);
        make.centerX.equalTo(self.logoImageView);
        
    }];
    [self.copyright mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30*kScaleH);
        make.left.equalTo(self.view).offset(20*kScaleW);
        make.right.equalTo(self.view).offset(-20*kScaleW);
    }];
}

- (UILabel *)version{
    if (!_version) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        _version = [RWFactionUI createLabelWith:CGRectMake(0, 0, ScreenWidth, 30) text:[NSString stringWithFormat:@"Version %@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]] textColor:RgbColor(102, 102, 102) textFont:[UIFont rw_mediumFontSize:12.0] textAlignment:NSTextAlignmentCenter];
        
    }
    return _version;
}
- (UILabel *)copyright{
    if (!_copyright) {
        _copyright = [RWFactionUI createLabelWith:CGRectMake(0, 0, ScreenWidth, 30) text:@"奉化区小微办 奉化区市场监管局 版权所有" textColor:RgbColor(102, 102, 102) textFont:[UIFont rw_mediumFontSize:11] textAlignment:NSTextAlignmentCenter];
        _copyright.numberOfLines = 0;
        //        _copyright.adjustsFontSizeToFitWidth = YES;
    }
    return _copyright;
}
- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"logo_xw"];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _logoImageView.layer.masksToBounds = YES;
        _logoImageView.layer.cornerRadius = 10.0;
    }
    return _logoImageView;
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
