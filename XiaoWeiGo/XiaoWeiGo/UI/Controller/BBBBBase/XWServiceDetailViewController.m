//
//  XWServiceDetailViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWServiceDetailViewController.h"
#import "XWContactViewController.h"
#import "CommonRequest.h"
#import "XWDisDetailViewController.h"
#import "XWDownFileViewController.h"
#import "XWServiceDetailSecViewController.h"
#import "XWChargeViewController.h"
#import "XWServiceModel.h"
#import "XWTextViewCell.h"
#import "YUSegment.h"
#import "XWServiceViewCell.h"
#import "XWApplyLoanViewController.h"
#import "XWMapViewController.h"

@interface XWServiceDetailViewController ()<UITableViewDataSource, UITableViewDelegate,YUSegmentedControlDelegate>
{
    NSInteger index;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) YUSegmentedControl *segmentedControl;
@end

@implementation XWServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务详情";
    [self showBackItem];
}
- (void)didSelectedAtIndex:(NSUInteger)newIndex didDeselectAtIndex:(NSUInteger)oldIndex{
    if (newIndex == 0) {
        XWDisDetailViewController *discountVc = [[XWDisDetailViewController alloc] init];
        [self.navigationController pushViewController:discountVc animated:YES];
    }else{
        XWDownFileViewController *downVc = [[XWDownFileViewController alloc] init];
        [self.navigationController pushViewController:downVc animated:YES];
    }
}
- (void)segmentedControlTapped:(YUSegmentedControl *)sender {
    NSLog(@" %ld",sender.selectedSegmentIndex);
    index = sender.selectedSegmentIndex+1;
}
- (void)layoutSubviews{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-90*kScaleH);
    }];
    self.tableView.tableHeaderView = self.headerView;
    [self addBottomView];
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 290*kScaleH)];
        _headerView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString getImageNameWithCategory:self.model.category]];
        [_headerView addSubview:imageView];
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = navColor;
        [_headerView addSubview:line];
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString ifNull:self.model.sTitle];
        [_headerView addSubview:label];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView).offset(40*kScaleH);
            make.centerX.equalTo(_headerView);
            make.size.mas_equalTo(CGSizeMake(100*kScaleW, 100*kScaleH));
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(20*kScaleH);
            make.left.equalTo(_headerView).offset(30*kScaleH);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(30*kScaleH);
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line.mas_right).offset(20*kScaleH);
            make.right.equalTo(_headerView).offset(-30*kScaleH);
            make.centerY.equalTo(line);
        }];
        
        NSArray *dataArr = @[@"优惠政策",@"附件下载"];
        _segmentedControl = [[YUSegmentedControl alloc] initWithTitles:dataArr];
        _segmentedControl.delegate = self;
        _segmentedControl.normalTextColor = navColor;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.showsIndicator = NO;
        _segmentedControl.showsVerticalDivider = YES;
        _segmentedControl.showsTopSeparator = NO;
        _segmentedControl.showsBottomSeparator = NO;
