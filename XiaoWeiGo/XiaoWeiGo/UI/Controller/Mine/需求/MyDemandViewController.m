//
//  MyDemandViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "MyDemandViewController.h"
#import "YUSegment.h"
#import "CommandModel.h"
#import "XWCommandCell.h"
#import "DemandReleaseViewController.h"
#import "XWDemandDetailViewController.h"

@interface MyDemandViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger status;//审核状态(-1:所有的,0:待审核,1:审核通过,2:退回)
}
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YUSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIButton *publishBtn;
@end

@implementation MyDemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我发布的需求";
    [self showBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
    status = -1;
    _pageIndex = 0;
    [self getDataList];
}
- (void)segmentedControlTapped:(YUSegmentedControl *)sender {
    NSLog(@" %ld",sender.selectedSegmentIndex);
    status = sender.selectedSegmentIndex-1;
    
    [self getDataList];
}
- (void)releaseDemand{
    DemandReleaseViewController *rDemandVc = [[DemandReleaseViewController alloc] init];
    [self.navigationController pushViewController:rDemandVc animated:YES];
}

- (void)layoutSubviews{
    
    [self.view addSubview:self.publishBtn];
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15*kScaleH);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(60*kScaleH);
        make.width.mas_equalTo(340*kScaleW);
    }];
    
    NSArray *dataArr = @[@"全部",@"待审核",@"审核通过",@"退回"];
    _segmentedControl = [[YUSegmentedControl alloc] initWithTitles:dataArr];
    _segmentedControl.backgroundColor = [UIColor whiteColor];
    _segmentedControl.showsBottomSeparator = YES;
    _segmentedControl.showsTopSeparator = YES;
    [_segmentedControl addTarget:self action:@selector(segmentedControlTapped:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(90*kScaleH);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(90*kScaleH);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(180*kScaleH, 0, 0, 0));
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XWCommandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demand"];
    if (!cell) {
        cell = [[XWCommandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"demand"];
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XWDemandDetailViewController *sDetailVc = [[XWDemandDetailViewController alloc] init];
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
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8.0f;
}
- (void)getDataList{
    if (![UserModel isLogin]) {
//        [MBProgressHUD alertInfo:@"请先登录"];
        [self showLogin];
        return;
    }
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = YES;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"uId":[USER_DEFAULT objectForKey:USERIDKEY],
                                             @"auditing":@(status),//审核状态(-1:所有的,0:待审核,1:审核通过,2:退回)
                                             @"indexPage":@(_pageIndex),
                                             @"endPage":@(_pageIndex+10),
                                             @"category":@0
                                             }];
    
    [manager POSTRequestUrlStr:kGetDmdList parms:params success:^(id responseData) {
        NSLog(@"我发布的需求  %@",responseData);
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
        _tableView.tableFooterView = [[NoMoreDataView alloc] init];
        _tableView.tableFooterView.hidden = YES;
    }
    return _tableView;
}
- (UIButton *)publishBtn{
    if (!_publishBtn) {
        _publishBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 340*kScaleW, 60*kScaleH)];
        [_publishBtn setTitle:@"发布需求" forState:UIControlStateNormal];
        [_publishBtn setImage:[UIImage imageNamed:@"demand_icon_release"] forState:UIControlStateNormal];
        _publishBtn.layer.cornerRadius = 30*kScaleH;
        _publishBtn.layer.masksToBounds = YES;
        _publishBtn.backgroundColor = navColor;
        [_publishBtn addTarget:self action:@selector(releaseDemand) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
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
