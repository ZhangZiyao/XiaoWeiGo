//
//  XWFirstTabViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWFirstTabViewController.h"
#import "XWBaseHeaderView.h"
#import "XWOrgModel.h"
#import "XWOrgViewCell.h"
#import "ServiceDetailViewController.h"
#import "XWSearchViewController.h"

@interface XWFirstTabViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) int indexPage;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XWFirstTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackItem];
    self.title = [NSString getCategoryNameWithCategory:self.categoryId];
    _indexPage = 0;
    [self getDataListRequestWith:self.categoryId];
}
- (void)layoutSubviews{
//    XWBaseHeaderView *headerView = [XWBaseHeaderView createHeaderViewWithTitle:[NSString getCategoryNameWithCategory:self.categoryId]];
    
    XWBaseHeaderView *headerView = [[XWBaseHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90*kScaleH)];
    headerView.title = [NSString getCategoryNameWithCategory:self.categoryId];
    headerView.showSearchBtn = YES;
    [headerView setupView];
    WS(weakSelf);
    headerView.rightItemClickBlock = ^{
      //搜索
        XWSearchViewController *selectionVc = [XWSearchViewController new];
        selectionVc.type = 20;
        selectionVc.category = weakSelf.categoryId;
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
    XWOrgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fdemand"];
    if (!cell) {
        cell = [[XWOrgViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fdemand"];
    }
    cell.smodel = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceDetailViewController *sDetailVc = [[ServiceDetailViewController alloc] init];
    sDetailVc.category = self.categoryId;
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
            weakSelf.indexPage = 0;
            [weakSelf getDataListRequestWith:weakSelf.categoryId];
        }];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        //        header.stateLabel.hidden = YES;
        _tableView.mj_header = header;
        
        //默认block方法：设置上拉加载更多
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.indexPage += 10;
            [weakSelf getDataListRequestWith:weakSelf.categoryId];
        }];
        
        footer.arrowView.image = [UIImage imageWithColor:[UIColor clearColor]];
        footer.stateLabel.hidden = YES;
        _tableView.mj_footer = footer;
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
#pragma mark - 获取数据列表
- (void)getDataListRequestWith:(int)category {
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"oId":@"0",
                                             @"category":@(category),
                                             @"indexPage":@"0",
                                             @"endPage":@"10",
                                             //                                             @"orderType":@"issueTime desc"
                                             }];
    [manager POSTRequestUrlStr:kGetOrgServiceList parms:params success:^(id responseData) {
        NSLog(@"获取数据  %@",responseData);
        [self endRefresh];
        NSMutableArray *dataArray = [NSMutableArray array];
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                dataArray = [XWOrgModel mj_objectArrayWithKeyValuesArray:array];
            }
        }
        if (dataArray.count < 10) {
            self.tableView.tableFooterView.hidden = NO;
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.tableFooterView.hidden = YES;
            self.tableView.mj_footer.hidden = NO;
        }
        if (_indexPage == 0) {
            self.dataSource = [NSMutableArray arrayWithArray:dataArray];
        }else{
            [self.dataSource addObjectsFromArray:dataArray];
        }
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
