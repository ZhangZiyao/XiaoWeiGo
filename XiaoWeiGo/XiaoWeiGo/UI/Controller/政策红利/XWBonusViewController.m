//
//  XWBonusViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBonusViewController.h"
#import "XWTextViewCell.h"
#import "BonusHeaderView.h"
#import "NewsModel.h"
#import "XWBonusCenterView.h"
#import "XWNewsDetailViewController.h"

@interface XWBonusViewController ()<UITableViewDelegate,UITableViewDataSource,BonusTabViewDelegate,BonusCenterViewDelegate>
{
    UIButton *centerSelectedBtn;
    int region;
    int category;
}
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) XWBonusCenterView *centerView;
@end

@implementation XWBonusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"政策红利";
    [self showBackItem];
    _pageIndex = 0;
    region = 1;
    category = 1;
    [self requestNewsList];
}
- (void)layoutSubviews{
    
    BonusHeaderView *tab = [[BonusHeaderView alloc] init];
    tab.delegate = self;
//    tab.dataArray = @[@[@"icon_central1",@"中央政府"],@[@"icon_province2",@"浙江省级"],@[@"icon_city3",@"宁波市级"],@[@"icon_area4",@"奉化区级"]];
    [self.view addSubview:tab];
    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10*kScaleH);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(160*kScaleH);
    }];
//    [self addCenterView];
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(190*kScaleH);
        make.height.mas_equalTo(70*kScaleH);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(265*kScaleH);
        make.bottom.equalTo(self.view);
    }];
    
}
- (void)didClickCenterButton:(UIButton *)button tag:(int)tag{
    
    category = tag;
    [self requestNewsList];
    
}
- (XWBonusCenterView *)centerView{
    if (!_centerView) {
        _centerView = [[XWBonusCenterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70*kScaleH)];
        [_centerView resetDataWithRegion:1];
        _centerView.delegate = self;
    }
    return _centerView;
}
//- (void)addCenterView{

//    _centerView = [[XWBonusCenterView alloc] init];
//    [self.view addSubview:_centerView];
//    UIView *centerView = [[UIView alloc] init];
//    centerView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:centerView];
//    NSArray *array = @[@[@"国务院文件",@"法律法规",@"部门文件"],@[@"省各部门文件",@"省地方法规",@"省政府文件"],@[@"市政府文件",@"市政府各部门文件",@"市级地方性法规"],@[@"区政府文件",@"区政府各部门文件"]];
//    CGFloat width = 120*kScaleW;
////    CGFloat height = 40*kScaleH;
//    for (int i = 0; i < [array[region] count]; i++) {
//        UIButton *btn = [[UIButton alloc] init];
//        btn.tag = i;
//        btn.adjustsImageWhenHighlighted = NO;
//        [btn setTitle:array[region][i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [btn.titleLabel setFont:[UIFont rw_regularFontSize:12]];
//        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB16(0x1aa4ec)] forState:UIControlStateSelected];
//        btn.layer.cornerRadius = 3;
//        btn.layer.masksToBounds = YES;
//        [centerView addSubview:btn];
//        [btn addTarget:self action:@selector(centerViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(centerView).offset(135*kScaleW+(width+60*kScaleW)*i);
//            make.size.mas_equalTo(CGSizeMake(width, 40*kScaleH));
//            make.centerY.equalTo(centerView);
//        }];
//        if (i == 0) {
//            btn.selected = YES;
//            centerSelectedBtn = btn;
//            region = i+1;
//        }
//    }
//    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.top.equalTo(self.view).offset(190*kScaleH);
//        make.height.mas_equalTo(70*kScaleH);
//    }];
//}
//- (void)centerViewBtnClick:(UIButton *)sender{
//    if (sender  != centerSelectedBtn) {
//        centerSelectedBtn.selected = NO;
//        sender.selected = YES;
//        centerSelectedBtn = sender;
//        region = (int)sender.tag+1;
//        [self requestNewsList];
//    }
//}
- (void)didClickButton:(UIButton *)button tag:(int)tag{
    NSLog(@"%d  %@",tag,button.currentTitle);
    region = (int)button.tag-1008600+1;
    [self.centerView resetDataWithRegion:region];
    [self requestNewsList];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"bonus";
    NewsModel *model = self.dataSource[indexPath.row];
    XWTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[XWTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.titleLabel.text = model.aTitle;
    cell.detailLabel.text = IsStrEmpty(model.subTitle)?model.issueTime:model.subTitle;;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
//    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20*kScaleH;
    }else{
        return 10*kScaleH;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsModel *model = self.dataSource[indexPath.row];
    XWNewsDetailViewController *detailVc = [[XWNewsDetailViewController alloc] init];
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
#pragma mark -  获取新闻列表
- (void)requestNewsList{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"region":@(region),//地域(如果为0即所有地域)
                                             @"category":@(category),//类别(如果为0即所有分类)
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
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
