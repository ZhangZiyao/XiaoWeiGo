//
//  XWBookViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBookViewController.h"
#import "CompanyModel.h"
#import "XWCompanyViewCell.h"
#import "XWCompanyDetailViewController.h"
#import "XWBaseHeaderView.h"
#import "XWSearchViewController.h"

@interface XWBookViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int pageIndex;


@end

@implementation XWBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小微企业名录";
    [self showBackItem];
    _pageIndex = 0;
    [self getDataList];
}
- (void)layoutSubviews{
    
//    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90*kScaleH)];
//    headerImageView.image = [UIImage imageNamed:@"favorite_top"];
//    [self.view addSubview:headerImageView];
    XWBaseHeaderView *headerView = [[XWBaseHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90*kScaleH)];
    headerView.title = @"小微企业名录";
    headerView.showSearchBtn = YES;
    [headerView setupView];
    WS(weakSelf);
    headerView.rightItemClickBlock = ^{
        //搜索
        XWSearchViewController *selectionVc = [XWSearchViewController new];
//        selectionVc.type = 20;
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
    CompanyModel *model = self.dataSource[indexPath.row];
    XWCompanyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"company"];
    if (!cell) {
        cell = [[XWCompanyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"company"];
    }
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyModel *model = self.dataSource[indexPath.row];
    XWCompanyDetailViewController *detailVc = [[XWCompanyDetailViewController alloc] init];
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
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
        
                //默认block方法：设置上拉加载更多
                MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    weakSelf.pageIndex += 10;
                    [weakSelf getDataList];
                }];
        
                footer.arrowView.image = [UIImage imageWithColor:[UIColor clearColor]];
                footer.stateLabel.hidden = YES;
                _tableView.mj_footer = footer;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)getDataList {
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"cId":@"0",//小薇企业ID(如果为0则获取所有小薇企业列表)
                                             @"indexPage":@(_pageIndex),
                                             @"endPage":@(_pageIndex+10),
                                             @"orderType":@"ID"//排序方式
                                             }];
    
    [manager POSTRequestUrlStr:kGetCompanyInfo parms:params success:^(id responseData) {
        NSLog(@"获取数据  %@",responseData);
        [self endRefresh];
        NSMutableArray *dataArray = [NSMutableArray array];
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                dataArray = [CompanyModel mj_objectArrayWithKeyValuesArray:array];
            }
        }
        if (_pageIndex == 0) {
            self.dataSource = [NSMutableArray arrayWithArray:dataArray];
        }else{
            [self.dataSource addObjectsFromArray:dataArray];
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        [self endRefresh];
    }];
}
-(void)endRefresh{
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
