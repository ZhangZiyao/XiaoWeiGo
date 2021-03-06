//
//  XWHomeViewController.m
//  XiaoWei
//
//  Created by dingxin on 2018/1/26.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWHomeViewController.h"
#import "CircleScrollView.h"
#import "HomeTabView.h"
#import "NewsModel.h"
#import "NewsViewCell.h"
#import "XWCommandCell.h"
#import "CommandModel.h"
#import "UIView+Utils.h"
#import "FSCustomButton.h"
#import "HomeCustomView.h"
#import "XWMineViewController.h"
#import "XWLoginViewController.h"
#import "XWLoanViewController.h"
#import "XWBonusViewController.h"
#import "XWDemandViewController.h"
#import "XWLawServiceViewController.h"
#import "XWAccountantController.h"
#import "XWOtherSeviceController.h"
#import "XWBookViewController.h"
#import "XWSearchViewController.h"
#import "XWCreditViewController.h"
#import "XWDiscountViewController.h"
#import "XWExhibitionViewController.h"
#import "XWISOViewController.h"
#import "XWRightsViewController.h"
#import "XWGongshangViewController.h"
#import "XWMoreNewsViewController.h"
#import "XWChuangxinViewController.h"
#import "XWRecommendViewController.h"
#import "XWMoreNewsViewController.h"
#import "XWSearchViewController.h"
#import "XWLoginViewController.h"
#import "XWMineViewController.h"
#import "XWHotNewsViewController.h"
#import "XWHotDemandViewController.h"
#import "DemandReleaseViewController.h"
#import "XWNewsDetailViewController.h"
#import "XWDemandDetailViewController.h"
#import "XWAnnounceViewController.h"
//#import "CCZAngelWalker.h"
//#import "CCZTrotingLabel.h"
#import "XBTextLoopView.h"

@interface XWHomeViewController ()<CircleScrollViewDelegate,UIScrollViewDelegate,HomeTabViewDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,HomeCustomViewDelegate>
{
    NSInteger tagIndex;
}
//@property (nonatomic, strong) CCZTrotingLabel *label;

@property (nonatomic, assign) int pageIndex;

@property (nonatomic, strong) CircleScrollView *circleView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *centerView1;

@property (nonatomic, strong) UIView *centerView2;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *newsDataSource;

@property (nonatomic, strong) NSMutableArray *demandDataSource;

@property (nonatomic, strong) NSMutableArray *announceDataSource;

@property (nonatomic, strong) XBTextLoopView *loopView;

@end

