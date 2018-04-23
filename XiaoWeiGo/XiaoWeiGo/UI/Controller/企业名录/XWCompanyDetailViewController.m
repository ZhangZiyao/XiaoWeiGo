//
//  XWCompanyDetailViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWCompanyDetailViewController.h"
#import "CompanyModel.h"
#import "CommandModel.h"
#import "XWCommandCell.h"
#import "XWDemandDetailViewController.h"
#import "YUSegment.h"
#import "XWBaseHeaderView.h"

@interface XWCompanyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger index;
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) YUSegmentedControl *segmentedControl;

@end

@implementation XWCompanyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"企业名录";
    [self showBackItem];
    index = 1;
//    [self getOrgServiceInfo];
}
- (void)segmentedControlTapped:(YUSegmentedControl *)sender {
    NSLog(@" %ld",sender.selectedSegmentIndex);
    index = sender.selectedSegmentIndex+1;
    [self.tableView reloadData];
}

- (void)layoutSubviews{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -200*kScaleH, 0));
    }];
    
    self.tableView.tableHeaderView = self.headerView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140*kScaleH)];
        _headerView.backgroundColor = bgColor;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70*kScaleH)];
        bgView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:bgView];
        UILabel *orgNameLabel = [[UILabel alloc] init];
        orgNameLabel.textColor = [UIColor textBlackColor];
        orgNameLabel.text = self.model.orgName;
        orgNameLabel.font = [UIFont rw_regularFontSize:15.0];
        [bgView addSubview:orgNameLabel];
        [orgNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(35*kScaleW);
            make.right.equalTo(bgView).offset(-30*kScaleW);
            make.top.equalTo(bgView);
            make.height.mas_equalTo(70*kScaleH);
        }];
        NSArray *dataArr = @[@"需求内容",@"企业简介"];
        _segmentedControl = [[YUSegmentedControl alloc] initWithTitles:dataArr];
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.showsIndicator = YES;
        _segmentedControl.showsBottomSeparator = YES;
        _segmentedControl.showsTopSeparator = NO;
        [_segmentedControl addTarget:self action:@selector(segmentedControlTapped:) forControlEvents:UIControlEventValueChanged];
        [_headerView addSubview:_segmentedControl];
        [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_headerView);
            make.left.equalTo(_headerView);
            make.right.equalTo(_headerView);
            make.height.mas_equalTo(64*kScaleH);
        }];
    }
    return _headerView;
}
//- (void)collectBtnClick:(UIButton *)sender{
//    if (sender.selected) {
//        [MBProgressHUD alertInfo:@"已经收藏过了哦～"];
//        return;
//    }
//    if (![UserModel isLogin]) {
//        //        [MBProgressHUD alertInfo:@"请先登录"];
//        [self showLogin];
//        return;
//    }
//    NSDictionary *params = @{@"uId":[USER_DEFAULT objectForKey:USERIDKEY],
//                             @"sId":@(self.model.ID)};
//    [CommonRequest collectDataWithParams:params block:^(BOOL success) {
//        if (success) {
//            sender.selected = YES;
//        }
//    }];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (index == 1) {
        CommandModel *model = self.dataSource[indexPath.section];
        static NSString *cellid = @"hottService";
        XWCommandCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[XWCommandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.model = model;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sssqsCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sssqsCell"];
        }
        //    [cell resetCellWithData:@"" andType:index];
        cell.textLabel.font = [UIFont rw_regularFontSize:14.0];
        cell.textLabel.textColor = [UIColor textBlackColor];
        cell.textLabel.numberOfLines = 0;
        if (indexPath.section == 0) {
            cell.textLabel.text = [NSString ifNull:self.model.orgSketch];
        }else{
            cell.textLabel.text = [NSString ifNull:self.model.priBusness];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (index == 1) {
        XWDemandDetailViewController *sDetailVc = [[XWDemandDetailViewController alloc] init];
        sDetailVc.model = self.dataSource[indexPath.section];
        [self.navigationController pushViewController:sDetailVc animated:YES];
    }
}
- (void)getOrgServiceInfo{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = YES;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"uId":@0,
                                             @"auditing":@(-1),//审核状态(-1:所有的,0:待审核,1:审核通过,2:退回)
                                             @"indexPage":@(0),
                                             @"endPage":@(10),
                                             @"category":@(1)
                                             }];
    
    [manager POSTRequestUrlStr:kGetDmdList parms:params success:^(id responseData) {
        NSLog(@"获取机构详情数据  %@",responseData);
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
        self.dataSource = [NSMutableArray arrayWithArray:dataArray];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (index == 1) {
        return self.dataSource.count;
    }else{
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (index == 1) {
        return 1;
    }else{
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50*kScaleH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    XWBaseHeaderView *view;
    if (section == 0) {
        if (index == 1) {
            view = [XWBaseHeaderView createHeaderViewWithTitle:@"最新需求"];
        }else{
            view = [XWBaseHeaderView createHeaderViewWithTitle:@"基本信息"];
        }
    }else{
        view = [XWBaseHeaderView createHeaderViewWithTitle:@"主营业务"];
    }
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50*kScaleH-0.5, ScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lineColor];
    [view addSubview:line];
    return view;
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
    }
    return _tableView;
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
