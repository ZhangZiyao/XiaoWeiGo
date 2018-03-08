//
//  XWLoginViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWLoginViewController.h"
#import "XWRegisterViewController.h"
#import "XWForgetViewController.h"

@interface XWLoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *userNameTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@end

@implementation XWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self showBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews{
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction)];
    rightBtnItem.tag = 3030;
    [rightBtnItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                          [UIFont systemFontOfSize:15.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.image = [UIImage imageNamed:@"login_icon_logo"];
    [self.view addSubview:iconImage];
    
    UIImageView *iconImage1 = [[UIImageView alloc] init];
    iconImage1.image = [UIImage imageNamed:@"login_text"];
    iconImage1.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconImage1];
    
    UIView *subview1 = [self xinitTextFieldViewWithImageName:@"login_icon_user" placeHolder:@"用户名" tag:10086];
    UIView *subview2 = [self xinitTextFieldViewWithImageName:@"login_icon_password" placeHolder:@"密码" tag:10010];
    
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setTitle:@"登录" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont rw_mediumFontSize:17];
    [submitBtn setBackgroundColor:UIColorFromRGB16(0x1aa4ec)];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    [self.view addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(203*kScaleW, 203*kScaleW));
        make.top.equalTo(self.view).offset(150*kScaleH+20);
    }];
    [iconImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).offset(90*kScaleW);
        make.right.equalTo(self.view).offset(-90*kScaleW);
        make.top.equalTo(iconImage.mas_bottom).offset(40*kScaleH);
    }];
    [subview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(90*kScaleH);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(iconImage1.mas_bottom).offset(60*kScaleH);
    }];
    [subview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(90*kScaleH);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(subview1.mas_bottom).offset(10*kScaleH);
    }];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(90*kScaleH);
        make.top.equalTo(subview2.mas_bottom).offset(40*kScaleH);
        make.left.equalTo(self.view).offset(35*kScaleW);
        make.right.equalTo(self.view).offset(-35*kScaleW);
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor lineColor];
    [self.view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subview1.mas_bottom);
        make.left.equalTo(self.view).offset(35*kScaleW);
        make.right.equalTo(self.view).offset(-35*kScaleW);
        make.height.mas_equalTo(0.5);
    }];
    UILabel *line2 = [[UILabel alloc] init];
    line2.backgroundColor = [UIColor lineColor];
    [subview2 addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(subview2.mas_bottom);
        make.left.equalTo(self.view).offset(35*kScaleW);
        make.right.equalTo(self.view).offset(-35*kScaleW);
        make.height.mas_equalTo(0.5);
    }];
    UIButton *forgetBtn = [[UIButton alloc] init];
    [forgetBtn setTitle:@"忘记密码,请点击此处重置" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:UIColorFromRGB16(0x1e85da) forState:UIControlStateNormal];
    [forgetBtn.titleLabel setFont:[UIFont rw_regularFontSize:14]];
    forgetBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:forgetBtn];
    [forgetBtn addTarget:self action:@selector(pushToForget) forControlEvents:UIControlEventTouchUpInside];

    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40*kScaleH);
        make.right.equalTo(submitBtn);
//        make.width.mas_equalTo(150*kScaleW);
        make.top.equalTo(submitBtn.mas_bottom).offset(20*kScaleH);
    }];
}
#pragma mark - 点击登录按钮
- (void)submitLogin{
    
    [self closeKeyboard];
    
    if ([self Verification] == YES) {
        NSDictionary *params = @{@"name":_userNameTextField.text,
                                 @"pwd":_passwordTextField.text};
        //        WS(weakSelf);
        [UserModel loginWithParams:params block:^(BOOL isLogin) {
            if (isLogin) {
                [USER_DEFAULT setObject:_userNameTextField.text forKey:USERLOGINNAMEKEY];
//                [RWCache put:@"_useraccount" value:_userNameTextField.text];
                EMError *error = [[EMClient sharedClient] loginWithUsername:_userNameTextField.text password:_userNameTextField.text];
                if (!error) {
                    NSLog(@"登录成功");
                }
                SendNotify(XWLoginSuccessNotification, nil);
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
        }];
    }
}

- (BOOL)Verification{
    
    if ([NSString isEmpty:self.userNameTextField.text]) {
        [MBProgressHUD alertInfo:@"请输入用户名"];
        return NO;
    }
    if (![self.userNameTextField.text isUserName]) {
        [MBProgressHUD alertInfo:@"用户名格式不正确"];
        return NO;
    }
    if ([NSString isEmpty:self.passwordTextField.text] ) {
        [MBProgressHUD alertInfo:@"请输入密码"];
        return NO;
    }
    if ([self.passwordTextField.text length] < 6 ) {
        [MBProgressHUD alertInfo:@"密码不能小于6位"];
        return NO;
    }
    
    return YES;
}
#pragma mark - 忘记密码
- (void)pushToForget{
    XWForgetViewController *forgetPwdVc = [[XWForgetViewController alloc] init];
    forgetPwdVc.type = 2;
    [self.navigationController pushViewController:forgetPwdVc animated:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) return YES;
    if ([string isEqualToString:@" "]) return NO;
    if (textField == _userNameTextField) {
        if(textField.text.length>20){
            NSString *text =textField.text;
            textField.text=[text substringToIndex:20];
        }
        if(textField.text.length==20){
            [_userNameTextField resignFirstResponder];
        }
    }
    if (textField == _passwordTextField) {
        if(textField.text.length>20){
            NSString *text =textField.text;
            textField.text=[text substringToIndex:20];
            
        }
        if(textField.text.length==20){
            [_passwordTextField resignFirstResponder];
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _userNameTextField) {
        return [_passwordTextField becomeFirstResponder];
    }else{
        return [textField resignFirstResponder];
    }
}
- (UIView *)xinitTextFieldViewWithImageName:(NSString *)image placeHolder:(NSString *)placeHolder tag:(int)tag{
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    //    subview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:subview];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:image];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [subview addSubview:icon];
    
    UITextField *textfield = [RWTextField initTextFieldWithPlaceHolder:placeHolder keyboardType:UIKeyboardTypeASCIICapable];
    textfield.delegate = self;
    [subview addSubview:textfield];
    textfield.tag = tag;
        if (tag == 10086) {
        textfield.returnKeyType = UIReturnKeyNext;
        _userNameTextField = [[UITextField alloc] init];
        _userNameTextField = textfield;
    }else if (tag == 10010){
        textfield.secureTextEntry = YES;
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField = textfield;
    }
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subview).offset(60*kScaleW);
        make.bottom.equalTo(subview).offset(-15*kScaleH);
        make.size.mas_equalTo(CGSizeMake(30*kScaleW, 30*kScaleW));
    }];
    
    [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(10*kScaleW);
        make.right.equalTo(subview).offset(-40*kScaleW);
        make.height.mas_equalTo(60*kScaleH);
        make.centerY.equalTo(icon);
    }];
    return subview;
}
- (void)registerAction{
    XWRegisterViewController *registerVc = [[XWRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
}
- (void)closeKeyboard
{
    [self.passwordTextField resignFirstResponder];
    [self.userNameTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)navLeftItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