@implementation XWHomeViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([UserModel isLogin]) {
        [UserModel getUserDataBlock:^(BOOL success) {
            
        }];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //// 请务必写上这句话，防止因为控制器切换而不能正常工作
//    [self.label walk];
    [self.loopView walk];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.loopView pause];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"奉化小微加油";
    
    tagIndex = 1;
    _pageIndex = 0;
    [self reloadPageData];
    [self getAnnounceListRequest];
}
- (void)reloadPageData{
    [self getNewsListRequest];
}
- (void)navRightItemClick{
    if ([UserModel isLogin]) {
        XWMineViewController *mineVc = [[XWMineViewController alloc] init];
        [self.navigationController pushViewController:mineVc animated:YES];
    }else{
        XWLoginViewController *loginVc = [[XWLoginViewController alloc] init];
        RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:loginVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
- (void)layoutSubviews{
    [self showRightItemWithItemImage:@"home_icon_user"];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    [self.scrollView addSubview:self.circleView];
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        make.height.mas_equalTo(336*kScaleH);
        make.width.mas_equalTo(ScreenWidth);
    }];
//    self.label = [[CCZTrotingLabel alloc] initWithFrame:CGRectMake(20, 100, 300, 40)];
////    self.label.backgroundImage = [UIImage imageNamed:@"rem_effect"];
//    [self.label addText:@"通知公告：小微加油V2.0正式上线啦～～～"];
////    self.label.pause = 1;
//    self.label.type = CCZWalkerTypeDescend;
//    self.label.rate = RateFast;
//    [self.view addSubview:self.label];
    
    WS(weakSelf);
    _loopView = [XBTextLoopView textLoopViewWith:@[@"小微加油V2.0正式上线啦～～～"] loopInterval:3.0 initWithFrame:CGRectMake(0, 0, ScreenWidth, 40) selectBBlock:^(NSString *selectString, NSInteger index) {
//        NSLog(@"%@===index%ld", selectString, index);
        XWAnnounceViewController *announceVc = [[XWAnnounceViewController alloc] init];
        announceVc.AID = [[weakSelf.announceDataSource[index] objectForKey:@"ID"] intValue];
        [weakSelf.navigationController pushViewController:announceVc animated:YES];
    }];
    
    [self.scrollView addSubview:_loopView];
    UIImageView *imageI = [[UIImageView alloc] init];
    imageI.image = [UIImage imageNamed:@"ico_notice"];
    [self.scrollView addSubview:imageI];
    UILabel *label = [RWFactionUI createLabelWith:CGRectMake(0, 0, 200, 40) text:@"通知公告：" textColor:UIColorFromRGB16(0x666666) textFont:[UIFont rw_regularFontSize:15.0] textAlignment:NSTextAlignmentLeft];
    [self.scrollView addSubview:label];
    [self.loopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.top.equalTo(self.circleView.mas_bottom).offset(5*kScaleH);
        make.right.equalTo(self.scrollView);
        make.height.mas_equalTo(40);
    }];
    [imageI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(5);
        make.centerY.equalTo(self.loopView);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageI.mas_right).offset(5);
        make.centerY.equalTo(self.loopView);
    }];
    [self.scrollView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(20);
        make.top.equalTo(self.loopView.mas_bottom).offset(5*kScaleH);
        make.right.equalTo(self.scrollView).offset(-20*kScaleW);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(ScreenWidth-40*kScaleW);
        
    }];
    
    HomeTabView *tab = [[HomeTabView alloc] init];
    tab.delegate = self;
    [self.scrollView addSubview:tab];
    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom).offset(5*kScaleH);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo([HomeTabView height]);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
    }];
    
    [self.scrollView addSubview:self.centerView1];
    [self.centerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tab.mas_bottom).offset(10*kScaleH);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(200*kScaleH);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
    }];
    
    [self.scrollView addSubview:self.centerView2];
    [self.centerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView1.mas_bottom).offset(10*kScaleH);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(110*kScaleH);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
    }];
    
    [self.scrollView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        make.bottom.equalTo(self.scrollView);
        make.top.equalTo(self.centerView2.mas_bottom).offset(10*kScaleH);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(64*kScaleH+90*kScaleH);
    }];
    
    
}
#pragma mark -
- (void)reloadData{
    CGFloat cellHeight;
    if (tagIndex == 1) {
        cellHeight = 120*kScaleH;
    }else{
        cellHeight = 150*kScaleH;
    }
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        make.bottom.equalTo(self.scrollView);
        make.top.equalTo(self.centerView2.mas_bottom).offset(10*kScaleH);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(self.dataSource.count*cellHeight+64*kScaleH+90*kScaleH);
    }];
    
//    self.scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight*2);
    
    [self.tableView reloadData];
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

- (UIView *)centerView1{
    if (!_centerView1) {
        _centerView1 = [[UIView alloc] init];
        _centerView1.backgroundColor = [UIColor whiteColor];
        
//        NSArray *array = @[@[@"政策红利",@"各种扶持政策",@"FD6101",@"home_img_policy"],@[@"信用信息公示",@"登录后查看",@""],@[@"",@"",@""]];
        HomeCustomView *view1 = [[HomeCustomView alloc] init];
        view1.delegate = self;
        view1.tag = 1010;
//        view1.linePosition = CustomLinePositionRight;
        view1.imagePosition = CustomImagePositionFirst;
        view1.titleLabel.text = @"政策红利";
        view1.titleLabel.textColor = UIColorFromRGB16(0xFD6101);
        view1.detailLabel.text = @"各种扶持政策";
        view1.smallImageView.image = [UIImage imageNamed:@"home_img_policy"];
//        view1
        [_centerView1 addSubview:view1];
        
        HomeCustomView *view2 = [[HomeCustomView alloc] init];
//        view2.linePosition = CustomLinePositionBottom;
        view2.delegate = self;
        view2.tag = 1011;
        view2.imagePosition = CustomImagePositionTopEdge0;
        view2.titleLabel.text = @"小微企业名录";
        view2.titleLabel.textColor = UIColorFromRGB16(0xf4ba27);
        view2.detailLabel.text = @"奉化名录";
        view2.smallImageView.image = [UIImage imageNamed:@"home_img_book"];
        [_centerView1 addSubview:view2];
//        HomeCustomView *view3 = [[HomeCustomView alloc] init];
//        view3.delegate = self;
//        view3.tag = 1012;
////        view3.linePosition = CustomLinePositionTop;
//        view3.imagePosition = CustomImagePositionCenter;
//        view3.titleLabel.text = @"小微企业名录";
//        view3.titleLabel.textColor = UIColorFromRGB16(0X0CA6AE);
//        view3.detailLabel.text = @"奉化名录";
//        view3.smallImageView.image = [UIImage imageNamed:@"home_img_list"];
//        [_centerView1 addSubview:view3];
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
            make.bottom.equalTo(_centerView1);
        }];
