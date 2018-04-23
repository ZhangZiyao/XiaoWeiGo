//
//  XWQQViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/12.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWQQViewController.h"
#import "XWServiceModel.h"
#import <ContactsUI/ContactsUI.h>
#import <ContactsUI/CNContactViewController.h>
#import <ContactsUI/CNContactPickerViewController.h>
#import "AddressBookHelper.h"

@interface XWQQViewController ()<UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate,CNContactViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation XWQQViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看名片";
    [self showBackItem];
}

- (void)layoutSubviews{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    headerView.backgroundColor = bgColor;
    UIImageView *iconI = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 60, 60)];
    iconI.image = [UIImage imageNamed:@"comment_icon"];
    iconI.layer.masksToBounds = YES;
    iconI.layer.cornerRadius = 5.0;
    iconI.layer.borderWidth = 0.5;
    iconI.layer.borderColor = LineColor.CGColor;
    [headerView addSubview:iconI];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, ScreenWidth-100, 30)];
    label.text = [NSString ifNull:self.model.contacts];
    label.font = [UIFont rw_mediumFontSize:16.0];
    label.textColor = [UIColor blackColor];
    [headerView addSubview:label];
    
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lalala"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lalala"];
        cell.textLabel.textColor = UIColorFromRGB16(0x999999);
        cell.textLabel.font = [UIFont rw_regularFontSize:15.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont rw_regularFontSize:15.0];
    label.textColor = UIColorFromRGB16(0x117226);
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView).offset(90);
        make.right.equalTo(cell.contentView).offset(-15);
        make.centerY.equalTo(cell.contentView);
    }];
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"手机";
            label.text = [NSString ifNull:self.model.tel];
            if (!IsStrEmpty(self.model.tel) && ![self.model.tel containsString:@"*"]) {
                UIButton *callBtn = [[UIButton alloc] init];
                callBtn.tag = 10;
                [callBtn setImage:[UIImage imageNamed:@"ico_phone"] forState:UIControlStateNormal];
                callBtn.contentMode = UIViewContentModeScaleAspectFit;
                callBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
                [callBtn addTarget:self action:@selector(callBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:callBtn];
                [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(cell.contentView).offset(-20);
                    make.centerY.equalTo(cell.contentView);
                    make.size.mas_equalTo(CGSizeMake(40, 20));
                }];
            }
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"工作电话";
            label.text = [NSString ifNull:self.model.telphone];
            if (!IsStrEmpty(self.model.telphone) && ![self.model.telphone containsString:@"*"]) {
                UIButton *callBtn = [[UIButton alloc] init];
                callBtn.tag = 100;
                [callBtn setImage:[UIImage imageNamed:@"ico_phone"] forState:UIControlStateNormal];
                callBtn.contentMode = UIViewContentModeScaleAspectFit;
                callBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
                [callBtn addTarget:self action:@selector(callBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:callBtn];
                [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(cell.contentView).offset(-20);
                    make.centerY.equalTo(cell.contentView);
                    make.size.mas_equalTo(CGSizeMake(40, 20));
                }];
            }
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"邮箱";
            label.text = [NSString ifNull:self.model.email];
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"工作地址";
            label.text = [NSString ifNull:self.model.sAddress];
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"备注";
            label.text = [NSString ifNull:@""];
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"微信号";
            label.text = [NSString ifNull:@""];
        }
            break;
        case 6:
        {
            UIButton *addBtn = [[UIButton alloc] init];
            [addBtn setTitle:@"添加到通讯录" forState:UIControlStateNormal];
            [addBtn setBackgroundColor:UIColorFromRGB16(0x00B30A)];
            addBtn.layer.cornerRadius = 5.0;
            addBtn.layer.masksToBounds = YES;
            addBtn.contentMode = UIViewContentModeScaleAspectFit;
            addBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:addBtn];
            [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(15);
                make.right.equalTo(cell.contentView).offset(-15);
                make.centerY.equalTo(cell.contentView);
                make.height.mas_equalTo(45);
            }];
        }
            break;
            
        default:
            break;
    }
    return cell;
}
- (void)addBtnClick:(UIButton *)sender{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"创建新联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveNewContact];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"添加到现有联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveExistContact];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
//    [self saveNewContact];
    
