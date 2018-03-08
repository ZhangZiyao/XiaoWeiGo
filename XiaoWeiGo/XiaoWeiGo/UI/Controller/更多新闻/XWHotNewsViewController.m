//
//  XWHotNewsViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWHotNewsViewController.h"
#import "XWTextViewCell.h"
#import "NewsModel.h"
#import "XWNewsDetailViewController.h"

@interface XWHotNewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation XWHotNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门新闻";
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
    [params setValuesForKeysWithDictionary:@{@"region":@0,//地域(如果为0即所有地域)
                                             @"category":@(self.categoryId),//类别(如果为0即所有分类)
                                             @"indexPage":@(_pageIndex),
                                             @"endPage":@(_pageIndex+10),
                                             @"text":@"",
                                             @"orderType":@"issueTime desc"//排序方式
                                             }];
    
    [manager POSTRequestUrlStr:kGetNewsInfoList parms:params success:^(id responseData) {
        [self endRefresh];
        
        NSMutableArray *dataArray = [NSMutableArray array];
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                dataArray = [NewsModel mj_objectArrayWithKeyValuesArray:array];
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
    NewsModel *model = self.dataSource[indexPath.section];
    static NSString *cellid = @"hotService";
    XWTextViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[XWTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell resetData:model type:HHShowNewsTimeCellType];
    return cell;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsModel *model = self.dataSource[indexPath.section];
    XWNewsDetailViewController *detailVc = [[XWNewsDetailViewController alloc] init];
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
    
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