//        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_centerView1);
//            make.bottom.equalTo(_centerView1);
//            make.width.mas_equalTo(ScreenWidth/2);
//            make.height.mas_equalTo(100*kScaleH);
//        }];
        
    }
    return _centerView1;
}
- (UIView *)centerView2{
    if (!_centerView2) {
        _centerView2 = [[UIView alloc] init];
        _centerView2.backgroundColor = [UIColor whiteColor];
        HomeCustomView *view1 = [[HomeCustomView alloc] init];
        view1.delegate = self;
        view1.tag = 1013;
//        view1.linePosition = CustomLinePositionRight;
        view1.imagePosition = CustomImagePositionTopEdge0;
        view1.titleLabel.text = @"发布需求";
        view1.titleLabel.textColor = UIColorFromRGB16(0x1F6DCC);
        view1.detailLabel.text = @"企业发布需求";
        view1.smallImageView.image = [UIImage imageNamed:@"home_img_demandd"];
        [_centerView2 addSubview:view1];
        HomeCustomView *view2 = [[HomeCustomView alloc] init];
        view2.delegate = self;
        view2.tag = 1014;
        view2.imagePosition = CustomImagePositionTopEdge0;
        view2.titleLabel.text = @"推荐机构";
        view2.titleLabel.textColor = UIColorFromRGB16(0xFF6666);
        view2.detailLabel.text = @"优秀企业推荐";
        view2.smallImageView.image = [UIImage imageNamed:@"home_img_recommend"];
        [_centerView2 addSubview:view2];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_centerView2);
            make.top.equalTo(_centerView2);
            make.bottom.equalTo(_centerView2);
            make.width.mas_equalTo(ScreenWidth/2);
        }];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_centerView2);
            make.top.equalTo(_centerView2);
            make.bottom.equalTo(_centerView2);
            make.width.mas_equalTo(ScreenWidth/2);
        }];
        
    }
    return _centerView2;
}
- (void)tapAction:(int)tag{
    XWBaseViewController *pageVc;
    switch (tag) {
        case 1010:
        {
            //政策红利
            pageVc = [[XWBonusViewController alloc] init];
        }
            break;
        case 1011:
        {
            //小微企业名录
            if ([UserModel isLogin]) {
                pageVc = [[XWBookViewController alloc] init];
            }else{
                //                [MBProgressHUD alertInfo:@"请先登录～"];
                //                XWLoginViewController *loginVc = [[XWLoginViewController alloc] init];
                //                RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:loginVc];
                //                [self presentViewController:nav animated:YES completion:nil];
                [self showLogin];
            }
            //信用信息公示
//            if ([UserModel isLogin]) {
//                pageVc = [[XWCreditViewController alloc] init];
//            }else{
////                [MBProgressHUD alertInfo:@"请先登录～"];
////                XWLoginViewController *loginVc = [[XWLoginViewController alloc] init];
////                RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:loginVc];
////                [self presentViewController:nav animated:YES completion:nil];
//                [self showLogin];
//            }
        }
            break;
        case 1012:
        {
            //小微企业名录
            if ([UserModel isLogin]) {
                pageVc = [[XWBookViewController alloc] init];
            }else{
//                [MBProgressHUD alertInfo:@"请先登录～"];
//                XWLoginViewController *loginVc = [[XWLoginViewController alloc] init];
//                RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:loginVc];
//                [self presentViewController:nav animated:YES completion:nil];
                [self showLogin];
            }
        }
            break;
        case 1013:
        {
            //发布需求
            if ([UserModel isLogin]) {
                if (APPDELEGATE.user.loginType == 3 || APPDELEGATE.user.loginType == 2) {
                    pageVc = [[DemandReleaseViewController alloc] init];
                }else{
                    [MBProgressHUD alertInfo:@"您没有此权限哦～"];
                    return;
                }
            }else{
//                [MBProgressHUD alertInfo:@"请先登录～"];
//                XWLoginViewController *loginVc = [[XWLoginViewController alloc] init];
//                RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:loginVc];
//                [self presentViewController:nav animated:YES completion:nil];
                [self showLogin];
            }
        }
            break;
        case 1014:
        {
            //推荐机构
            if ([UserModel isLogin]) {
                pageVc = [[XWRecommendViewController alloc] init];
            }else{
                [self showLogin];
            }

        }
            break;
            
        default:
            break;
    }
    if (pageVc) {
        [self.navigationController pushViewController:pageVc animated:YES];
    }
}
#pragma mark - Delegates
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    XWSearchViewController *searchVc = [[XWSearchViewController alloc] init];
    searchVc.type = 10;
    [self.navigationController pushViewController:searchVc animated:YES];
    
    return [_searchBar resignFirstResponder];
}

