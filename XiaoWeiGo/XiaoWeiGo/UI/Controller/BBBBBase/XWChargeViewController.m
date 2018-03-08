//
//  XWChargeViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWChargeViewController.h"
#import "YUSegment.h"
#import "XWChargeViewCell.h"
#import "CommonRequest.h"
//#import "XWCommonModel.h"
#import "XWServiceModel.h"

@interface XWChargeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger index;
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) YUSegmentedControl *segmentedControl;
@end

@implementation XWChargeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标准收费";
    [self showBackItem];
    index = 1;
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
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 260*kScaleH)];
        _headerView.backgroundColor = bgColor;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180*kScaleH)];
        bgView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:bgView];
        UIImageView *coverImageView = [[UIImageView alloc] init];
        [coverImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"toll_img_avatar"]];
        
        [_headerView addSubview:coverImageView];
        UILabel *orgNameLabel = [[UILabel alloc] init];
        orgNameLabel.textColor = [UIColor textBlackColor];
        orgNameLabel.text = self.commonModel.orgName;
        orgNameLabel.font = [UIFont rw_regularFontSize:15.0];
        [_headerView addSubview:orgNameLabel];
        UIButton *saveBtn = [[UIButton alloc] init];
        [saveBtn setBackgroundColor:[UIColor whiteColor]];
        [saveBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [saveBtn setImage:[UIImage imageNamed:@"def_icon_collection"] forState:UIControlStateNormal];
        [saveBtn setImage:[UIImage imageNamed:@"def_icon_collection_selected"] forState:UIControlStateSelected];
        [saveBtn setTitleColor:mainColor forState:UIControlStateNormal];
        [saveBtn.titleLabel setFont:[UIFont rw_regularFontSize:14.0]];
        [saveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [_headerView addSubview:saveBtn];
        [saveBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headerView).offset(-40*kScaleW);
            make.bottom.equalTo(_headerView).offset(-110*kScaleH);
            make.height.mas_equalTo(50*kScaleH);
            make.width.mas_equalTo(120*kScaleW);
        }];
        [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerView).offset(25*kScaleW);
            make.top.equalTo(_headerView).offset(25*kScaleW);
            make.size.mas_equalTo(CGSizeMake(120*kScaleW, 120*kScaleH));
        }];
        [orgNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverImageView.mas_right).offset(20*kScaleW);
            make.right.equalTo(_headerView).offset(-20*kScaleW);
            make.centerY.equalTo(coverImageView);
        }];
        NSArray *dataArr = @[@"支付宝收费",@"微信支付收费"];
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
- (void)collectBtnClick:(UIButton *)sender{
    if (sender.selected) {
        [MBProgressHUD alertInfo:@"已经收藏过了哦～"];
        return;
    }
    if (![UserModel isLogin]) {
//        [MBProgressHUD alertInfo:@"请先登录"];
        [self showLogin];
        return;
    }
    NSDictionary *params = @{@"uId":[USER_DEFAULT objectForKey:USERIDKEY],
                             @"sId":@(_commonModel.ID)};
    [CommonRequest collectDataWithParams:params block:^(BOOL success) {
        if (success) {
            sender.selected = YES;
        }
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XWChargeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chargeCell"];
    if (!cell) {
        cell = [[XWChargeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chargeCell"];
    }
    [cell resetCellWithData:@"" andType:index];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 850*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8.0f;
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
