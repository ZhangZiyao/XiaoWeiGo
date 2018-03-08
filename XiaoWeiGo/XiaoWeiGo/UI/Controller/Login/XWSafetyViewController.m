//
//  XWSafetyViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/20.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWSafetyViewController.h"
#import "DMDropDownMenu.h"
#import "XWResetPwdViewController.h"

@interface XWSafetyViewController ()<UITextFieldDelegate,DMDropDownMenuDelegate>
{
    NSArray *qArray;
    NSString *questionStr;
}
@property (nonatomic,strong) UITextField *phoneTextField;

@end

@implementation XWSafetyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 1) {
        self.title = @"设置密保问题";
    }else{
        self.title = @"忘记密码";
    }
    [self showBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - 确认
- (void)nextStep{
    //    if ([self verification:10086] == NO) {
    //        return;
    //    }
    //    NSDictionary *params = @{@"receiver":self.phoneTextField.text,
    //                             @"verifyCode":self.codeTextField.text,
    //                             @"systemType":self.systemType,
    //                             @"loginPwd":self.pwdTextfield.text};
    //    //        WS(weakSelf);
    //    RequestManager *request = [[RequestManager alloc] init];
    //    [request POSTRequestUrlStr:[NSString stringWithFormat:@"%@%@",[RWEnvironmentManager host],ResetPassword] parms:params success:^(id responseData) {
    //        NSLog(@"成功 %@",responseData);
    //        if ([[responseData objectForKey:@"status"] boolValue]) {
    //
    //            if ([[responseData objectForKey:@"status"] boolValue]) {
    //                [MBProgressHUD alertInfo:@"密码修改成功"];
    //
    //                [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    //            }
    //        }
    //
    //    } fail:^(NSError *error) {
    //        NSLog(@"shibai  %@",error);
    //    }];
    
    XWResetPwdViewController *resetPwdvc = [[XWResetPwdViewController alloc] init];
    [self.navigationController pushViewController:resetPwdvc animated:YES];
    
}
- (void)selectIndex:(NSInteger)index AtDMDropDownMenu:(DMDropDownMenu *)dmDropDownMenu{
    questionStr = qArray[index];
}
- (void)layoutSubviews{
    
    qArray = @[@"您最喜欢的颜色是什么？",@"您父亲的姓名是什么？",@"您母亲的姓名是什么？",@"您出生年月是几月几日？"];
    questionStr = qArray[0];
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.image = [UIImage imageNamed:@"forget_reset1"];
    [self.view addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(184*kScaleH);
    }];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"回答安全提示问题";
    label.font = [UIFont rw_regularFontSize:16.0];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImageView);
        make.centerY.equalTo(headerImageView);
    }];
    
    
    DMDropDownMenu *dropDown = [[DMDropDownMenu alloc] initWithFrame:CGRectMake(35*kScaleW, (184+60)*kScaleH, ScreenWidth-70*kScaleW, 90*kScaleH)];
    dropDown.delegate = self;
    [dropDown setListArray:qArray];
    [self.view addSubview:dropDown];
    dropDown.layer.masksToBounds = YES;
    dropDown.layer.cornerRadius = 5.0;
    dropDown.layer.borderColor = LineColor.CGColor;
    dropDown.layer.borderWidth = 0.5;
    [dropDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35*kScaleW);
        make.right.equalTo(self.view).offset(-35*kScaleW);
        make.top.equalTo(headerImageView.mas_bottom).offset(60*kScaleW);
        make.height.mas_equalTo(90*kScaleH);
    }];
    UITextField *_textField = [[UITextField alloc] init];
    _textField.delegate = self;
    _textField.font = [UIFont rw_regularFontSize:15.0];
    _textField.textColor = [UIColor textBlackColor];
    _textField.layer.masksToBounds = YES;
    _textField.layer.cornerRadius = 5.0;
    _textField.layer.borderColor = LineColor.CGColor;
    _textField.layer.borderWidth = 0.5;
    _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示)
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35*kScaleW);
        make.right.equalTo(self.view).offset(-35*kScaleW);
        make.top.equalTo(dropDown.mas_bottom).offset(60*kScaleW);
        make.height.mas_equalTo(90*kScaleH);
    }];
    UIButton *nextStep = [[UIButton alloc] init];
    [nextStep setBackgroundColor:UIColorFromRGB16(0x1aa4ec)];
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) return YES;
    if ([string isEqualToString:@" "]) return NO;
    if(textField.text.length>15){
        NSString *text =textField.text;
        textField.text=[text substringToIndex:15];
    }
    if(textField.text.length==15){
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