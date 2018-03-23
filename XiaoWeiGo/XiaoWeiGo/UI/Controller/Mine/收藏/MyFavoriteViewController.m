//
//  MyFavoriteViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "MyFavoriteViewController.h"
#import "XWServiceModel.h"
#import "XWCollectViewCell.h"
#import "XWBaseHeaderView.h"
#import "ServiceDetailViewController.h"
#import "XWSearchViewController.h"

@interface MyFavoriteViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int pageIndex;
@end

@implementation MyFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self showBackItem];
    _pageIndex = 0;
    [self getDataList];
}
- (void)layoutSubviews{
    
//    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90*kScaleH)];
//    headerImageView.image = [UIImage imageNamed:@"favorite_top"];
//    [self.view addSubview:headerImageView];
    
//    XWBaseHeaderView *headerView = [XWBaseHeaderView createHeaderViewWithTitle:@"服务机构"];
    XWBaseHeaderView *headerView = [[XWBaseHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90*kScaleH)];
    headerView.title = @"服务机构";
    headerView.showSearchBtn = YES;
    [headerView setupView];
    WS(weakSelf);
    headerView.rightItemClickBlock = ^{
        //搜索
        XWSearchViewController *selectionVc = [XWSearchViewController new];
        selectionVc.type = 40;
        [weakSelf.navigationController pushViewController:selectionVc animated:YES];
    };
    
    //    [self.view addSubview:headerView];
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XWCollectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demand"];
    if (!cell) {
        cell = [[XWCollectViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"demand"];
    }
    cell.smodel = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceDetailViewController *sDetailVc = [[ServiceDetailViewController alloc] init];
//    sDetailVc.category = self.categoryId;
    sDetailVc.model = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:sDetailVc animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8.0f;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = bgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        WS(weakSelf);
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.pageIndex = 0;
            [weakSelf getDataList];
        }];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        //        header.stateLabel.hidden = YES;
        
        _tableView.mj_header = header;
        _tableView.tableFooterView = [[NoMoreDataView alloc] init];
        _tableView.tableFooterView.hidden = YES;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark - 获取收藏列表
- (void)getDataList{
    if (![UserModel isLogin]) {
//        [MBProgressHUD alertInfo:@"请先登录"];
        [self showLogin];
        return;
    }
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"uId":[USER_DEFAULT objectForKey:USERIDKEY]
                                             }];
    
    [manager POSTRequestUrlStr:kGetServiceCollect parms:params success:^(id responseData) {
        NSLog(@"我的收藏  %@",responseData);
        [self endRefresh];
        NSMutableArray *dataArray = [NSMutableArray array];
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                dataArray = [XWServiceModel mj_objectArrayWithKeyValuesArray:array];
            }
        }
//        if (dataArray.count < 10) {
            self.tableView.tableFooterView.hidden = NO;
            self.tableView.mj_footer.hidden = YES;
//        }else{
//            self.tableView.tableFooterView.hidden = YES;
//            self.tableView.mj_footer.hidden = NO;
//        }
        
        self.dataSource = [NSMutableArray arrayWithArray:dataArray];
        
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        [self endRefresh];
    }];
}
- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
