//
//  XWHotDemandViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWHotDemandViewController.h"
#import "CommandModel.h"
#import "XWCommandCell.h"
#import "XWDemandDetailViewController.h"

@interface XWHotDemandViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation XWHotDemandViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门需求";
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
- (void)requestDemmandList{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"uId":@0,
                                             @"auditing":@(-1),//审核状态(-1:所有的,0:待审核,1:审核通过,2:退回)
                                             @"indexPage":@(_pageIndex),
                                             @"endPage":@(_pageIndex+10),
                                             @"category":@(self.categoryId)
                                             }];
    
    [manager POSTRequestUrlStr:kGetDmdList parms:params success:^(id responseData) {
        [self endRefresh];
        
        NSMutableArray *dataArray = [NSMutableArray array];
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                dataArray = [CommandModel mj_objectArrayWithKeyValuesArray:array];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommandModel *model = self.dataSource[indexPath.section];
    static NSString *cellid = @"hotService";
    XWCommandCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[XWCommandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = model;
//    [cell resetData:model type:HHShowNewsTimeCellType];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XWDemandDetailViewController *sDetailVc = [[XWDemandDetailViewController alloc] init];
    sDetailVc.model = self.dataSource[indexPath.section];
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
            [weakSelf requestDemmandList];
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
            [weakSelf requestDemmandList];
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
