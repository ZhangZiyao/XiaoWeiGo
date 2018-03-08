//
//  XWApplyLoanViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWApplyLoanViewController.h"
#import "XWTextTableViewCell.h"
#import "XWServiceModel.h"

@interface XWApplyLoanViewController ()

@end

@implementation XWApplyLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要申请";
    [self showBackItem];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)addSection0{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptor];
    self.form = formDescriptor;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    WS(weakSelf);
    // 基本信息 Section
    section = [XLFormSectionDescriptor formSection];
    // 姓名 1-50
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterAccountTF rowType:XLFormRowDescriptorTypeText title:@"姓名"];
    row.cellClass = [XWTextTableViewCell class];
    row.textFieldMaxNumberOfCharacters = @20;
    row.editable = NO;
    row.value = IsStrEmpty(APPDELEGATE.user.name)?@"姓名":APPDELEGATE.user.name;
    
//    [row.cellConfigAtConfigure setObject:@"请输入姓名" forKey:@"textField.placeholder"];
//    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
//        if (newValue) {
////            weakSelf.registerModel.name = [NSString stringWithFormat:@"%@",newValue];
//        }else{
////            weakSelf.registerModel.name = nil;
//        }
//    };
//    row.required = YES;
    [section addFormRow:row];
    
    // 身份证 2-50
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterPasswordTF rowType:XLFormRowDescriptorTypeAccount title:@"身份证"];
    row.cellClass = [XWTextTableViewCell class];
    row.textFieldMaxNumberOfCharacters = @20;
    row.value = IsStrEmpty(APPDELEGATE.user.tel)?@"身份证":APPDELEGATE.user.tel;
    row.editable = NO;
//    [row.cellConfigAtConfigure setObject:@"请输入身份证号码" forKey:@"textField.placeholder"];
//    row.required = YES;
//    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
//        if (newValue) {
////            weakSelf.registerModel.pwd = [NSString stringWithFormat:@"%@",newValue];
//        }else{
////            weakSelf.registerModel.pwd = nil;
//        }
//    };
    [section addFormRow:row];
    // 固定电话 2-100
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterMobileTF rowType:XLFormRowDescriptorTypeNumber title:@"联系电话"];
    row.cellClass = [XWTextTableViewCell class];
    row.textFieldMaxNumberOfCharacters = @13;
    row.value = IsStrEmpty(APPDELEGATE.user.worktel)?@"联系电话":APPDELEGATE.user.worktel;
    row.editable = NO;
//    [row.cellConfigAtConfigure setObject:@"请输入固定电话xxxx-xxxxxxxx" forKey:@"textField.placeholder"];
//    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
//    row.required = YES;
//    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
//        if (newValue) {
////            weakSelf.registerModel.telephone = [NSString stringWithFormat:@"%@",newValue];
//        }else{
////            weakSelf.registerModel.telephone = nil;
//        }
//    };
    [section addFormRow:row];
    // 手机 2-100
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterMobileTF rowType:XLFormRowDescriptorTypePhone title:@"联系手机"];
    row.cellClass = [XWTextTableViewCell class];
    row.textFieldMaxNumberOfCharacters = @13;
    row.value = IsStrEmpty(APPDELEGATE.user.tel)?@"联系手机":APPDELEGATE.user.tel;
//    [row.cellConfigAtConfigure setObject:@"请输入手机号码" forKey:@"textField.placeholder"];
//    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
//    row.required = YES;
//    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
//        if (newValue) {
////            weakSelf.registerModel.mobile = [NSString stringWithFormat:@"%@",newValue];
//        }else{
////            weakSelf.registerModel.mobile = nil;
//        }
//    };
    [section addFormRow:row];
    
    // 申请说明 2-50
    row = [XLFormRowDescriptor formRowDescriptorWithTag:XWRegisterCompanyNameTF rowType:XLFormRowDescriptorTypeText title:@"申请说明"];
    row.cellClass = [XWTextTableViewCell class];
    row.textFieldMaxNumberOfCharacters = @30;
//    [row.cellConfigAtConfigure setObject:@"请输入公司名称" forKey:@"textField.placeholder"];
//    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    
    row.value = [NSString stringWithFormat:@"我要申请%@，很急，请尽快联系我，尽快能在年底完成申请！",self.model.serviceName];
//    row.onChangeBlock = ^(id  _Nullable oldValue, id  _Nullable newValue, XLFormRowDescriptor * _Nonnull rowDescriptor) {
//        if (newValue) {
//            weakSelf.registerModel.orgName = [NSString stringWithFormat:@"%@",newValue];
//        }else{
////            weakSelf.registerModel.orgName = nil;
//        }
//    };
    [section addFormRow:row];
    
    [self.form addFormSection:section];
    NSLog(@"%@",self.form.formSections);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        XLFormRowDescriptor *row = [self.form formRowWithTag:XWRegisterCompanyNameTF];
        XWTextTableViewCell *cell = (XWTextTableViewCell *)[row cellForFormController:self.form];
        return cell.cellHeight;
    }else{
        return 100*kScaleH;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 250*kScaleH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc] init];
//    UIButton *commitBtn = [RWFactionUI createButtonWith:CGRectMake(20*kScaleW, 40*kScaleH, ScreenWidth-40*kScaleW, 85*kScaleH) title:@"确定申请" backgroundImage:nil textColor:[UIColor whiteColor] target:self selector:@selector(commitLoadRequest)];
    UIButton *commitBtn = [[UIButton alloc] init];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"loan_icon_button_bg"] forState:UIControlStateNormal];
//    commitBtn.contentMode = UIViewContentModeScaleAspectFit;
//    commitBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [commitBtn setTitle:@"确定申请" forState:UIControlStateNormal];
    [commitBtn.titleLabel setFont:[UIFont rw_regularFontSize:14.0]];
//    commitBtn.layer.cornerRadius = 5;
//    commitBtn.layer.masksToBounds = YES;
//    [commitBtn setBackgroundColor:[UIColor colorWithHex:@"3b78d8"]];
    [commitBtn addTarget:self action:@selector(commitLoanRequest) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footer);
        make.top.equalTo(footer).offset(60*kScaleW);
        make.height.mas_equalTo(90*kScaleH);
        make.width.mas_equalTo(ScreenWidth/2.0);
    }];
    
    return footer;
}
#pragma mark - 确定申请
- (void)commitLoanRequest{
    RequestManager *request = [[RequestManager alloc] init];
    request.isShowLoading = NO;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"sId":@(_model.ID),//机构表ID
                                             @"uId":[USER_DEFAULT objectForKey:USERIDKEY]
                                             }];
    
    [request POSTRequestUrlStr:kApplyOrgService parms:params success:^(id responseData) {
        NSLog(@"获取数据  %@",responseData);
        if ([responseData[0] isEqualToString:@"success"]) {
            [MBProgressHUD alertInfo:@"申请成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([responseData[0] isEqualToString:@"typeErr"]) {
            [MBProgressHUD alertInfo:@"申请失败，只有贷款服务可以申请"];
        }else{
            [MBProgressHUD alertInfo:@"申请失败"];
        }
    } fail:^(NSError *error) {
        
    }];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)layoutSubviews{
    [self addSection0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
