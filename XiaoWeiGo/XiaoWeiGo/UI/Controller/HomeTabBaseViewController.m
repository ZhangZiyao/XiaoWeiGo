//
//  HomeTabBaseViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "HomeTabBaseViewController.h"
#import "XWRecommendViewController.h"
#import "XWHotDemandViewController.h"
#import "XWHotServicesViewController.h"
#import "XWCommandCell.h"
#import "XWFirstTabViewController.h"
#import "XWSecondTabViewController.h"
#import "ServiceDetailViewController.h"
#import "XWLoginViewController.h"
#import "XWDemandDetailViewController.h"

@interface HomeTabBaseViewController ()<HomeCustomViewDelegate>
{
    HomeCustomView *view1;
    HomeCustomView *view2;
    HomeCustomView *view3;
    UIButton *oldSender;
}
@property (nonatomic, assign) int indexPage;

@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIImageView *center_btn1;

@property (nonatomic, strong) UIImageView *center_btn2;

@property (nonatomic, strong) UIImageView *center_btn3;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *centerView1;
@property (nonatomic, assign) HHShowTableCellType cellType;
@end

@implementation HomeTabBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackItem];
    self.view.backgroundColor = [UIColor whiteColor];
    tagIndex = 1;
    _indexPage = 0;
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = 20;
    oldSender = btn;
}
- (void)topClickAction{
    
}
- (void)centerClickAction:(int)index{
    
}

- (void)loadHeadView:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = data;
        self.title = [dict objectForKey:@"title"];
        self.topImageView.image = [UIImage imageNamed:[dict objectForKey:@"topImage"]];
        NSArray *imageArr = [dict objectForKey:@"images"];
        _center_btn1.image = [UIImage imageNamed:imageArr[0]];
        _center_btn2.image = [UIImage imageNamed:imageArr[1]];
        _center_btn3.image = [UIImage imageNamed:imageArr[2]];
        
    }else{
        NSArray *array = data;
        //这里面修改展示view
        for (int i = 0; i < array.count; i ++) {
            NSDictionary *dict = array[i];
            if (i == 0) {
                [view1 refershData:dict];
            }else if (i == 1) {
                [view2 refershData:dict];
            }else {
                [view3 refershData:dict];
            }
        }
    }
    
}
- (void)loadTableViewWithData:(id)data type:(HHShowTableCellType)type
{
    //这里面修改tableview的数据
    _cellType = type;
    
    int category = [data intValue];
    _categoryType = category;
    [self getDataListRequestWith:category];
    
//    [self getDataListRequest];
    
}
#pragma mark - 获取数据列表
- (void)getDataListRequestWith:(int)category {
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *urlString;
    if (tagIndex == 1) {
        urlString = kGetOrgServiceList;
        [params setValuesForKeysWithDictionary:@{@"oId":@"0",
                                                 @"category":@(category),
                                                 @"indexPage":@(self.indexPage),
                                                 @"endPage":@(self.indexPage+5),
                                                 //                                             @"orderType":@"issueTime desc"
                                                 }];
    }else{
        urlString = kGetDmdList;
        [params setValuesForKeysWithDictionary:@{@"uId":@0,
                                                 @"auditing":@(-1),//审核状态(-1:所有的,0:待审核,1:审核通过,2:退回)
                                                 @"indexPage":@(self.indexPage),
                                                 @"endPage":@(self.indexPage+5),
                                                 @"category":@(category)
                                                 }];
    }
    [manager POSTRequestUrlStr:urlString parms:params success:^(id responseData) {
        NSLog(@"获取数据  %@",responseData);
        [self endRefresh];
        NSMutableArray *dataArray = [NSMutableArray array];
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                if (tagIndex == 1) {
                    dataArray = [XWServiceModel mj_objectArrayWithKeyValuesArray:array];
                }else{
                    dataArray = [CommandModel mj_objectArrayWithKeyValuesArray:array];
                }
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
            if (tagIndex == 1) {
                self.servicesDataSource = [NSMutableArray arrayWithArray:dataArray];
            }else{
                self.demandDataSource = [NSMutableArray arrayWithArray:dataArray];
            }
            
            self.dataSource = [NSMutableArray arrayWithArray:dataArray];
        }else{
            if (tagIndex == 1) {
                [self.servicesDataSource addObjectsFromArray:dataArray];
                self.dataSource = [NSMutableArray arrayWithArray:self.servicesDataSource];
            }else{
                [self.demandDataSource addObjectsFromArray:dataArray];
                self.dataSource = [NSMutableArray arrayWithArray:self.demandDataSource];
            }
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
//- (void)getDataListRequest {
//    RequestManager *manager = [[RequestManager alloc] init];
//    manager.isShowLoading = NO;
//    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValuesForKeysWithDictionary:@{@"oId":@0,
//                                             @"category":@0,
//                                             @"indexPage":@"0",
//                                             @"endPage":@"1",
//                                             //                                             @"orderType":@"issueTime"
//                                             }];
//
//    [manager GETRequestUrlStr:kGetOrgServiceList parms:params success:^(id responseData) {
//        NSLog(@"获取数据  %@",responseData);
//
//        //        [self.tableView reloadData];
//    } fail:^(NSError *error) {
//
//    }];
//}
- (void)layoutSubviews{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 600*kScaleH+16.0f)];
    _headerView.backgroundColor = bgColor;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 320*kScaleH)];
