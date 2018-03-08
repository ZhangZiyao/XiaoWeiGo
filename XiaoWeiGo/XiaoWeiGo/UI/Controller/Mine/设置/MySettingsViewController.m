//
//  MySettingsViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "MySettingsViewController.h"
#import "XWAboutViewController.h"

@interface MySettingsViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CGFloat cacheSize;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MySettingsViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"设置";
    [self showBackItem];
}
- (void)layoutSubviews{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settings"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settings"];
        cell.textLabel.font = [UIFont rw_regularFontSize:16];
        cell.textLabel.textColor = [UIColor colorWithHex:@"666666"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"关于我们";
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"清除缓存";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"已用%.2fMB",cacheSize];
    }else{
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        XWAboutViewController *aboutVc = [[XWAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVc animated:YES];
    }else{
        [self removeCache];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 150*kScaleH;
    }else{
        return 0.01f;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    if (section == 1) {
        UIButton *logoutBtn = [RWFactionUI createButtonWith:CGRectMake(35*kScaleW, 30*kScaleH, ScreenWidth-70*kScaleW, 90*kScaleH) title:@"退出登录" backgroundImage:nil textColor:[UIColor whiteColor] target:self selector:@selector(logout)];
        logoutBtn.backgroundColor = [UIColor colorWithHex:@"f54a48"];
        logoutBtn.layer.cornerRadius = 5;
        logoutBtn.layer.masksToBounds = YES;
        [footerView addSubview:logoutBtn];
    }
    return footerView;
}
- (void)logout{
    [USER_DEFAULT removeObjectForKey:USERLOGINNAMEKEY];
    [USER_DEFAULT removeObjectForKey:USERIDKEY];
    [UserModel logout];
//    SendNotify(XWLogoutNotification, nil);
    [MBProgressHUD alertInfo:@"退出成功"];
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    cacheSize = [self folderSize];
}
// 缓存大小
- (CGFloat)folderSize{
    CGFloat folderSize = 0;
    
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",(unsigned long)files.count);
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    NSLog(@"文件大小：%f",sizeM);
    
    return sizeM;
}
#pragma mark -清除缓存
- (void)removeCache{
    //===============清除缓存==============
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",(unsigned long)[files count]);
    for(NSString *p in files){
        NSError*error;
        
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            if(isRemove) {
                NSLog(@"清除成功");
                //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
                cacheSize = 0;
                [self.tableView reloadData];
                //                cacheModel.subTitle = @"已用0.00MB";
            }else{
                NSLog(@"清除失败");
            }
        }
    }
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
