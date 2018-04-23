//
//  XWMineInfoViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWMineInfoViewController.h"
#import "XWEditUserInfoViewController.h"
#import "BRPickerView.h"

@interface XWMineInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation XWMineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self showBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
    RegisterNotify(XWUserInfoChangeNotification, @selector(refreshUserInfo));
}
- (void)refreshUserInfo{
    WS(weakSelf);
    [UserModel getUserDataBlock:^(BOOL success) {
        if (success) {
           [weakSelf.tableView reloadData];
        }
    }];
    
}
- (void)layoutSubviews{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mineCell"];
        cell.textLabel.textColor = [UIColor textBlackColor];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                //头像
//            }else if (indexPath.row == 1){
//                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.NickName)?@"":APPDELEGATE.user.NickName;
            }else if (indexPath.row == 1){
                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.name)?@"":APPDELEGATE.user.name;
            }else if (indexPath.row == 2){
//                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.NickName)?@"":APPDELEGATE.user.NickName;
                
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.address)?@"":APPDELEGATE.user.address;
            }else if (indexPath.row == 1){
                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.worktel)?@"":APPDELEGATE.user.worktel;
            }else if (indexPath.row == 2){
                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.tel)?@"":APPDELEGATE.user.tel;
//            }else if (indexPath.row == 3){
//                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.weNumber)?@"":APPDELEGATE.user.weNumber;
            }else if (indexPath.row == 3){
                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.email)?@"":APPDELEGATE.user.email;
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.address)?@"":APPDELEGATE.user.regCapital;
            }else if (indexPath.row == 1){
                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.worktel)?@"":APPDELEGATE.user.regCapital;
            }else if (indexPath.row == 2){
                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.tel)?@"":APPDELEGATE.user.tradeCode;
            }else if (indexPath.row == 3){
                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.weNumber)?@"":APPDELEGATE.user.regOrg;
            }else if (indexPath.row == 4){
                cell.detailTextLabel.text = IsStrEmpty(APPDELEGATE.user.email)?@"":APPDELEGATE.user.tradeCode;
            }
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *strArray = @[@[@"avatar",@"name"],@[@"address",@"worktel",@"tel",@"email"],@[@"",@"",@"",@"",@"",@"",@""]];
    switch (indexPath.section) {
        case 0:
        {
//            if (indexPath.row == 1) {
//                XWEditUserInfoViewController *editvc = [[XWEditUserInfoViewController alloc] init];
//                editvc.title = @"修改昵称";
//                editvc.keyType = strArray[indexPath.section][indexPath.row];
//                [self.navigationController pushViewController:editvc animated:YES];
//            }else
                if (indexPath.row == 1){
                XWEditUserInfoViewController *editvc = [[XWEditUserInfoViewController alloc] init];
                editvc.title = @"修改姓名";
                editvc.keyType = strArray[indexPath.section][indexPath.row];
                [self.navigationController pushViewController:editvc animated:YES];
//            }else if (indexPath.row == 2){
//                //性别
//                WS(weakSelf);
//                [BRStringPickerView showStringPickerWithTitle:nil dataSource:@[@"男", @"女"] defaultSelValue:@"男" isAutoSelect:NO resultBlock:^(id selectValue) {
//                    //                    rowDescriptor.title = StringPush(@"  手机状态：", selectValue, @"");
//                    //                    weakSelf.registerModel.phoneStatus = [selectValue isEqualToString:@"公开"]?1:0;
//                    [weakSelf.tableView reloadData];
//                }];
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                XWEditUserInfoViewController *editvc = [[XWEditUserInfoViewController alloc] init];
                editvc.title = @"修改地址";
                editvc.keyType = strArray[indexPath.section][indexPath.row];
                [self.navigationController pushViewController:editvc animated:YES];
            }else if (indexPath.row == 1) {
                XWEditUserInfoViewController *editvc = [[XWEditUserInfoViewController alloc] init];
                editvc.title = @"修改联系电话";
                editvc.keyType = strArray[indexPath.section][indexPath.row];
                [self.navigationController pushViewController:editvc animated:YES];
            }else if (indexPath.row == 2){
                XWEditUserInfoViewController *editvc = [[XWEditUserInfoViewController alloc] init];
                editvc.title = @"修改手机";
                editvc.keyType = strArray[indexPath.section][indexPath.row];
                [self.navigationController pushViewController:editvc animated:YES];
            }else if (indexPath.row == 3){
                //QQ/微信
                XWEditUserInfoViewController *editvc = [[XWEditUserInfoViewController alloc] init];
                editvc.title = @"修改QQ/微信";
                editvc.keyType = strArray[indexPath.section][indexPath.row];
                [self.navigationController pushViewController:editvc animated:YES];
            }else if(indexPath.row == 4){
                XWEditUserInfoViewController *editvc = [[XWEditUserInfoViewController alloc] init];
                editvc.title = @"修改QQ/微信";
                editvc.keyType = strArray[indexPath.section][indexPath.row];
                [self.navigationController pushViewController:editvc animated:YES];
            }
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (APPDELEGATE.user.loginType == 2 || APPDELEGATE.user.loginType == 1) {
        return 3;
    }else{
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 120*kScaleH;
    }else{
        return 90*kScaleH;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@[@"头像",@"真实姓名"],@[@"联系地址",@"联系电话",@"手机",@"邮箱"],@[@"企业类型",@"资金数额",@"统一社会信用代码/注册号",@"注册日期",@"登记机关",@"行业代码"]]];
    }
    return _dataSource;
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