- (void)didClickButton:(UIButton *)button tag:(int)tag{
    NSLog(@"%@",button.currentTitle);
    XWBaseViewController *pageVc;
    switch (tag-1008600) {
        case 0:
        {
            if ([NSString ifOutOfDateTime:[NSString ymdhDateToDateString:[NSDate date]] andEndDate:kCheckDate]) {
                pageVc = [XWBonusViewController new];
            }else{
                pageVc = [XWLoanViewController new];
            }
            
        }
            break;
        case 1:
        {
            pageVc = [XWChuangxinViewController new];
        }
            break;
        case 2:
        {
            pageVc = [XWRightsViewController new];
        }
            break;
        case 3:
        {
            pageVc = [XWAccountantController new];
        }
            break;
        case 4:
        {
           pageVc = [XWLawServiceViewController new];
        }
            break;
        case 5:
        {
            pageVc = [XWDiscountViewController new];
        }
            break;
        case 6:
        {
            pageVc = [XWISOViewController new];
        }
            break;
        case 7:
        {
            pageVc = [XWExhibitionViewController new];
        }
            break;
        case 8:
        {
            pageVc = [XWGongshangViewController new];
        }
            break;
        case 9:
        {
            pageVc = [XWOtherSeviceController new];
        }
            break;
            
        default:
            break;
    }
    if (pageVc) {
        [self.navigationController pushViewController:pageVc animated:YES];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tagIndex == 1) {
        NewsModel *model = self.dataSource[indexPath.row];
        NewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsModel"];
        if (!cell) {
            cell = [[NewsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newsModel"];
        }
//        cell.model = self.dataSource[indexPath.row];
        [cell resetDataWithModel:model type:XWNewsPictureCellType];
        return cell;
    }else{
//        XWCommandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demandCell"];
//        if (!cell) {
//            cell = [[XWCommandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"demandCell"];
//        }
//        cell.model = self.dataSource[indexPath.row];
//        return cell;
        XWListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeTabc"];
        if (!cell) {
            cell = [[XWListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeTabc"];
        }
        cell.type = HHShowNoPictureCellType;
        //        cell.dmodel = self.dataSource[indexPath.row];
        [cell resetDataWith:self.dataSource[indexPath.row] category:0];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tagIndex == 1) {
        return 120*kScaleH;
    }else{
        return 150*kScaleH;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 90*kScaleH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90*kScaleH)];
    footerView.backgroundColor = bgColor;
    UILabel *label = [[UILabel alloc] initWithFrame:footerView.bounds];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont rw_regularFontSize:11.0];
    label.text = @"奉化区小微办 奉化区市场监管局 版权所有";
    [footerView addSubview:label];
    return footerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tagIndex == 1) {
        NewsModel *model = self.dataSource[indexPath.row];
        XWNewsDetailViewController *detailVc = [[XWNewsDetailViewController alloc] init];
        detailVc.model = model;
        [self.navigationController pushViewController:detailVc animated:YES];
    }else{
        XWDemandDetailViewController *sDetailVc = [[XWDemandDetailViewController alloc] init];
        sDetailVc.model = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:sDetailVc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 66*kScaleH;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 66*kScaleH)];
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(182*kScaleW*2, 66*kScaleH-0.5, ScreenWidth, 0.5)];
    line.backgroundColor = LineColor;
    [headerView addSubview:line];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 182*kScaleW, 66*kScaleH)];
    btn.tag = 1;
    [btn setImage:[UIImage imageNamed:@"home_img_popular"] forState:UIControlStateNormal];
    [headerView addSubview:btn];
    [btn addTarget:self action:@selector(changeTagWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), 0, 182*kScaleW, 66*kScaleH)];
    btn1.tag = 2;
    [btn1 setImage:[UIImage imageNamed:@"home_img_demand"] forState:UIControlStateNormal];
    [headerView addSubview:btn1];
    [btn1 addTarget:self action:@selector(changeTagWithBtn:) forControlEvents:UIControlEventTouchUpInside];
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
#pragma mark - 热门新闻和最新需求按钮点击切换
- (void)changeTagWithBtn:(UIButton *)sender{
    tagIndex = sender.tag;
    [self reloadPageData];
}