//        [_segmentedControl addTarget:self action:@selector(segmentedControlTapped:) forControlEvents:UIControlEventValueChanged];
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
- (void)addBottomView{
    NSArray *array ;
//    CGFloat width;
    if (APPDELEGATE.user.loginType == 3) {
        array = @[@[@"收藏",@"def_icon_collection"]];
    }else{
        array = @[@[@"收藏",@"def_icon_collection"],@[@"联系",@"loan_icon_contact"]];
    }
    for (int i = 0; i < array.count; i++) {
        UIButton *saveBtn = [[UIButton alloc] init];
        saveBtn.tag = i;
        [saveBtn setBackgroundColor:[UIColor whiteColor]];
        [saveBtn setTitle:array[i][0] forState:UIControlStateNormal];
        [saveBtn setImage:[UIImage imageNamed:array[i][1]] forState:UIControlStateNormal];
        if (i == 0) {
            [saveBtn setImage:[UIImage imageNamed:@"def_icon_collection_selected"] forState:UIControlStateSelected];
        }
        [saveBtn setTitleColor:mainColor forState:UIControlStateNormal];
        [saveBtn.titleLabel setFont:[UIFont rw_regularFontSize:14.0]];
        [saveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.view addSubview:saveBtn];
        [saveBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (array.count == 1) {
            [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view);
                make.right.equalTo(self.view);
                make.bottom.equalTo(self.view);
                make.height.mas_equalTo(90*kScaleH);
            }];
        }else{
            [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset((ScreenWidth/2+0.5)*i);
                make.bottom.equalTo(self.view);
                make.height.mas_equalTo(90*kScaleH);
                make.width.mas_equalTo(ScreenWidth/2);
            }];
        }
        CALayer *topLayer = [CALayer layer];
        topLayer.backgroundColor = [UIColor colorWithHex:@"e2e2e2"].CGColor;
        topLayer.frame = CGRectMake(0, 0, ScreenWidth/2, 0.5);
        [saveBtn.layer addSublayer:topLayer];
        if (i == 0) {
            CALayer *rightLayer = [CALayer layer];
            rightLayer.backgroundColor = [UIColor colorWithHex:@"e2e2e2"].CGColor;
            rightLayer.frame = CGRectMake(ScreenWidth/2, 0, 0.5, 90*kScaleH);
            [saveBtn.layer addSublayer:rightLayer];
        }
        saveBtn.layer.masksToBounds = YES;
    }
}
#pragma mark -
- (void)bottomBtnClick:(UIButton *)sender{
    if (sender.tag == 0) {
        if (sender.selected) {
            [MBProgressHUD alertInfo:@"已经收藏过了哦～"];
            return;
        }
        //收藏
        if (![UserModel isLogin]) {
//            [MBProgressHUD alertInfo:@"请先登录"];
            [self showLogin];
            return;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValuesForKeysWithDictionary:@{@"uId":[USER_DEFAULT objectForKey:USERIDKEY],
                                                 @"sId":@(self.model.ID)//机构表ID
                                                 }];
        [CommonRequest collectDataWithParams:params block:^(BOOL success) {
            if (success) {
                sender.selected = YES;
            }
        }];
    }else{
        //联系
        if (APPDELEGATE.user.loginType == 3) {
            [MBProgressHUD alertInfo:@"您没有此权限哦～"];
        }else{
            XWContactViewController *contactVc = [[XWContactViewController alloc] init];
            [self.navigationController pushViewController:contactVc animated:YES];
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        XWServiceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sssqsCell"];
        if (!cell) {
            cell = [[XWServiceViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sssqsCell"];
        }
        cell.cmodel = self.model;
        //    [cell resetCellWithData:@"" andType:index];
        return cell;
    }else{
        if (self.model.category == 1) {
            if (indexPath.section == 1) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orders222"];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orders222"];
                }
                UIButton *commitBtn = [[UIButton alloc] init];
                [commitBtn setBackgroundImage:[UIImage imageNamed:@"loan_icon_button_bg"] forState:UIControlStateNormal];
                [commitBtn setTitle:@"我要申请" forState:UIControlStateNormal];
                [commitBtn.titleLabel setFont:[UIFont rw_regularFontSize:14.0]];
                [commitBtn addTarget:self action:@selector(commitLoanRequest) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:commitBtn];
                [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(cell.contentView);
                    make.centerY.equalTo(cell.contentView);
                    make.height.mas_equalTo(70*kScaleH);
                    make.width.mas_equalTo(ScreenWidth/2.0);
                }];
                return cell;
            }else{
                XWTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orders22"];
                if (!cell) {
                    cell = [[XWTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orders22"];
                }
                cell.bottomLine.hidden = YES;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                if (indexPath.section == 2){
                    cell.titleLabel.text = [NSString stringWithFormat:@"标准收费：%@ 元",self.model.price];
                }else if (indexPath.section == 3){
                    cell.titleLabel.text = [NSString stringWithFormat:@"服务机构：%@",self.model.orgName];
                }else if (indexPath.section == 4){
                    cell.titleLabel.text = [NSString stringWithFormat:@"地址：%@",self.model.sAddress];
                }else{
                    
                }
                return cell;
            }
        }else{
            XWTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orders22"];
            if (!cell) {
                cell = [[XWTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orders22"];
            }
            cell.bottomLine.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.section == 1){
                cell.titleLabel.text = [NSString stringWithFormat:@"标准收费：%@ 元",self.model.price];
            }else if (indexPath.section == 2){
                cell.titleLabel.text = [NSString stringWithFormat:@"服务机构：%@",self.model.orgName];
            }else if (indexPath.section == 3){
                cell.titleLabel.text = [NSString stringWithFormat:@"地址：%@",self.model.sAddress];
            }else{
                
            }
            return cell;
        }
    }
    
}
#pragma mark -
- (void)commitLoanRequest{
    XWApplyLoanViewController *detailVc = [[XWApplyLoanViewController alloc] init];
    detailVc.model = self.model;
    [self.navigationController pushViewController:detailVc animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.model.category == 1) {
        if (indexPath.section == 2) {
            XWChargeViewController *serVc = [[XWChargeViewController alloc] init];
            serVc.commonModel = self.model;
            [self.navigationController pushViewController:serVc animated:YES];
        }else if (indexPath.section == 3){
            XWServiceDetailSecViewController *serVc = [[XWServiceDetailSecViewController alloc] init];
            serVc.model = self.model;
            [self.navigationController pushViewController:serVc animated:YES];
        }else if(indexPath.section == 4) {
            XWMapViewController *page = [XWMapViewController new];
            [self.navigationController pushViewController:page animated:YES];
        }
    }else{
        if (indexPath.section == 1) {
            XWChargeViewController *serVc = [[XWChargeViewController alloc] init];
            serVc.commonModel = self.model;
            [self.navigationController pushViewController:serVc animated:YES];
        }else if (indexPath.section == 2){
            XWServiceDetailSecViewController *serVc = [[XWServiceDetailSecViewController alloc] init];
            serVc.model = self.model;
            [self.navigationController pushViewController:serVc animated:YES];
        }else if(indexPath.section == 3){
            XWMapViewController *page = [XWMapViewController new];
            [self.navigationController pushViewController:page animated:YES];
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.model.category == 1) {
        return 5;
    }else{
        return 4;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.model.category == 1) {
            return 520*kScaleH;
        }else{
            return 440*kScaleH;
        }
    }else{
        return 100*kScaleH;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
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