//    imageView.image = [UIImage imageNamed:@"legal_img_banner"];
    [_headerView addSubview:imageView];
    _topImageView = imageView;
    
    [_headerView addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerView);
        make.right.equalTo(_headerView);
        make.bottom.equalTo(_headerView).offset(-8.0f);
        make.height.mas_equalTo(280*kScaleH);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.tableView.tableHeaderView = _headerView;
}
- (UIView *)centerView{
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _center_btn1 = [[UIImageView alloc] init];
        _center_btn1.userInteractionEnabled = YES;
        _center_btn1.tag = 111;
        _center_btn2 = [[UIImageView alloc] init];
        _center_btn2.tag = 222;
        _center_btn2.userInteractionEnabled = YES;
        _center_btn3 = [[UIImageView alloc] init];
        _center_btn3.tag = 333;
        _center_btn3.userInteractionEnabled = YES;
        [_centerView addSubview:_center_btn1];
        [_centerView addSubview:_center_btn2];
        [_centerView addSubview:_center_btn3];
        [_center_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_centerView);
            make.top.equalTo(_centerView);
            make.bottom.equalTo(_centerView);
            make.width.mas_equalTo(ScreenWidth/2);
        }];
        [_center_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_centerView);
            make.top.equalTo(_centerView);
            make.width.mas_equalTo(ScreenWidth/2);
            make.height.mas_equalTo(140*kScaleH);
        }];
        [_center_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_centerView);
            make.bottom.equalTo(_centerView);
            make.width.mas_equalTo(ScreenWidth/2);
            make.height.mas_equalTo(140*kScaleH);
        }];
        UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTapAction:)];
        [_center_btn1 addGestureRecognizer:tap0];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTapAction:)];
        [_center_btn2 addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTapAction:)];
        [_center_btn3 addGestureRecognizer:tap2];
    }
    return _centerView;
}
- (void)centerTapAction:(UITapGestureRecognizer *)tap{
//    NSLog(@"centerTapAction  tag == %ld",tap.view.tag);
    if (tap.view.tag == 111) {
        [self centerAction1];
    }else if (tap.view.tag == 222){
        [self centerAction2];
    }else if (tap.view.tag == 333){
        [self centerAction3];
    }else{
        
    }
}
- (void)centerAction1{
    XWFirstTabViewController *infoVc = [[XWFirstTabViewController alloc] init];
    infoVc.categoryId = self.categoryType;
    [self.navigationController pushViewController:infoVc animated:YES];
}
- (void)centerAction2{
    if ([UserModel isLogin]) {
        if (APPDELEGATE.user.loginType == 3 || APPDELEGATE.user.loginType == 1) {
            [MBProgressHUD alertInfo:@"您没有此权限哦～"];
            
        }else if (APPDELEGATE.user.loginType == 2 ) {
            XWSecondTabViewController *infoVc = [[XWSecondTabViewController alloc] init];
            infoVc.categoryId = self.categoryType;
            [self.navigationController pushViewController:infoVc animated:YES];
        }else{
            [MBProgressHUD alertInfo:@"您没有此权限哦～"];
        }
    }else{
//        [MBProgressHUD alertInfo:@"请先登录～"];
        [self showLogin];
    }
}
- (void)centerAction3{
    XWRecommendViewController *recommendVc = [[XWRecommendViewController alloc] init];
    recommendVc.catagory = self.categoryType;
    [self.navigationController pushViewController:recommendVc animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([UserModel isLogin]) {
        if (tagIndex == 1) {
            ServiceDetailViewController *sDetailVc = [[ServiceDetailViewController alloc] init];
            sDetailVc.category = self.categoryType;
            sDetailVc.model = self.dataSource[indexPath.row];
            [self.navigationController pushViewController:sDetailVc animated:YES];
        }else{
            XWDemandDetailViewController *sDetailVc = [[XWDemandDetailViewController alloc] init];
            sDetailVc.model = self.dataSource[indexPath.row];
            [self.navigationController pushViewController:sDetailVc animated:YES];
        }
    }else{
//        [MBProgressHUD alertInfo:@"请先登录～"];
//        XWLoginViewController *loginVc = [[XWLoginViewController alloc] init];
//        RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:loginVc];
//        [self presentViewController:nav animated:YES completion:nil];
        [self showLogin];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tagIndex == 1) {
        XWListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeTabd"];
        if (!cell) {
            cell = [[XWListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeTabd"];
        }
        cell.type = _cellType;
        cell.cType = _categoryType==0?1:_categoryType;
        cell.serModel = self.dataSource[indexPath.row];
        return cell;
    }else{
        XWListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeTabc"];
        if (!cell) {
            cell = [[XWListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeTabc"];
        }
        cell.type = _cellType;
        cell.cType = _categoryType==0?1:_categoryType;
//        cell.dmodel = self.dataSource[indexPath.row];
        [cell resetDataWith:self.dataSource[indexPath.row] category:self.categoryType];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 66*kScaleH;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 66*kScaleH)];
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(30*kScaleW, 66*kScaleH-0.5, ScreenWidth, 0.5)];
    line.backgroundColor = LineColor;
    [headerView addSubview:line];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 182*kScaleW, 66*kScaleH)];
    btn.tag = 20;
    [btn setTitleColor:[UIColor textBlackColor] forState:UIControlStateNormal];
    [btn setTitleColor:navColor forState:UIControlStateSelected];
    [btn.titleLabel setFont:[UIFont rw_regularFontSize:14.0]];
    [btn setTitle:@"热门服务" forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"home_img_popular"] forState:UIControlStateNormal];
    [headerView addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), 0, 182*kScaleW, 66*kScaleH)];
    btn1.tag = 30;
    [btn1 setTitle:@"热门需求" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor textBlackColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:navColor forState:UIControlStateSelected];
    [btn1.titleLabel setFont:[UIFont rw_regularFontSize:14.0]];
