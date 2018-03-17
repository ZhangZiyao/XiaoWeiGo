//
//  XWRecommendViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWRecommendViewController.h"
#import "XWListViewCell.h"
#import "XWOrgModel.h"
#import "XWOrgViewCell.h"
#import "ServiceDetailViewController.h"

@interface XWRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) int indexPage;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation XWRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐机构";
    [self showBackItem];
    _indexPage = 0;
    [self getOrgInfoList];
}
- (void)layoutSubviews{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XWOrgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"company"];
    if (!cell) {
        cell = [[XWOrgViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"company"];
    }
//    cell.type = _catagory;
    cell.cType = 20;
    cell.smodel = self.dataSource[indexPath.row];
    return cell;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceDetailViewController *sDetailVc = [[ServiceDetailViewController alloc] init];
    sDetailVc.category = self.catagory;
    sDetailVc.model = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:sDetailVc animated:YES];
}

#pragma mark - kGetOrgInfo 获取机构信息
- (void)getOrgInfoList {
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"oId":@"0",//机构ID(如果为0则获取所有机构列表)
                                             @"category":@(self.catagory),
                                             @"indexPage":@(_indexPage),
                                             @"endPage":@(_indexPage+10),
//                                             @"orderType":@"ID",
                                             }];
    //isRecommend  是否是推荐机构
    [manager POSTRequestUrlStr:kGetOrgServiceList parms:params success:^(id responseData) {
        NSLog(@"获取机构信息  %@",responseData);
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
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        WS(weakSelf);
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.indexPage = 0;
            [weakSelf getOrgInfoList];
        }];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        //        header.stateLabel.hidden = YES;
        
        _tableView.mj_header = header;
        
        //默认block方法：设置上拉加载更多
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //Call this Block When enter the refresh status automatically
            weakSelf.indexPage += 10;
            [weakSelf getOrgInfoList];
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
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