#pragma mark - 查看更多
- (void)readMore{
    if (tagIndex == 1) {
        XWHotNewsViewController *moreVc = [[XWHotNewsViewController alloc] init];
        moreVc.categoryId = 0;
        [self.navigationController pushViewController:moreVc animated:YES];
    }else{
        XWHotDemandViewController *moreVc = [[XWHotDemandViewController alloc] init];
        moreVc.categoryId = 0;
        [self.navigationController pushViewController:moreVc animated:YES];
    }
}
#pragma mark - 构建广告滚动视图
- (CircleScrollView *)circleView{
    if (!_circleView) {
        _circleView = [[CircleScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 417*kScaleH)];
        //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
        _circleView.placeholderImage = [UIImage imageNamed:@"home_img_banner1"];
        //设置图片数组及图片描述文字
        _circleView.imageArray = @[@"home_img_banner1",@"home_img_banner2"];
        //用代理处理图片点击
        _circleView.delegate = self;
        //设置每张图片的停留时间，默认值为5s，最少为2s
        _circleView.time = 4;
        //设置分页控件的颜色
        [_circleView setPageColor:[UIColor whiteColor] andCurrentPageColor:UIColorFromRGB16(0x8ad8ee)];
        //设置分页控件的位置，默认为PositionBottomCenter
        _circleView.pagePosition = PositionBottomCenter;
        
    }
    return _circleView;
}
- (void)circleScrollView:(CircleScrollView *)circlelView clickImageAtIndex:(NSInteger)index{
    NSLog(@"点击了第%ld条广告",(long)index);
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = bgColor;
        _scrollView.delegate = self;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(0, ScreenHeight*2);
        WS(weakSelf);
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.pageIndex = 0;
            [weakSelf getNewsListRequest];
        }];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        
        _scrollView.mj_header = header;
    }
    return _scrollView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 0) {
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
    }

    if (scrollView.contentOffset.x > 0) {
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
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
        _tableView.scrollEnabled = NO;
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
- (NSMutableArray *)demandDataSource{
    if (!_demandDataSource) {
        _demandDataSource = [NSMutableArray array];
    }
    return _demandDataSource;
}
#pragma mark - 获取新闻列表
- (void)getNewsListRequest{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *urlString;
    if (tagIndex == 1) {
        urlString = kGetNewsInfoList;
        [params setValuesForKeysWithDictionary:@{@"region":@"0",
                                                 @"category":@"0",
                                                 @"indexPage":@(_pageIndex),
                                                 @"endPage":@(_pageIndex+4),
                                                 @"orderType":@"issueTime desc",
                                                 @"text":@""
                                                 }];
    }else{
        urlString = kGetDmdList;
        [params setValuesForKeysWithDictionary:@{@"uId":@0,
                                                 @"auditing":@(-1),//审核状态(-1:所有的,0:待审核,1:审核通过,2:退回)
                                                 @"indexPage":@(_pageIndex),
                                                 @"endPage":@(_pageIndex+4),
                                                 @"category":@0
                                                 }];
    }
    
    [manager POSTRequestUrlStr:urlString parms:params success:^(id responseData) {
        [self.scrollView.mj_header endRefreshing];
        NSLog(@"首页  %@",responseData);
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                if (tagIndex == 1) {
                    self.newsDataSource = [NewsModel mj_objectArrayWithKeyValuesArray:array];
                    self.dataSource = [NSMutableArray arrayWithArray:self.newsDataSource];
                }else{
                    self.demandDataSource = [CommandModel mj_objectArrayWithKeyValuesArray:array];
                    self.dataSource = [NSMutableArray arrayWithArray:self.demandDataSource];
                }
            }else{
                self.dataSource = [NSMutableArray array];
            }
        }else{
            self.dataSource = [NSMutableArray array];
        }
        [self reloadData];
    } fail:^(NSError *error) {
        [self.scrollView.mj_header endRefreshing];
    }];
}

#pragma mark - 获取公告
- (void)getAnnounceListRequest{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *urlString = kGetNoticeListZ;
    [params setValuesForKeysWithDictionary:@{@"indexPage":@(_pageIndex),
                                             @"endPage":@(_pageIndex+4),
                                             @"orderType":@"ID desc"
                                             }];
    [manager POSTRequestUrlStr:urlString parms:params success:^(id responseData) {
//        [self.scrollView.mj_header endRefreshing];
        NSLog(@"首页公告  %@",responseData);
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                self.announceDataSource = [NSMutableArray arrayWithArray:responseData];
                [_loopView setDataSource:@[[array[0] objectForKey:@"nTitle"]]];
            }
        }else{
            
        }
//        [self reloadData];
    } fail:^(NSError *error) {
//        [self.scrollView.mj_header endRefreshing];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