//    [btn1 setImage:[UIImage imageNamed:@"home_img_demand"] forState:UIControlStateNormal];
    [headerView addSubview:btn1];
    [btn addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (oldSender.tag == 20) {
        btn.selected = YES;
    }else{
        btn1.selected = YES;
    }
    
    FSCustomButton *btn2 = [[FSCustomButton alloc] initWithFrame:CGRectMake(ScreenWidth-170*kScaleW, 0, 150*kScaleW, 64*kScaleH)];
    [btn2 setTitle:@"查看更多" forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont rw_regularFontSize:12]];
    [btn2 setTitleColor:[UIColor textGrayColor] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"home_icon_more"] forState:UIControlStateNormal];
    btn2.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    btn2.buttonImagePosition = FSCustomButtonImagePositionRight;
    [headerView addSubview:btn2];
    [btn2 addTarget:self action:@selector(readMore) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
}
#pragma mark - 热门服务和热门需求按钮点击切换
- (void)tabClick:(UIButton *)sender{
    if (sender.tag == 20) {
        tagIndex = 1;
        _cellType = HHShowPictureCellType;
    }else{
        tagIndex = 2;
        _cellType = HHShowNoPictureCellType;
    }
    oldSender.selected = NO;
    sender.selected = !sender.selected;
    oldSender = sender;
    [self getDataListRequestWith:self.categoryType];
}
#pragma mark - 查看更多
- (void)readMore{
    if (tagIndex == 1) {
        XWHotServicesViewController *serviceVc = [[XWHotServicesViewController alloc] init];
        serviceVc.categoryId = self.categoryType;
        [self.navigationController pushViewController:serviceVc animated:YES];
    }else{
        XWHotDemandViewController *demandVc = [[XWHotDemandViewController alloc] init];
        demandVc.categoryId = self.categoryType;
        [self.navigationController pushViewController:demandVc animated:YES];
    }
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
            [weakSelf getDataListRequestWith:self.categoryType];
        }];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        
        _tableView.mj_header = header;
        //默认block方法：设置上拉加载更多
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.indexPage += 10;
            [weakSelf getDataListRequestWith:self.categoryType];
        }];
        
        footer.arrowView.image = [UIImage imageWithColor:[UIColor clearColor]];
        footer.stateLabel.hidden = YES;
        _tableView.mj_footer = footer;
        _tableView.tableFooterView = [[NoMoreDataView alloc] init];
        _tableView.tableFooterView.hidden = YES;
    }
    return _tableView;
}
- (UIView *)centerView1{
    if (!_centerView1) {
        _centerView1 = [[UIView alloc] init];
        _centerView1.backgroundColor = [UIColor whiteColor];
        
        //        NSArray *array = @[@[@"政策红利",@"各种扶持政策",@"FD6101",@"home_img_policy"],@[@"信用信息公示",@"登录后查看",@""],@[@"",@"",@""]];
        view1 = [[HomeCustomView alloc] init];
        view1.delegate = self;
        view1.tag = 1010;
        //        view1.linePosition = CustomLinePositionRight;
        view1.imagePosition = CustomImagePositionFirst;
        view1.titleLabel.text = @"我要贷款信息";
        view1.titleLabel.textColor = UIColorFromRGB16(0xFD6101);
        view1.detailLabel.text = @"总有一款适合你的产品";
        view1.smallImageView.image = [UIImage imageNamed:@"loan_img_nav1"];
        //        view1
        [_centerView1 addSubview:view1];
        
        view2 = [[HomeCustomView alloc] init];
        //        view2.linePosition = CustomLinePositionBottom;
        view2.delegate = self;
        view2.tag = 1011;
        view2.imagePosition = CustomImagePositionCenter;
        view2.titleLabel.text = @"我要贷款";
        view2.titleLabel.textColor = UIColorFromRGB16(0x406ABB);
        view2.detailLabel.text = @"我要马上发布";
        view2.smallImageView.image = [UIImage imageNamed:@"loan_img_nav2"];
        [_centerView1 addSubview:view2];
        view3 = [[HomeCustomView alloc] init];
        view3.delegate = self;
        view3.tag = 1012;
        //        view3.linePosition = CustomLinePositionTop;
        view3.imagePosition = CustomImagePositionRightEdge0;
        view3.titleLabel.text = @"推荐机构";
        view3.titleLabel.textColor = UIColorFromRGB16(0X0CA6AE);
        view3.detailLabel.text = @"小微加油推荐哦";
        view3.smallImageView.image = [UIImage imageNamed:@"loan_img_nav3"];
        [_centerView1 addSubview:view3];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_centerView1);
            make.top.equalTo(_centerView1);
            make.bottom.equalTo(_centerView1);
            make.width.mas_equalTo(ScreenWidth/2);
        }];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_centerView1);
            make.top.equalTo(_centerView1);
            make.width.mas_equalTo(ScreenWidth/2);
            make.height.mas_equalTo(140*kScaleH);
        }];
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_centerView1);
            make.bottom.equalTo(_centerView1);
            make.width.mas_equalTo(ScreenWidth/2);
            make.height.mas_equalTo(140*kScaleH);
        }];
        
    }
    return _centerView1;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSMutableArray *)demandDataSource{
    if (!_demandDataSource) {
        _demandDataSource = [NSMutableArray array];
    }
    return _demandDataSource;
}
- (NSMutableArray *)servicesDataSource{
    if (!_servicesDataSource) {
        _servicesDataSource = [NSMutableArray array];
    }
    return _servicesDataSource;
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
