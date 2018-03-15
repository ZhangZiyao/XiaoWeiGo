//
//  XWMineViewController.m
//  XiaoWei
//
//  Created by dingxin on 2018/1/26.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWMineViewController.h"
#import "XWMineInfoViewController.h"
#import "MyDemandViewController.h"
#import "MySettingsViewController.h"
#import "MySupplyViewController.h"
#import "MyFavoriteViewController.h"
#import "XWLoginViewController.h"

@interface XWMineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UserModel *user;
}
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *orgNameLabel;

@end

@implementation XWMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self showBackItem];
    [self getUserInfo];
    RegisterNotify(XWUserInfoChangeNotification, @selector(refreshUserInfo));
}
- (void)refreshUserInfo{
    [UserModel getUserData];
    self.nickNameLabel.text = [NSString stringWithFormat:@"昵称：%@",APPDELEGATE.user.loginType==3?@"一般用户":(APPDELEGATE.user.loginType==2?@"小微企业":@"企业服务商")];
    self.orgNameLabel.text = [NSString stringWithFormat:@"实名：%@",[NSString ifNull:user.name]];
    [self.tableView reloadData];
}
- (void)layoutSubviews{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.tableView.tableHeaderView = self.headerView;
}
- (void)pushToMineInfovc{
    XWMineInfoViewController *mineVc = [[XWMineInfoViewController alloc] init];
    [self.navigationController pushViewController:mineVc animated:YES];
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 288*kScaleH)];
        _headerView.backgroundColor = navColor;
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.image = [UIImage imageNamed:@"mine_icon_avatar"];
        [_headerView addSubview:iconImage];
        iconImage.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMineInfovc)];
//        [iconImage addGestureRecognizer:tap];
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerView).offset(60*kScaleW);
            make.top.equalTo(_headerView).offset(100*kScaleW);
            make.size.mas_equalTo(CGSizeMake(120*kScaleW, 120*kScaleH));
        }];
//        if (user) {
//            NSArray *array = @[@"账号",@"昵称",@"实名"];
            for (int i = 0; i < 3; i++) {
                UILabel *label = [[UILabel alloc] init];
//                label.text = [NSString stringWithFormat:@"%@",array[i]];
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont rw_mediumFontSize:14];
                [_headerView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(iconImage.mas_right).offset(20*kScaleW);
                    make.top.equalTo(iconImage).offset(40*kScaleH*i);
                    make.right.equalTo(_headerView).offset(-20*kScaleW);
                }];
                if (i == 0) {
                    self.accountLabel = label;
                }else if (i == 1){
                    self.nickNameLabel = label;
                }else{
                    self.orgNameLabel = label;
                }
            }
//        }
        self.accountLabel.text = [NSString stringWithFormat:@"账号：%@",[USER_DEFAULT objectForKey:USERLOGINNAMEKEY]];
    }
    return _headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineCell"];
    }
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mine_icon_icon%d",(int)indexPath.row+1]];
    cell.textLabel.text = self.dataSource[indexPath.row][0];
    cell.textLabel.textColor = [UIColor colorWithHex:@"666666"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XWBaseViewController *page;
    if (![UserModel isLogin]) {
//        [MBProgressHUD alertInfo:@"请先登录"];
//        page = [XWLoginViewController new];
        [self showLogin];
        return;
    }else{
        
        switch (indexPath.row) {
            case 0:
            {
                if (self.dataSource.count == 3) {
//                    page = [MySupplyViewController new];
                    page = [MyDemandViewController new];
                }else{
//                    page = [MyFavoriteViewController new];
                    page = [MyFavoriteViewController new];
                }
            }
                break;
            case 1:
            {
                if (self.dataSource.count == 3) {
                    page = [MyFavoriteViewController new];
                }else{
                    page = [MySettingsViewController new];
                }
            }
                break;
            case 2:
            {
                page = [MySettingsViewController new];
            }
                break;
            case 3:
            {
                page = [MySettingsViewController new];
            }
                break;
                
            default:
                break;
        }
    }
    
    if (page) {
        [self.navigationController pushViewController:page animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10*kScaleH;
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
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        UserModel *user = APPDELEGATE.user;
        if (APPDELEGATE.user.loginType == 1 || APPDELEGATE.user.loginType == 2) {
            _dataSource = [NSMutableArray arrayWithArray:@[@[@"我发布的需求",@""],@[@"我的收藏",@""],@[@"我的设置",@""]]];
            
        }else{
            _dataSource = [NSMutableArray arrayWithArray:@[@[@"我的收藏",@""],@[@"我的设置",@""]]];
        }
    }
    return _dataSource;
}
#pragma mark - 获取用户信息
- (void)getUserInfo{
    if (![UserModel isLogin]) {
//        [MBProgressHUD alertInfo:@"请先登录"];
        [self showLogin];
        return;
    }
    NSDictionary *params = @{@"uId":[USER_DEFAULT objectForKey:USERIDKEY]};
    //        WS(weakSelf);
    RequestManager *request = [[RequestManager alloc] init];
    [request POSTRequestUrlStr:kGetUserInfo parms:params success:^(id responseData) {
        
        NSLog(@" responseData  %@ ",[responseData class]);
        user = [UserModel mj_objectWithKeyValues:responseData[0]];
//        [RWCache setUser:user];
        
        self.nickNameLabel.text = [NSString stringWithFormat:@"昵称：%@",APPDELEGATE.user.loginType==3?@"一般用户":(APPDELEGATE.user.loginType==2?@"小微企业":@"企业服务商")];
        self.orgNameLabel.text = [NSString stringWithFormat:@"实名：%@",[NSString ifNull:user.name]];
        
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
