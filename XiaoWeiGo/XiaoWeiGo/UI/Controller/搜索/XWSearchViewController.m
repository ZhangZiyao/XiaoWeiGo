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


@interface XWSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *oldSearchText;
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
    self.title = @"文件搜索";
    [self showBackItem];
    oldSearchText = @"";
    self.view.userInteractionEnabled = YES;
}
- (void)layoutSubviews{
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kScaleW);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view).offset(-200*kScaleW);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor colorWithHex:@"edc440"]];
    [searchBtn.titleLabel setFont:[UIFont rw_regularFontSize:15.0]];
    [self.view addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(searchDataRequest) forControlEvents:UIControlEventTouchUpInside];
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
- (void)searchDataRequest{
    [self.searchBar resignFirstResponder];
    NSLog(@"self.searchBar.text %@",self.searchBar.text);
    if (!IsStrEmpty(self.searchBar.text)) {
        if (![self.searchBar.text isEqualToString:oldSearchText]) {
            [self searchNewsListRequest];
        }
    }else{
        self.dataSource = [NSMutableArray array];
        [self.tableView reloadData];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = self.dataSource[indexPath.row];
    XWTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newssModel"];
    if (!cell) {
        cell = [[XWTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newssModel"];
    }
//    cell.model = self.dataSource[indexPath.row];
    [cell resetData:model type:HHShowNewsSubTitleCellType];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsModel *model = self.dataSource[indexPath.row];
    XWNewsDetailViewController *detailVc = [[XWNewsDetailViewController alloc] init];
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
    
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
    [self searchDataRequest];
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
        backgroundView.layer.cornerRadius = 18.0f;
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
        _tableView.scrollEnabled = NO;
        WS(weakSelf);
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                        weakSelf.indexPage = 0;
            [weakSelf searchNewsListRequest];
        }];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        
        //默认block方法：设置上拉加载更多
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //Call this Block When enter the refresh status automatically
            weakSelf.indexPage += 10;
            [weakSelf searchNewsListRequest];
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
    [params setValuesForKeysWithDictionary:@{@"region":@"0",
                                              @"category":@"0",
                                             @"indexPage":@(_indexPage),
                                             @"endPage":@(_indexPage+10),
                                             @"orderType":@"issueTime desc",
                                             @"text":text
                                             }];
    [manager POSTRequestUrlStr:kGetNewsInfoList parms:params success:^(id responseData) {
        [self endRefresh];
        NSLog(@"搜索  %@",responseData);
        oldSearchText = self.searchBar.text;
        
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
        if (_indexPage == 0) {
            self.dataSource = [NSMutableArray arrayWithArray:dataArray];
        }else{
            [self.dataSource addObjectsFromArray:dataArray];
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

@end
