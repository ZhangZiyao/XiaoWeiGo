//
//  XWResetPwdViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/20.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWResetPwdViewController.h"

@interface XWResetPwdViewController ()<UITextFieldDelegate>
@property (nonatomic , strong) UITextField *pwdTF;
@property (nonatomic , strong) UITextField *pwdRepeatTF;

@end

@implementation XWResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    [self showBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews{
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.image = [UIImage imageNamed:@"forget_reset2"];
    [self.view addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(184*kScaleH);
    }];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"重设新密码";
    label.font = [UIFont rw_regularFontSize:16.0];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImageView);
        make.centerY.equalTo(headerImageView);
    }];
    UITextField *_textField = [[UITextField alloc] init];
    _textField.placeholder = @"重设密码";
    _textField.delegate = self;
    _textField.font = [UIFont rw_regularFontSize:15.0];
    _textField.textColor = [UIColor textBlackColor];
    _textField.layer.masksToBounds = YES;
    _textField.layer.cornerRadius = 5.0;
    _textField.layer.borderColor = LineColor.CGColor;
    _textField.keyboardType = UIKeyboardTypeAlphabet;
    _textField.layer.borderWidth = 0.5;
    _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示)
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35*kScaleW);
        make.right.equalTo(self.view).offset(-35*kScaleW);
        make.top.equalTo(headerImageView.mas_bottom).offset(60*kScaleW);
        make.height.mas_equalTo(90*kScaleH);
    }];
    _pwdTF = _textField;
    
    UITextField *_textField1 = [[UITextField alloc] init];
    _textField1.delegate = self;
    _textField1.placeholder = @"确认重设密码";
    _textField1.font = [UIFont rw_regularFontSize:15.0];
    _textField1.textColor = [UIColor textBlackColor];
    _textField1.layer.masksToBounds = YES;
    _textField1.layer.cornerRadius = 5.0;
    _textField1.layer.borderColor = LineColor.CGColor;
    _textField1.layer.borderWidth = 0.5;
    _textField1.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示)
    _textField1.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_textField1];
    [_textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35*kScaleW);
        make.right.equalTo(self.view).offset(-35*kScaleW);
        make.top.equalTo(_textField.mas_bottom).offset(60*kScaleW);
        make.height.mas_equalTo(90*kScaleH);
    }];
    _pwdRepeatTF = _textField1;
    
    UIButton *nextStep = [[UIButton alloc] init];
    [nextStep setBackgroundColor:UIColorFromRGB16(0x1aa4ec)];
    [nextStep setTitle:@"确定" forState:UIControlStateNormal];
    nextStep.layer.masksToBounds = YES;
    nextStep.layer.cornerRadius = 5;
    [self.view addSubview:nextStep];
    [nextStep addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    
    [nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-120*kScaleH);
        make.left.equalTo(self.view).offset(35*kScaleW);
        make.right.equalTo(self.view).offset(-35*kScaleW);
        make.height.mas_equalTo(90*kScaleH);
    }];
}
- (void)nextStep{
    if (_pwdTF.text.length == 0) {
        [MBProgressHUD alertInfo:@"请输入新密码"];
        return;
    }
    if (_pwdTF.text.length < 6) {
        [MBProgressHUD alertInfo:@"密码位数至少6位"];
        return;
    }
    if (_pwdRepeatTF.text.length == 0) {
        [MBProgressHUD alertInfo:@"请确认新密码"];
        return;
    }
    if (![_pwdTF.text isEqualToString:_pwdRepeatTF.text]) {
        [MBProgressHUD alertInfo:@"两次密码输入不一致"];
        return;
    }
    NSDictionary *params = @{@"uId":APPDELEGATE.user.uId,
                             @"question":self.question,
                             @"answer":self.answer,
                             @"newPwd":_pwdTF.text
                             };
    
    [UserModel resetPwdWithParams:params block:^(BOOL success) {
        if (success) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) return YES;
    if ([string isEqualToString:@" "]) return NO;
    if(textField.text.length>20){
        NSString *text =textField.text;
        textField.text=[text substringToIndex:20];
    }
    if(textField.text.length==20){
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
