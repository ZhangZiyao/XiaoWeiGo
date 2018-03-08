//
//  XWHotServicesViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWHotServicesViewController.h"
#import "XWListViewCell.h"
#import "XWServiceModel.h"
#import "ServiceDetailViewController.h"

@interface XWHotServicesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation XWHotServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门服务";
    [self showBackItem];
    _pageIndex = 0;
    
    if (APPDELEGATE.isReachable == 0) {
        //        [self.tableView emptyViewConfigerBlock:^(FOREmptyAssistantConfiger *configer) {
        //            configer.emptyImage = [UIImage imageNamed:@"wwl"];
        //        }];
    }else{
        [self.tableView.mj_header beginRefreshing];
    }
}
- (void)layoutSubviews{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
#pragma mark -  获取新闻列表
- (void)requestNewsList{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"oId":@"0",
                                             @"category":@(self.categoryId),
                                             @"indexPage":@(self.pageIndex),
                                             @"endPage":@(self.pageIndex+5),
                                             //                                             @"orderType":@"issueTime desc"
                                             }];
    
    [manager POSTRequestUrlStr:kGetOrgServiceList parms:params success:^(id responseData) {
        [self endRefresh];
        NSMutableArray *dataArray = [NSMutableArray array];
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                dataArray = [XWServiceModel mj_objectArrayWithKeyValuesArray:array];
            }
        }
        if (dataArray.count < 10) {
            self.tableView.tableFooterView.hidden = NO;
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.tableFooterView.hidden = YES;
            self.tableView.mj_footer.hidden = NO;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XWListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotservice"];
    if (!cell) {
        cell = [[XWListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hotservice"];
    }
//    cell.type = _cellType;
    cell.cType = self.categoryId==0?1:self.categoryId;
    cell.serModel = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceDetailViewController *sDetailVc = [[ServiceDetailViewController alloc] init];
    sDetailVc.category = self.categoryId;
    sDetailVc.model = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:sDetailVc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20*kScaleH;
    }else{
        return 10*kScaleH;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150*kScaleH;
    
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
            [weakSelf requestNewsList];
        }];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        //        header.stateLabel.hidden = YES;
        
        _tableView.mj_header = header;
        
        //默认block方法：设置上拉加载更多
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //Call this Block When enter the refresh status automatically
            weakSelf.pageIndex += 10;
            [weakSelf requestNewsList];
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
