//
//  XWEditUserInfoViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/12.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWEditUserInfoViewController.h"

@interface XWEditUserInfoViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation XWEditUserInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"个人信息";
    [self showBackItem];
    
    self.textField.placeholder = @"请填写内容...";
}
- (void)layoutSubviews{
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(updateUserInfo)];
    rightBtnItem.tag = 3030;
    [rightBtnItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                          [UIFont systemFontOfSize:15.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30*kScaleW);
        make.right.equalTo(self.view).offset(-30*kScaleW);
        make.top.equalTo(self.view).offset(40*kScaleW);
        make.height.mas_equalTo(45.0);
    }];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text) {
        
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}
- (void)updateUserInfo{
    if (IsStrEmpty(self.textField.text)) {
        return;
    }
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"uId":[USER_DEFAULT objectForKey:USERIDKEY],
                                             @"loginType":@(APPDELEGATE.user.loginType),
                                             @"name":IsStrEmpty(APPDELEGATE.user.name)?@"":APPDELEGATE.user.name,
                                             @"address":IsStrEmpty(APPDELEGATE.user.address)?@"":APPDELEGATE.user.address,
                                             @"tel":IsStrEmpty(APPDELEGATE.user.tel)?@"":APPDELEGATE.user.tel,
                                             @"email":IsStrEmpty(APPDELEGATE.user.email)?@"":APPDELEGATE.user.email,
                                             @"worktel":IsStrEmpty(APPDELEGATE.user.worktel)?@"":APPDELEGATE.user.worktel,
                                             @"remark":IsStrEmpty(APPDELEGATE.user.remark)?@"":APPDELEGATE.user.remark,
                                             @"tradeCode":IsStrEmpty(APPDELEGATE.user.tradeCode)?@"":APPDELEGATE.user.tradeCode,
                                             @"regOrg":IsStrEmpty(APPDELEGATE.user.regOrg)?@"":APPDELEGATE.user.regOrg,
                                             @"regDate":IsStrEmpty(APPDELEGATE.user.regDate)?@"":APPDELEGATE.user.regDate,
                                             @"regCapital":IsStrEmpty(APPDELEGATE.user.regCapital)?@"":APPDELEGATE.user.regCapital,
                                             @"orgType":IsStrEmpty(APPDELEGATE.user.orgType)?@"":APPDELEGATE.user.orgType,
                                             }];
    [params setObject:self.textField.text forKey:self.keyType];
    [manager POSTRequestUrlStr:kUpdateUserInfo parms:params success:^(id responseData) {
        NSLog(@"修改个人信息  %@",responseData);
        if ([responseData[0] isEqualToString:@"success"]) {
            [MBProgressHUD alertInfo:@"修改成功"];
            SendNotify(XWUserInfoChangeNotification, nil);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD alertInfo:responseData[0]];
        }
    } fail:^(NSError *error) {
    }];
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.textColor = [UIColor textBlackColor];
        _textField.layer.cornerRadius = 5.0;
        _textField.font = [UIFont rw_regularFontSize:15.0];
        _textField.layer.masksToBounds = YES;
        
    }
    return _textField;
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
