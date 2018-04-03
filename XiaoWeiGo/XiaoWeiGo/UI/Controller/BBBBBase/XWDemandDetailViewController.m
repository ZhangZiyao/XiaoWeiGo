//
//  XWDemandDetailViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWDemandDetailViewController.h"
//#import "XWCommandCell.h"
#import "XWContactViewController.h"
#import "CommonRequest.h"
#import "CommandModel.h"
#import "XWServiceViewCell.h"
#import "DemandViewCell.h"

@interface XWDemandDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger index;
    CommandModel *dModel;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XWDemandDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"需求详情";
    [self showBackItem];
}
- (void)layoutSubviews{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-90*kScaleH);
    }];
//    [self addBottomView];
    
}
- (void)addBottomView{
    NSArray *array ;
    //    CGFloat width;
    if (APPDELEGATE.user.loginType == 1 || APPDELEGATE.user.loginType == 2) {
        
        array = @[@[@"收藏",@"def_icon_collection"],@[@"联系",@"loan_icon_contact"]];
    }else{
        array = @[@[@"收藏",@"def_icon_collection"]];
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
            CALayer *topLayer = [CALayer layer];
            topLayer.backgroundColor = [UIColor OCRMainColor].CGColor;
            topLayer.frame = CGRectMake(0, 0, ScreenWidth, 0.5);
            [saveBtn.layer addSublayer:topLayer];
        }else{
            [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset((ScreenWidth/2+0.5)*i);
                make.bottom.equalTo(self.view);
                make.height.mas_equalTo(90*kScaleH);
                make.width.mas_equalTo(ScreenWidth/2);
            }];
            CALayer *topLayer = [CALayer layer];
            topLayer.backgroundColor = [UIColor OCRMainColor].CGColor;
            topLayer.frame = CGRectMake(0, 0, ScreenWidth/2, 0.5);
            [saveBtn.layer addSublayer:topLayer];
            if (i == 0) {
                CALayer *rightLayer = [CALayer layer];
                rightLayer.backgroundColor = [UIColor OCRMainColor].CGColor;
                rightLayer.frame = CGRectMake(ScreenWidth/2, 0, 0.5, 90*kScaleH);
                [saveBtn.layer addSublayer:rightLayer];
            }
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
        if (APPDELEGATE.user.loginType == 1 || APPDELEGATE.user.loginType == 2) {
            [MBProgressHUD alertInfo:@"功能正在开发，敬请期待～"];
            //            XWContactViewController *contactVc = [[XWContactViewController alloc] init];
            //            [self.navigationController pushViewController:contactVc animated:YES];
            
        }else{
            [MBProgressHUD alertInfo:@"您没有此权限哦～"];
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sssqsCell"];
    if (!cell) {
        cell = [[DemandViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sssqsCell"];
    }
//    if (dModel) {
//        cell.dmodel = dModel;
//    }
    switch (indexPath.row) {
        case 0:
        {
            cell.titleLabel.text = @"需求标题:";
            cell.detailLabel.text = dModel.dTitle;
        }
            break;
        case 1:
        {
            cell.titleLabel.text = @"需求分类:";
            cell.detailLabel.text = [NSString getCategoryNameWithCategory:dModel.category];
        }
            break;
        case 2:
        {
            cell.titleLabel.text = @"需求内容:";
            cell.detailLabel.text = dModel.dContent;
        }
            break;
        case 3:
        {
            cell.titleLabel.text = @"截止时间:";
            cell.detailLabel.text = dModel.endTime;
        }
            break;
            
        default:
            break;
    }
    
    //    [cell resetCellWithData:@"" andType:index];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        CGFloat cellHeight = [dModel.dContent sizeWithLabelWidth:ScreenWidth-220*kScaleW font:[UIFont rw_regularFontSize:15.0]].height+20;
        return cellHeight;
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
- (void)getDemandInfo{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = YES;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"id":@(self.model.ID)
                                             }];
    [manager POSTRequestUrlStr:kGetDmdInfo parms:params success:^(id responseData) {
        NSLog(@"获取需求详情数据  %@",responseData);
        dModel = [CommandModel mj_objectWithKeyValues:responseData[0]];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDemandInfo];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
