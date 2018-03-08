//
//  XWDisDetailViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWDisDetailViewController.h"

@interface XWDisDetailViewController ()

@end

@implementation XWDisDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠政策";
    [self showBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [imageView setImage:[UIImage imageNamed:@"discount_img"]];
//    [self.view addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.top.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//    }];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont rw_regularFontSize:17.0];
    label.textColor = [UIColor textBlackColor];
    label.numberOfLines = 0;
    NSString *string = @"“小微加油”是奉化区市场监督管理局为小微企业解决融资难、创新难等限制发展突出问题的服务平台。该项目旨在帮助企业足不出户，实现信息资源、社会资源的有效对接，帮助小微企业成长。”小微加油“2.0将在原有服务APP的基础上，增加服务项目、扩大服务范围。在“小微加油”2.0我们将引入企业电子名片二维码、用户刷脸登陆、资源信息实时推送等互联网+技术，给辖区内小微企业提供更有成效的发展协助。";
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle01.headIndent = 0.0f;//行首缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    CGFloat emptylen = label.font.pointSize * 2;
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    paraStyle01.tailIndent = 0.0f;//行尾缩进
    paraStyle01.lineSpacing = 2.0f;//行间距
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:string attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    
    label.attributedText = attrText;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30*kScaleW);
        make.right.equalTo(self.view).offset(-30*kScaleW);
        make.top.equalTo(self.view).offset(20*kScaleW);
    }];
    
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
