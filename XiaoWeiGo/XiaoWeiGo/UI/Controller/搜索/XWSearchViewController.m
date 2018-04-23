//
//  XWSearchViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWSearchViewController.h"
#import "NewsModel.h"
#import "NewsViewCell.h"
#import "UIView+Utils.h"
#import "XWTextViewCell.h"
#import "XWNewsDetailViewController.h"
#import "XWServiceModel.h"
#import "CommandModel.h"
#import "XWListViewCell.h"
#import "ServiceDetailViewController.h"
#import "XWDemandDetailViewController.h"
#import "FSCustomButton.h"
#import "BRPickerView.h"
#import "XWSearchViewCell.h"

@interface XWSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *oldSearchText;
    int selectType;
    NSString *selectTypeName;
    NSArray *typeArray;
}
@property (nonatomic, assign) int indexPage;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *newsDataSource;
@end

@implementation XWSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"文件搜索";
    [self showBackItem];
    oldSearchText = @"";
    self.view.userInteractionEnabled = YES;
    selectType = 0;
    selectTypeName= @"全部";
    typeArray = @[@[@"全部", @"服务",@"需求", @"企业", @"服务商",@"政策"],@[@0,@2,@5,@4,@3,@1]];
}
- (void)selectType:(UIButton *)sender{
    //(0:所有搜索的表,1:新闻,2:服务,3:服务商,4:小微企业,5:需求)
//    NSArray *typeArray = @[@"全部",@"政策", @"服务", @"服务商", @"企业",@"需求"];
    WS(weakSelf);
    [BRStringPickerView showStringPickerWithTitle:@"" dataSource:typeArray[0] defaultSelValue:selectTypeName isAutoSelect:NO resultBlock:^(id selectValue) {
        [sender setTitle:selectValue forState:UIControlStateNormal];
        selectType = [[typeArray[1] objectAtIndex:[typeArray[0] indexOfObject:selectValue]] intValue];
        selectTypeName = selectValue;
        weakSelf.indexPage = 0;
        [weakSelf searchDataRequest:nil];
    }];
}
- (void)layoutSubviews{
    
    FSCustomButton *typeBtn = [[FSCustomButton alloc] init];
    [typeBtn setTitle:@"全部" forState:UIControlStateNormal];
    [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [typeBtn.titleLabel setFont:[UIFont rw_regularFontSize:14.0]];
    [typeBtn setImage:[UIImage imageNamed:@"a_b"] forState:UIControlStateNormal];
    typeBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
    [self.view addSubview:typeBtn];
    [typeBtn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
    [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(120*kScaleW);
        make.height.mas_equalTo(44);
    }];
    
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(120*kScaleW);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view).offset(-190*kScaleW);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:UIColorFromRGB16(0xedc440)];
    [searchBtn.titleLabel setFont:[UIFont rw_regularFontSize:15.0]];
    [self.view addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(searchDataRequest:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.layer.cornerRadius = 5.0;
    searchBtn.layer.masksToBounds = YES;
    
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBar);
        make.right.equalTo(self.view).offset(-20*kScaleW);
        make.width.mas_equalTo(160*kScaleW);
        make.height.mas_equalTo(35);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50.0, 0, 0, 0));
    }];
}
#pragma mark - 发起搜索请求
- (void)searchDataRequest:(UIButton *)sender{
    [self.searchBar resignFirstResponder];
    if (sender != nil) {
        _indexPage = 0;
    }
    NSLog(@"self.searchBar.text %@",self.searchBar.text);
    if (!IsStrEmpty(self.searchBar.text)) {
//        if (![self.searchBar.text isEqualToString:oldSearchText]) {
//            [self getDataListRequest];
            [self searchNewsListRequest];
//        }
    }else{
        self.dataSource = [NSMutableArray array];
        [self.tableView reloadData];
    }
//    [self searchNewsListRequest];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = self.dataSource[indexPath.row];
    XWSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newssModel"];
    if (!cell) {
        cell = [[XWSearchViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newssModel"];
    }
    cell.model = model;
//    [cell resetData:model type:HHShowNewsSubTitleCellType];
    
    return cell;
//    if (self.type == 10) {
//        NewsModel *model = self.dataSource[indexPath.row];
//        XWTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newssModel"];
//        if (!cell) {
//            cell = [[XWTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newssModel"];
//        }
//        //    cell.model = self.dataSource[indexPath.row];
//        [cell resetData:model type:HHShowNewsSubTitleCellType];
//
//        return cell;
//    }else{
//        if (self.type == 20) {
//            XWListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeTabd"];
//            if (!cell) {
//                cell = [[XWListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeTabd"];
//            }
//            cell.type = HHShowPictureCellType;
//            cell.cType = self.category==0?1:self.category;
//            cell.serModel = self.dataSource[indexPath.row];
//            return cell;
//        }else{
//            XWListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeTabc"];
//            if (!cell) {
//                cell = [[XWListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeTabc"];
//            }
//            cell.type = HHShowNoPictureCellType;
//            cell.cType = self.category==0?1:self.category;
//            //        cell.dmodel = self.dataSource[indexPath.row];
//            [cell resetDataWith:self.dataSource[indexPath.row] category:self.category];
//            return cell;
//        }
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.type == 10) {
        return 100*kScaleH;
//    }else{
//        return 150*kScaleH;
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsModel *model = self.dataSource[indexPath.row];
    //(0:所有搜索的表,1:新闻,2:服务,3:服务商,4:小微企业,5:需求)
    switch (model.type) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        {
            XWNewsDetailViewController *detailVc = [[XWNewsDetailViewController alloc] init];
            detailVc.model = model;
            [self.navigationController pushViewController:detailVc animated:YES];
        }
            break;
        case 5:
        {
            XWDemandDetailViewController *detailVc = [[XWDemandDetailViewController alloc] init];
            detailVc.model = model;
            [self.navigationController pushViewController:detailVc animated:YES];
        }
            break;
            
        default:
            break;
    }
//    if (self.type == 10) {
//        NewsModel *model = self.dataSource[indexPath.row];
//        XWNewsDetailViewController *detailVc = [[XWNewsDetailViewController alloc] init];
//        detailVc.model = model;
//        [self.navigationController pushViewController:detailVc animated:YES];
//    }else if (self.type == 20){
//        if (![UserModel isLogin]) {
//            [self showLogin];
//            return;
//        }
//        ServiceDetailViewController *sDetailVc = [[ServiceDetailViewController alloc] init];
//        sDetailVc.category = self.category;
//        sDetailVc.model = self.dataSource[indexPath.row];
//        [self.navigationController pushViewController:sDetailVc animated:YES];
//    }else{
//        if (![UserModel isLogin]) {
//            [self showLogin];
//            return;
//        }
//        XWDemandDetailViewController *sDetailVc = [[XWDemandDetailViewController alloc] init];
//        sDetailVc.model = self.dataSource[indexPath.row];
//        [self.navigationController pushViewController:sDetailVc animated:YES];
//    }
    
}
#pragma mark - Delegates
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //字数限制
    //    if ([searchText length] > 20) {
    //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"字数不能超过20" preferredStyle:UIAlertControllerStyleAlert];
    //        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    //        [alertController addAction:alertAction];
    //        [self presentViewController:alertController animated:nil completion:nil];
    //        [_searchBar setText:[searchText substringToIndex:20]];
    //    }
//    [self.tableView reloadData];
//}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"点击了搜索");
    _indexPage = 0;
    [self searchDataRequest:nil];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"请输入内容...";
        
        //    [searchBar setValue:UIColorFromRGB16(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
        [_searchBar setImage:[UIImage imageNamed:@"home_icon_search"]
            forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        //    [searchBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB16(0x99eeeeee)]];
        //        [_searchBar setBackgroundColor:];
        //光标颜色
        [[[_searchBar.subviews objectAtIndex:0].subviews objectAtIndex:1] setTintColor:UIColorFromRGB16(0x999999)];
        //字体颜色
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.textColor = UIColorFromRGB16(0x666666);
        searchField.font = [UIFont rw_regularFontSize:14];
        //    searchField.delegate = self;
        //placeholder颜色
        [searchField setValue:UIColorFromRGB16(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
        //    UIButton *btn = _searchBar.subviews[0].subviews[2];
        //    [btn setTitle:@"取消" forState:UIControlStateNormal];
        //        _searchBar.
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        //设置文本框背景
        [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:_searchBar.bounds.size] forState:UIControlStateNormal];
        [_searchBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
        UIView* backgroundView = [_searchBar subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
        backgroundView.layer.cornerRadius = 5.0f;
        backgroundView.layer.borderWidth = 0.5;
        backgroundView.layer.borderColor = UIColorFromRGB16(0xd2d2d2).CGColor;
        backgroundView.clipsToBounds = YES;
        //        [_searchBar setBackgroundColor:];
        //        _searchBar.barStyle = UIBarStyleDefault;
        //        _searchBar.layer.cornerRadius = 22;
        //        _searchBar.layer.masksToBounds = YES;
    }
    return _searchBar;
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
//        _tableView.scrollEnabled = NO;
        WS(weakSelf);
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                        weakSelf.indexPage = 0;
            [weakSelf searchDataRequest:nil];
        }];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        
        //默认block方法：设置上拉加载更多
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //Call this Block When enter the refresh status automatically
            weakSelf.indexPage += 10;
            [weakSelf searchDataRequest:nil];
        }];
        
        footer.arrowView.image = [UIImage imageWithColor:[UIColor clearColor]];
        footer.stateLabel.hidden = YES;
        _tableView.mj_footer = footer;
        _tableView.tableFooterView = nil;
    }
    return _tableView;
}
- (UIView *)tableFooter{
    return [[NoMoreDataView alloc] init];
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSMutableArray *)newsDataSource{
    if (!_newsDataSource) {
        _newsDataSource = [NSMutableArray array];
    }
    return _newsDataSource;
}
#pragma mark - 获取新闻列表
- (void)searchNewsListRequest{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = YES;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *text = IsStrEmpty(self.searchBar.text)?@"":self.searchBar.text;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValuesForKeysWithDictionary:@{@"region":@"0",
//                                              @"category":@"0",
//                                             @"indexPage":@(_indexPage),
//                                             @"endPage":@(_indexPage+10),
//                                             @"orderType":@"issueTime desc",
//                                             @"text":text
//                                             }];
    NSString *urlString;
    
//    urlString = kGetNewsInfoList;
    urlString = @"/GetSearchListZ";
    [params setValuesForKeysWithDictionary:@{@"uId":[USER_DEFAULT objectForKey:USERIDKEY],
                                             @"t":@(selectType),
                                             @"key":text,
                                             @"indexPage":@(_indexPage),
                                             @"endPage":@(_indexPage+10),
//                                             @"startIndex":@(_indexPage),
//                                             @"endIndex":@(_indexPage+10),
                                             @"orderType":@"ID"
                                             }];
    
    [manager POSTRequestUrlStr:urlString parms:params success:^(id responseData) {
        [self endRefresh];
        NSLog(@"搜索  %@",responseData);
        oldSearchText = self.searchBar.text;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            dataArray = [NewsModel mj_objectArrayWithKeyValuesArray:array];
        }
        if (self.indexPage == 0) {
            self.dataSource = [NSMutableArray arrayWithArray:dataArray];
        }else{
            [self.dataSource addObjectsFromArray:dataArray];
        }
        if (dataArray.count < 10) {
            _tableView.tableFooterView = [self tableFooter];
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.tableFooterView = nil;
            self.tableView.mj_footer.hidden = NO;
        }
        
        if (self.dataSource.count == 0) {
            [MBProgressHUD alertInfo:@"没有相关内容"];
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        [self endRefresh];
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    return indexPath;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar resignFirstResponder];
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
#pragma mark - 获取数据列表
- (void)getDataListRequest {
    NSString *text = IsStrEmpty(self.searchBar.text)?@"":self.searchBar.text;
    
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *urlString;
    if (self.type == 20) {//服务
        urlString = kGetOrgServiceList;
        [params setValuesForKeysWithDictionary:@{@"oId":@"0",
                                                 @"category":@(self.category),
                                                 @"indexPage":@(self.indexPage),
                                                 @"endPage":@(self.indexPage+10),
                                                 @"text":text
                                                 //                                             @"orderType":@"issueTime desc"
                                                 }];
    }else if(self.type == 30){//需求
        urlString = kGetDmdList;
        [params setValuesForKeysWithDictionary:@{@"uId":@0,
                                                 @"auditing":@(-1),//审核状态(-1:所有的,0:待审核,1:审核通过,2:退回)
                                                 @"indexPage":@(self.indexPage),
                                                 @"endPage":@(self.indexPage+10),
                                                 @"category":@(self.category),
                                                 @"text":text
                                                 }];
    }else if(self.type == 10){//新闻
        [params setValuesForKeysWithDictionary:@{@"region":@"0",
                                                 @"category":@"0",
                                                 @"indexPage":@(_indexPage),
                                                 @"endPage":@(_indexPage+10),
                                                 @"orderType":@"issueTime desc",
                                                 @"text":text
                                                 }];
        urlString = kGetNewsInfoList;
    }else if (self.type == 40){//收藏
        [params setValuesForKeysWithDictionary:@{@"uId":[USER_DEFAULT objectForKey:USERIDKEY]
                                                 }];
        urlString = kGetServiceCollect;
    }else{
        urlString = @"/GetSearchListZ";
        [params setValuesForKeysWithDictionary:@{@"uId":[USER_DEFAULT objectForKey:USERIDKEY],
                                                 @"t":@(selectType),
                                                 @"key":text,
                                                 @"indexPage":@(_indexPage),
                                                 @"endPage":@(_indexPage+10),
                                                 @"orderType":@"issueTime desc"
                                                 }];
    }
    if(IsStrEmpty(urlString) || !params){
        [MBProgressHUD alertInfo:@"查询异常，请稍后重试"];
        return;
    }
    [manager POSTRequestUrlStr:urlString parms:params success:^(id responseData) {
        NSLog(@"获取数据  %@",responseData);
        [self endRefresh];
        NSMutableArray *dataArray = [NSMutableArray array];
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                if (self.type == 20) {
                    dataArray = [XWServiceModel mj_objectArrayWithKeyValuesArray:array];
                }else if (self.type == 20) {
                    dataArray = [CommandModel mj_objectArrayWithKeyValuesArray:array];
                }else{
                    dataArray = [NewsModel mj_objectArrayWithKeyValuesArray:array];
                }
            }
        }
        if (_indexPage == 0) {
            self.dataSource = [NSMutableArray arrayWithArray:dataArray];
        }else{
            [self.dataSource addObjectsFromArray:dataArray];
        }
        
        if (self.dataSource.count == 0) {
            self.tableView.tableFooterView = nil;
            self.tableView.mj_footer.hidden = YES;
        }else{
            if (dataArray.count < 10) {
                _tableView.tableFooterView = [[NoMoreDataView alloc] init];
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.tableFooterView = nil;
                self.tableView.mj_footer.hidden = NO;
            }
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        [self endRefresh];
    }];
}
@end