//    [self saveTeleToAddBook];
}
//- (void)saveTeleToAddBook
//{
//    NSString *phone = self.model.tel;
//
//    if ([AddressBookHelper existPhone:phone] == ABHelperExistSpecificContact)
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"消息提示" message:[NSString stringWithFormat:@"手机号码：%@已存在通讯录",phone] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    else
//    {
//        if ([AddressBookHelper addContactName:self.model.contacts phoneNum:phone withLabel:@"电话"])
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息提示" message:@"添加到通讯录成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        };
//    }
//
//}
- (void)saveNewContact{
    //1.创建Contact对象，必须是可变的
    CNMutableContact *contact = [[CNMutableContact alloc] init];
    //2.为contact赋值，这块比较恶心，很混乱，setValue4Contact中会给出常用值的对应关系

//    contact.phoneNumbers = @[self.model.tel];
    [self setValue4Contact:contact existContect:NO];
    //3.创建新建好友页面
    CNContactViewController *controller = [CNContactViewController viewControllerForNewContact:contact];
    //代理内容根据自己需要实现
    controller.delegate = self;
    //4.跳转
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigation animated:YES completion:^{

    }];

}
//添加到现有联系人
- (void)saveExistContact{
    //1.跳转到联系人选择页面，注意这里没有使用UINavigationController
    CNContactPickerViewController *controller = [[CNContactPickerViewController alloc] init];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}

//设置要保存的contact对象
- (void)setValue4Contact:(CNMutableContact *)contact existContect:(BOOL)exist{
    if (!exist) {
        //名字和头像
//        contact.nickname = self.model.contacts;
        contact.familyName = self.model.contacts;

        if (!IsStrEmpty(self.model.tel)) {

        }
        if (!IsStrEmpty(self.model.telphone)) {

        }
        
//        if (!IsStrEmpty(self.model.sAddress)) {
//            contact.postalAddresses = @[self.model.sAddress];
//        }

    }
    //电话,每一个CNLabeledValue都是有讲究的，如何批评，可以在头文件里面查找，这里给出几个常用的，别的我也不愿意去研究
    CNLabeledValue *phoneNumber = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile value:[CNPhoneNumber phoneNumberWithStringValue:self.model.tel]];
//    CNLabeledValue *telNumber = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberWorkFax value:self.model.telphone];
//    邮箱:
//    if (!IsStrEmpty(self.model.email)) {
//        contact.emailAddresses = @[self.model.email];
//        CNLabeledValue *mail = [CNLabeledValue labeledValueWithLabel:CNLabelWork value:[NSString  initWithStringValue:self.model.tel]];
//    }
    
    if (!exist) {
        contact.phoneNumbers = @[phoneNumber];
//        contact.emailAddresses = @[mail];
//        contact.
    }
    //现有联系人情况
    else{
        if ([contact.phoneNumbers count] >0) {
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] initWithArray:contact.phoneNumbers];
            [phoneNumbers addObject:phoneNumber];
            contact.phoneNumbers = phoneNumbers;
        }else{
            contact.phoneNumbers = @[phoneNumber];
        }
    }
//    网址:CNLabeledValue *url = [CNLabeledValue labeledValueWithLabel:@"" value:@""];
    
}
#pragma mark - CNContactPickerDelegate
//2.实现点选的代理，其他代理方法根据自己需求实现
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    [picker dismissViewControllerAnimated:YES completion:^{
        //3.copy一份可写的Contact对象，不要尝试alloc一类，mutableCopy独此一家
        CNMutableContact *c = [contact mutableCopy];
        //4.为contact赋值
        [self setValue4Contact:c existContect:YES];
        //5.跳转到新建联系人页面
        CNContactViewController *controller = [CNContactViewController viewControllerForNewContact:c];
        controller.delegate = self;
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navigation animated:YES completion:^{
        }];
    }];
}

- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(nullable CNContact *)contact{

    if (contact) {
        NSLog(@"保存成功");
    }else{

        NSLog(@"点击了取消，保存失败");
    }

    [viewController dismissViewControllerAnimated:YES completion:nil];

}
//将电话保存到通讯录
//- (void)saveTeleToAddBook
//{
//    NSString *phone = self.dic[@"mobile"];
//
//    if ([addressBookHelper existPhone:phone] == ABHelperExistSpecificContact)
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"消息提示" message:[NSString stringWithFormat:@"手机号码：%@已存在通讯录",phone] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    else
//    {
//        if ([addressBookHelper addContactName:self.dic[@"name"] phoneNum:phone withLabel:@"电话"])
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"消息提示" message:@"添加到通讯录成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        };
//    }
//
//}
- (void)callBtnClick:(UIButton *)sender{
    if (sender.tag == 10) {
        if (!IsStrEmpty(self.model.tel) && ![self.model.tel containsString:@"*"]) {
            NSURL *pURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.tel]];
            [[UIApplication sharedApplication] openURL:pURL];
        }
    }else{
        if (!IsStrEmpty(self.model.telphone) && ![self.model.telphone containsString:@"*"]) {
            NSURL *pURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.telphone]];
            [[UIApplication sharedApplication] openURL:pURL];
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        return 60.0;
    }else{
        return 44.0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = bgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
