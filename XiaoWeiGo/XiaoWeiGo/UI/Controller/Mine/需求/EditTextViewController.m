//
//  EditTextViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "EditTextViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface EditTextViewController ()<UITextViewDelegate>

@property(nonatomic, strong) UITextView *textView;

@property(nonatomic, strong) UILabel *placeHolder;

@end

@implementation EditTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"需求标题";
    
    [self showBackItem];
}
- (void)layoutSubviews{
    // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
        NSLog(@"%d : %@",i,objcName);
    }
    
    [self setupTextView];
    
    UIButton *saveBtn = [[UIButton alloc] init];
    [saveBtn setBackgroundColor:[UIColor whiteColor]];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setImage:[UIImage imageNamed:@"demand_icon_save"] forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor textBlackColor] forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:[UIFont rw_regularFontSize:15.0]];
    [saveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [self.view addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(saveAndback) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(90*kScaleH);
    }];
    CALayer *topLayer = [CALayer layer];
    topLayer.backgroundColor = [UIColor OCRMainColor].CGColor;
    topLayer.frame = CGRectMake(0, 0, ScreenWidth, 0.5);
    [saveBtn.layer addSublayer:topLayer];
}
- (void)saveAndback{
    NSLog(@"  %ld   %@",self.type,_textView.text);
    if (!IsStrEmpty(_textView.text)) {
        NSDictionary *dict = @{@"type":@(self.type),
                               @"text":_textView.text
                               };
        SendNotify(XWDemandInputNotification, dict);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
// 添加textView
- (void)setupTextView
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(30*kScaleW, 20*kScaleH, ScreenWidth-60*kScaleW, 100)];
    [textView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:textView];
    textView.delegate = self;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = self.placeholderStr;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    
    // same font
    textView.font = [UIFont systemFontOfSize:15.f];
    placeHolderLabel.font = [UIFont rw_regularFontSize:15.f];
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    self.textView = textView;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return YES;
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
