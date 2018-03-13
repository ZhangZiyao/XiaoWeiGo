//
//  XWRegisterSecStepController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWRegisterSecStepController.h"
#import "XWTextFieldCell.h"
#import "RegisterModel.h"
#import "XWButtonViewCell.h"
#import "XWLabelViewCell.h"
#import "XWTextFieldViewCell.h"

@interface XWRegisterSecStepController ()
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) RegisterModel *registerModel;
@property (nonatomic, strong) UIView *footerView;
@end

@implementation XWRegisterSecStepController
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}
- (void)initializeForm{
    //    [self addSection0];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _registerModel = [[RegisterModel alloc] init];
    self.title = @"注册";
    [self showBackItem];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
//- (void)addSection2{
//    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptor];
//    self.form = formDescriptor;
//    XLFormSectionDescriptor * section;
//    XLFormRowDescriptor * row;
//
//    WS(weakSelf);
//    // 基本信息 Section
//    section = [XLFormSectionDescriptor formSection];
//    // 账号 1-50
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterAccountTF rowType:XLFormRowDescriptorTypeAccount title:@"＊"];
//    row.cellClass = [XWTextFieldCell class];
//    row.textFieldMaxNumberOfCharacters = @20;
//    [row.cellConfigAtConfigure setObject:@"请输入账号" forKey:@"textField.placeholder"];
//    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
//        if (newValue) {
//            weakSelf.registerModel.name = [NSString stringWithFormat:@"%@",newValue];
//        }else{
//            weakSelf.registerModel.name = nil;
//        }
//    };
//    row.required = YES;
//    [section addFormRow:row];
//
//    // 密码 2-50
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterPasswordTF rowType:XLFormRowDescriptorTypePassword title:@"＊"];
//    row.cellClass = [XWTextFieldCell class];
//    row.textFieldMaxNumberOfCharacters = @20;
//    [row.cellConfigAtConfigure setObject:@"请输入密码" forKey:@"textField.placeholder"];
//    row.required = YES;
//    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
//        if (newValue) {
//            weakSelf.registerModel.pwd = [NSString stringWithFormat:@"%@",newValue];
//        }else{
//            weakSelf.registerModel.pwd = nil;
//        }
//    };
//    [section addFormRow:row];
//    // 密码 2-10
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterRePasswordTF rowType:XLFormRowDescriptorTypePassword title:@"＊"];
//    row.cellClass = [XWTextFieldCell class];
//    row.textFieldMaxNumberOfCharacters = @20;
//    [row.cellConfigAtConfigure setObject:@"请再次输入密码" forKey:@"textField.placeholder"];
//    row.required = YES;
//    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
//        if (newValue) {
//            weakSelf.registerModel.confirmPwd = [NSString stringWithFormat:@"%@",newValue];
//        }else{
//            weakSelf.registerModel.confirmPwd = nil;
//        }
//    };
//    [section addFormRow:row];
//
//    // 联系人 5-50
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterLinkManTF rowType:XLFormRowDescriptorTypeText title:@"＊"];
//    row.cellClass = [XWTextFieldCell class];
//    row.textFieldMaxNumberOfCharacters = @20;
//    [row.cellConfigAtConfigure setObject:@"请输入联系人" forKey:@"textField.placeholder"];
//    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
//    row.required = YES;
//    [row addValidator:[XLFormValidator emailValidator]];
//    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
//        if (newValue) {
//            weakSelf.registerModel.contact = [NSString stringWithFormat:@"%@",newValue];
//        }else{
//            weakSelf.registerModel.contact = nil;
//        }
//    };
//    [section addFormRow:row];
//
//    // 手机 2-100
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterMobileTF rowType:XLFormRowDescriptorTypePhone title:@"＊"];
//    row.cellClass = [XWTextFieldCell class];
//    row.textFieldMaxNumberOfCharacters = @13;
//    [row.cellConfigAtConfigure setObject:@"请输入手机" forKey:@"textField.placeholder"];
//    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
//    row.required = YES;
//    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
//        if (newValue) {
//            weakSelf.registerModel.mobile = [NSString stringWithFormat:@"%@",newValue];
//        }else{
//            weakSelf.registerModel.mobile = nil;
//        }
//    };
//    [section addFormRow:row];
//
//    [self.form addFormSection:section];
//    NSLog(@"%@",self.form.formSections);
//}
- (void)addSection0{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptor];
    self.form = formDescriptor;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    section = [XLFormSectionDescriptor formSection];
    //
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"CODE" rowType:XLFormRowDescriptorTypeAccount title:@"统一社会信用代码"];
    row.cellClass = [XWLabelViewCell class];
    row.value = [self.dict objectForKey:@"code"];
    [section addFormRow:row];
    //
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"REGISTERCODE" rowType:XLFormRowDescriptorTypeAccount title:@"企业注册号"];
    row.cellClass = [XWLabelViewCell class];
    row.value = [self.dict objectForKey:@"rcode"];
    [section addFormRow:row];
    //
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"NAME" rowType:XLFormRowDescriptorTypeAccount title:@"企业名称"];
    row.cellClass = [XWLabelViewCell class];
    row.value = [self.dict objectForKey:@"name"];
    [section addFormRow:row];
    //
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Time" rowType:XLFormRowDescriptorTypeAccount title:@"登记时间"];
    row.cellClass = [XWLabelViewCell class];
    row.value = [self.dict objectForKey:@"rtime"];
    [section addFormRow:row];
    //
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"FANWEI" rowType:XLFormRowDescriptorTypeAccount title:@"经营范围"];
    row.cellClass = [XWLabelViewCell class];
    row.value = [self.dict objectForKey:@"fanwei"];
    [section addFormRow:row];
    
    [self.form addFormSection:section];
    NSLog(@"%@",self.form.formSections);
    
    [self addSection1];
}
- (void)addSection1{
    XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@"服务类别"];
    XLFormRowDescriptor * row;
    WS(weakSelf);
    // 基本信息 Section
    section = [XLFormSectionDescriptor formSection];
    // 账号 1-50
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterAccountTF rowType:XLFormRowDescriptorTypeAccount title:@"工商登记预留电话"];
    row.cellClass = [XWTextFieldViewCell class];
    row.textFieldMaxNumberOfCharacters = @11;
    [row.cellConfigAtConfigure setObject:@"请输入电话" forKey:@"textField.placeholder"];
    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        if (newValue) {
            weakSelf.registerModel.name = [NSString stringWithFormat:@"%@",newValue];
        }else{
            weakSelf.registerModel.name = nil;
        }
    };
    row.required = YES;
    [section addFormRow:row];
    
    [self.form addFormSection:section];
    NSLog(@"%@",self.form.formSections);
    
    [self addSection2];
}
- (void)addSection2{
    XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@"服务类别"];
    XLFormRowDescriptor * row;
    WS(weakSelf);
    // 基本信息 Section
    section = [XLFormSectionDescriptor formSection];
    // 账号 1-50
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterAccountTF rowType:XLFormRowDescriptorTypeAccount title:@"＊"];
    row.cellClass = [XWTextFieldCell class];
    row.textFieldMaxNumberOfCharacters = @20;
    [row.cellConfigAtConfigure setObject:@"请输入账号" forKey:@"textField.placeholder"];
    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        if (newValue) {
            weakSelf.registerModel.name = [NSString stringWithFormat:@"%@",newValue];
        }else{
            weakSelf.registerModel.name = nil;
        }
    };
    row.required = YES;
    [section addFormRow:row];
    
    // 密码 2-50
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterPasswordTF rowType:XLFormRowDescriptorTypePassword title:@"＊"];
    row.cellClass = [XWTextFieldCell class];
    row.textFieldMaxNumberOfCharacters = @20;
    [row.cellConfigAtConfigure setObject:@"请输入密码" forKey:@"textField.placeholder"];
    row.required = YES;
    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        if (newValue) {
            weakSelf.registerModel.pwd = [NSString stringWithFormat:@"%@",newValue];
        }else{
            weakSelf.registerModel.pwd = nil;
        }
    };
    [section addFormRow:row];
    // 密码 2-10
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterRePasswordTF rowType:XLFormRowDescriptorTypePassword title:@"＊"];
    row.cellClass = [XWTextFieldCell class];
    row.textFieldMaxNumberOfCharacters = @20;
    [row.cellConfigAtConfigure setObject:@"请再次输入密码" forKey:@"textField.placeholder"];
    row.required = YES;
    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        if (newValue) {
            weakSelf.registerModel.confirmPwd = [NSString stringWithFormat:@"%@",newValue];
        }else{
            weakSelf.registerModel.confirmPwd = nil;
        }
    };
    [section addFormRow:row];
    
    // 联系人 5-50
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterLinkManTF rowType:XLFormRowDescriptorTypeText title:@"＊"];
    row.cellClass = [XWTextFieldCell class];
    row.textFieldMaxNumberOfCharacters = @20;
    [row.cellConfigAtConfigure setObject:@"请输入联系人" forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    row.required = YES;
    [row addValidator:[XLFormValidator emailValidator]];
    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        if (newValue) {
            weakSelf.registerModel.contact = [NSString stringWithFormat:@"%@",newValue];
        }else{
            weakSelf.registerModel.contact = nil;
        }
    };
    [section addFormRow:row];
    // 邮箱 2-100
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterEmailTF rowType:XLFormRowDescriptorTypeEmail title:@"  "];
    row.cellClass = [XWTextFieldCell class];
    row.textFieldMaxNumberOfCharacters = @30;
    [row.cellConfigAtConfigure setObject:@"请输入邮箱" forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    row.required = YES;
    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        if (newValue) {
            weakSelf.registerModel.email = [NSString stringWithFormat:@"%@",newValue];
        }else{
            weakSelf.registerModel.email = nil;
        }
    };
    [section addFormRow:row];
    // 手机 2-100
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterMobileTF rowType:XLFormRowDescriptorTypePhone title:@"＊"];
    row.cellClass = [XWTextFieldCell class];
    row.textFieldMaxNumberOfCharacters = @13;
    [row.cellConfigAtConfigure setObject:@"请输入手机" forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    row.required = YES;
    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        if (newValue) {
            weakSelf.registerModel.mobile = [NSString stringWithFormat:@"%@",newValue];
        }else{
            weakSelf.registerModel.mobile = nil;
        }
    };
    [section addFormRow:row];
    // 固定电话 2-100
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterMobileTF rowType:XLFormRowDescriptorTypeAccount title:@"  "];
    row.cellClass = [XWTextFieldCell class];
    row.textFieldMaxNumberOfCharacters = @13;
    [row.cellConfigAtConfigure setObject:@"请输入固定电话xxxx-xxxxxxxx" forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    row.required = YES;
    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
        if (newValue) {
            weakSelf.registerModel.telephone = [NSString stringWithFormat:@"%@",newValue];
        }else{
            weakSelf.registerModel.telephone = nil;
        }
    };
    [section addFormRow:row];
    
    [self.form addFormSection:section];
    [self addSection3];
}
- (void)addSection3{
    XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@"服务类别"];
    XLFormRowDescriptor * row;
    
    NSArray *array = @[@"我要贷款",@"创业创新",@"知识产权",@"共享会计",@"法律服务",@"优惠政策",@"ISO认证",@"展会服务",@"工商注册",@"其他服务"];
    for (int i = 0; i < array.count; i ++) {
        row = [XLFormRowDescriptor formRowDescriptorWithTag:[NSString stringWithFormat:@"tag%d",i] rowType:XLFormRowDescriptorTypeText title:array[i]];
        row.cellClass = [XWButtonViewCell class];
        row.value = @(NO);
        [section addFormRow:row];
    }
    
    [self.form addFormSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 4) {
        XLFormRowDescriptor *row = [self.form formRowWithTag:@"FANWEI"];
        XWLabelViewCell *cell = (XWLabelViewCell *)[row cellForFormController:self.form];
        return cell.cellHeight;
    }
    return 100*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1 || section == 2) {
        return 8.0f;
    }else{
        return 70*kScaleH;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.type==6) {
        //一般用户
        return 450*kScaleH;
    }else{
        if (section==3){
            return 250*kScaleH;
        }else{
            return 0.01f;
        }
    }
    //    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc] init];
    if (section == 3) {
        footer = self.footerView;
    }
    return footer;
}
- (UIView *)footerView{
    if (!_footerView) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250*kScaleH)];
        UIButton *commitBtn = [RWFactionUI createButtonWith:CGRectMake(20*kScaleW, 40*kScaleH, ScreenWidth-40*kScaleW, 85*kScaleH) title:@"提  交" backgroundImage:nil textColor:[UIColor whiteColor] target:self selector:@selector(commitRegisterRequest)];
        [commitBtn.titleLabel setFont:[UIFont rw_regularFontSize:16]];
        commitBtn.layer.cornerRadius = 5;
        commitBtn.layer.masksToBounds = YES;
        [commitBtn setBackgroundColor:[UIColor colorWithHex:@"3b78d8"]];
        [footer addSubview:commitBtn];
        UIButton *backbtn = [RWFactionUI createButtonWith:CGRectMake(20*kScaleW, 145*kScaleH, ScreenWidth-40*kScaleW, 85*kScaleH) title:@"返  回" backgroundImage:nil textColor:[UIColor whiteColor] target:self selector:@selector(navLeftItemClick)];
        [backbtn setBackgroundColor:[UIColor colorWithHex:@"f54a48"]];
        [backbtn.titleLabel setFont:[UIFont rw_regularFontSize:16]];
        backbtn.layer.cornerRadius = 5;
        backbtn.layer.masksToBounds = YES;
        [footer addSubview:backbtn];
        
        [backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footer).offset(20*kScaleW);
            make.right.equalTo(footer).offset(-20*kScaleW);
            make.bottom.equalTo(footer).offset(-20*kScaleW);
            make.height.mas_equalTo(85*kScaleH);
        }];
        [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footer).offset(20*kScaleW);
            make.right.equalTo(footer).offset(-20*kScaleW);
            make.bottom.equalTo(backbtn.mas_top).offset(-20*kScaleW);
            make.height.mas_equalTo(85*kScaleH);
        }];
        _footerView = footer;
    }
    return _footerView;
}
#pragma mark - 提交注册请求
- (void)commitRegisterRequest{
    if ([self verification] == YES) {
        
        //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *url;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if (self.type == 6) {
            url = kRegisterGeneralUser;
            [params setValuesForKeysWithDictionary:@{@"name":_registerModel.name,
                                                     @"pwd":_registerModel.pwd,
                                                     @"confirmPwd":_registerModel.confirmPwd,
                                                     @"contact":_registerModel.contact,
                                                     @"mobile":_registerModel.mobile
                                                     }];
        }else{
            url = kRegisterUser;
            [params setValuesForKeysWithDictionary:@{@"name":_registerModel.name,
                                                     @"pwd":_registerModel.pwd,
                                                     @"confirmPwd":_registerModel.confirmPwd,
                                                     @"contact":_registerModel.contact,
                                                     @"mobile":_registerModel.mobile,
                                                     @"orgName":_registerModel.orgName,
                                                     @"orgType":_registerModel.orgType,
                                                     @"orgCode":_registerModel.orgCode,
                                                     @"email":_registerModel.email,
                                                     @"telephone":_registerModel.telephone,
                                                     @"uType":self.type==4?@(2):@(1)//用户类型(1:企业服务商,2:小薇企业)
                                                     }];
            if (_typeArray.count > 0) {
                [params setObject:_typeArray forKey:@"sTypeArr"];
            }
        }
        [RegisterModel registWithUrl:url params:params block:^(BOOL success) {
            if (success) {
                //                [self.navigationController popToRootViewControllerAnimated:YES];
//                XWForgetViewController *forgetPwdVc = [[XWForgetViewController alloc] init];
//                forgetPwdVc.type = 1;
//                [self.navigationController pushViewController:forgetPwdVc animated:YES];
            }
        }];
    }
}
#pragma mark - 数据验证
- (BOOL)verification{
    
    if (IsStrEmpty(_registerModel.name)) {
        [MBProgressHUD alertInfo:@"请输入账号"];
        return NO;
    }
    if (IsStrEmpty(_registerModel.pwd)) {
        [MBProgressHUD alertInfo:@"请输入密码"];
        return NO;
    }
    if (IsStrEmpty(_registerModel.confirmPwd)) {
        [MBProgressHUD alertInfo:@"请再次输入密码"];
        return NO;
    }
    if (![_registerModel.pwd isEqualToString:_registerModel.confirmPwd]) {
        [MBProgressHUD alertInfo:@"两次输入密码不一致"];
        return NO;
    }
    
    if (self.type == 6) {
        //一般
        if (IsStrEmpty(_registerModel.contact)) {
            [MBProgressHUD alertInfo:@"请输入联系人"];
            return NO;
        }
        if (IsStrEmpty(_registerModel.mobile)) {
            [MBProgressHUD alertInfo:@"请输入手机号"];
            return NO;
        }
        if (![NSString valiMobileNum:_registerModel.mobile]) {
            [MBProgressHUD alertInfo:@"手机号格式不正确"];
            return NO;
        }
        
    }else{
        if (IsStrEmpty(_registerModel.orgName)) {
            [MBProgressHUD alertInfo:@"请输入公司名称"];
            return NO;
        }
        if (IsStrEmpty(_registerModel.orgType)) {
            [MBProgressHUD alertInfo:@"请输入公司性质"];
            return NO;
        }
        if (IsStrEmpty(_registerModel.orgCode)) {
            [MBProgressHUD alertInfo:@"请输入组织机构代码证号"];
            return NO;
        }
        if (IsStrEmpty(_registerModel.contact)) {
            [MBProgressHUD alertInfo:@"请输入联系人"];
            return NO;
        }
        if (IsStrEmpty(_registerModel.email)) {
            [MBProgressHUD alertInfo:@"请输入邮箱"];
            return NO;
        }
        if (![_registerModel.email isEmailAddress]) {
            [MBProgressHUD alertInfo:@"邮箱格式不正确"];
            return NO;
        }
        if (IsStrEmpty(_registerModel.mobile)) {
            [MBProgressHUD alertInfo:@"请输入手机号"];
            return NO;
        }
        if (![NSString valiMobileNum:_registerModel.mobile]) {
            [MBProgressHUD alertInfo:@"手机号格式不正确"];
            return NO;
        }
        if (IsStrEmpty(_registerModel.telephone)) {
            [MBProgressHUD alertInfo:@"请输入固定电话"];
            return NO;
        }
        if (![NSString valiServiceMobileNum:_registerModel.telephone]) {
            [MBProgressHUD alertInfo:@"固定电话格式不正确"];
            return NO;
        }
        
        NSMutableArray *arrayP = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            NSString *tag = [NSString stringWithFormat:@"tag%d",i];
            XLFormRowDescriptor *feeRow = [self.form formRowWithTag:tag];
            if (feeRow.value) {
                [arrayP addObject:[NSString stringWithFormat:@"%i",i+1]];
            }
        }
        
        if (arrayP.count > 0) {
            _typeArray = [NSMutableArray arrayWithArray:arrayP];
        }
        
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    RWTextField *field = (RWTextField *)textField;
    if (IsStrEmpty(field.tagString)) {
        return;
    }
    NSString *string = field.text;
    //    if (string.length > 0) {
    if ([field.tagString isEqualToString:XWRegisterAccountTF]) {//2-50
        if (string.length < 1 ) {
            return;
        }
        if (string.length < 2 ) {
            [MBProgressHUD alertInfo:@"账号至少2个字符"];
            return;
        }
    }
    if ([field.tagString isEqualToString:XWRegisterPasswordTF]) {//2-50
        if (string.length < 1 ) {
            return;
        }
        if (string.length < 6 ) {
            [MBProgressHUD alertInfo:@"密码至少6个字符"];
            return;
        }
        if (!IsStrEmpty(_registerModel.confirmPwd)) {
            if (![_registerModel.confirmPwd isEqualToString:string]) {
                [MBProgressHUD alertInfo:@"两次密码输入不一致"];
                return;
            }
        }
    }
    if ([field.tagString isEqualToString:XWRegisterRePasswordTF]) {//2-50
        if (string.length < 1 ) {
            return;
        }
        if (string.length < 6 ) {
            [MBProgressHUD alertInfo:@"密码至少6个字符"];
            return;
        }
        if (!IsStrEmpty(_registerModel.pwd)) {
            if (![_registerModel.pwd isEqualToString:string]) {
                [MBProgressHUD alertInfo:@"两次密码输入不一致"];
                return;
            }
        }
    }
    if ([field.tagString isEqualToString:XWRegisterLinkManTF]) {//2-50
        if (string.length < 1 ) {
            return;
        }
        if (string.length < 2 ) {
            [MBProgressHUD alertInfo:@"联系人至少2个字符"];
            return;
        }
    }
    if ([field.tagString isEqualToString:XWRegisterMobileTF]) {//2-50
        if (string.length < 1 ) {
            return;
        }
        if (![NSString valiMobileNum:_registerModel.mobile]) {
            [MBProgressHUD alertInfo:@"手机号格式不正确"];
            return;
        }
    }
    if ([field.tagString isEqualToString:XWRegisterEmailTF]) {//2-50
        if (string.length < 1 ) {
            return;
        }
        if (![string isEmailAddress]) {
            [MBProgressHUD alertInfo:@"邮箱格式不正确"];
            return;
        }
    }
    if ([field.tagString isEqualToString:XWRegisterOrgCodeTF]) {//2-50
        if (string.length < 1 ) {
            return;
        }
        if (string.length < 2 ) {
            [MBProgressHUD alertInfo:@"组织机构代码证号至少2个字符"];
            return;
        }
    }
    if ([field.tagString isEqualToString:XWRegisterCompanyNameTF]) {//2-50
        if (string.length < 1 ) {
            return;
        }
        if (string.length < 2 ) {
            [MBProgressHUD alertInfo:@"公司名称至少2个字符"];
            return;
        }
    }
    if ([field.tagString isEqualToString:XWRegisterCompanyNatureTF]) {//2-50
        if (string.length < 1 ) {
            return;
        }
        if (string.length < 2 ) {
            [MBProgressHUD alertInfo:@"公司性质至少2个字符"];
            return;
        }
    }
    if ([field.tagString isEqualToString:XWRegisterPhoneTF]) {//2-50
        if (string.length < 1 ) {
            return;
        }
        if (![NSString valiServiceMobileNum:string]) {
            [MBProgressHUD alertInfo:@"客服电话格式不正确"];
            return;
        }
    }
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)layoutSubviews{
//    if (self.type == 6) {
//        [self addSection2];
//    }else{
        [self addSection0];
//    }
    self.automaticallyAdjustsScrollViewInsets = YES;
    //    self.tableView.tableFooterView = self.footerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
