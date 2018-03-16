//
//  ServiceDetailViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "ServiceDetailViewController.h"
#import "YUSegment.h"
#import "XWMapViewController.h"
#import "XWQRCodeViewController.h"
#import "XWWeChatViewController.h"
#import "XWOrgInfoViewCell.h"
#import "CompanyModel.h"
#import "CommonRequest.h"
#import "XWServiceDetailViewController.h"
#import "XWQQViewController.h"
#import "XWCommentCell.h"
#import "XWCommentModel.h"
#import "XWServiceModel.h"
#import "XWCommentHeaderView.h"
#import "XWCommentFooterView.h"
#import "XWCommentInfoModel.h"
#import "XHInputView.h"

@interface ServiceDetailViewController ()<UITableViewDataSource, UITableViewDelegate,XWOrgInfoCellDelegate,XHInputViewDelagete>
{
    NSInteger index;
    BOOL isReply;
    XWCommentModel *currentModel;
}
@property (nonatomic, strong) XWServiceModel *cmodel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YUSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIButton *publishBtn;

@end

@implementation ServiceDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString getCategoryNameWithCategory:self.category];
    [self showBackItem];
    index = 0;
    
    [self getOrgDetail];
    [self getCommentDetail];
    [self layoutSubviews];
}
- (void)segmentedControlTapped:(YUSegmentedControl *)sender {
    NSLog(@" %ld",sender.selectedSegmentIndex);
    index = sender.selectedSegmentIndex;
    if (index == 0) {
        self.tableView.tableFooterView.hidden = NO;
        self.publishBtn.hidden = YES;
    }else{
        self.tableView.tableFooterView.hidden = YES;
        self.publishBtn.hidden = NO;
    }
    [self.tableView reloadData];
}

- (void)layoutSubviews{
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"registered_icon_top"];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(185*kScaleH);
    }];
    
    NSArray *dataArr = @[@"服务详情",@"产品评价"];
    _segmentedControl = [[YUSegmentedControl alloc] initWithTitles:dataArr];
    _segmentedControl.backgroundColor = bgColor;
    _segmentedControl.showsIndicator = YES;
    _segmentedControl.showsBottomSeparator = YES;
    _segmentedControl.showsTopSeparator = YES;
    [_segmentedControl addTarget:self action:@selector(segmentedControlTapped:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(185*kScaleH);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(90*kScaleH);
    }];
    //    UILabel *line = [[UILabel alloc] init];
    //    line.backgroundColor = [UIColor lineColor];
    //    [self.view addSubview:line];
    //    [line mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.view);
    //        make.right.equalTo(self.view);
    //        make.bottom.equalTo(_segmentedControl);
    //        make.height.mas_equalTo(0.5);
    //    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(275*kScaleH, 0, -200*kScaleH, 0));
    }];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100*kScaleH)];
    bottomView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:bottomView];
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view).offset(-100*kScaleH);
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.height.mas_equalTo(100*kScaleH);
//    }];
    NSArray *bottomImageArr = @[@"registered_icon_ma1",@"registered_icon_ma2",@"registered_icon_ma3",@"registered_icon_ma4"];
    CGFloat btnWidth = 72*kScaleW;
    for (int i = 0; i < bottomImageArr.count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:bottomImageArr[i]] forState:UIControlStateNormal];
        [bottomView addSubview:btn];
        btn.tag = i;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bottomView);
            make.left.equalTo(bottomView).offset(200*kScaleW+(btnWidth+30*kScaleW)*i);
            make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
        }];
        [btn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.tableView.tableFooterView = bottomView;
    self.publishBtn.hidden = YES;
    [self.view addSubview:self.publishBtn];
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(90*kScaleH);
    }];
}

- (void)bottomBtnClick:(UIButton *)sender{
    XWBaseViewController *page;
    switch (sender.tag) {
        case 0:
            page = [XWQRCodeViewController new];
            break;
        case 1:
        {
            XWMapViewController *mapVc = [XWMapViewController new];
            mapVc.address = self.cmodel.sAddress;
            [self.navigationController pushViewController:mapVc animated:YES];
        }
            break;
        case 2:
            page = [XWQQViewController new];
            break;
        case 3:
            page = [XWWeChatViewController new];
            break;
            
        default:
            break;
    }
    if (page) {
        [self.navigationController pushViewController:page animated:YES];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (index == 0) {
        if (indexPath.section == 0) {
            XWOrgInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orders1"];
            if (!cell) {
                cell = [[XWOrgInfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orders1"];
            }
            cell.delegate = self;
            cell.cmodel = self.cmodel;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orders2"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orders2"];
            }
            cell.imageView.image = [UIImage imageNamed:@"shared_icon_icon1"];
            cell.textLabel.text = @"点击查看服务详情";
            cell.textLabel.textColor = [UIColor textBlackColor];
            cell.textLabel.font = [UIFont rw_regularFontSize:16.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }else{
        XWCommentModel *model = self.dataSource[indexPath.section];
        XWCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment1"];
        if (!cell) {
            cell = [[XWCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment1"];
        }
        cell.model = model.replyArray[indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (index == 0) {
        if (indexPath.section == 1) {
            XWServiceDetailViewController *serVc = [[XWServiceDetailViewController alloc] init];
            serVc.category = self.category;
            serVc.model = self.cmodel;
            [self.navigationController pushViewController:serVc animated:YES];
        }
    }else{
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (index == 0) {
        return 2;
    }else{
        return self.dataSource.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (index == 0) {
        return 1;
    }else{
        XWCommentModel *model = self.dataSource[section];
        return model.replyArray.count;
//        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (index == 0) {
        if (indexPath.section == 0) {
            return 520*kScaleH;
        }else{
            return 100*kScaleH;
        }
    }else{
//        XWCommentInfoModel *model = self.dataSource[section];
//        return model.commentModelArray.count;
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (index == 0) {
        return 0.01f;
    }else{
        XWCommentModel *model = self.dataSource[section];
        return model.rowHeight+120*kScaleH;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (index == 0) {
        return 8.0f;
    }else{
        return 80*kScaleH;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (index == 0) {
        return nil;
    }else{
        XWCommentHeaderView *headerView = (XWCommentHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"XWCommentHeaderView"];
        headerView.model = self.dataSource[section];
        return headerView;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (index == 0) {
        return nil;
    }else{
        currentModel = self.dataSource[section];
        WS(weakSelf);
        XWCommentFooterView *footerView = (XWCommentFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"XWCommentFooterView"];
        //        footerView.model = ;
        footerView.CommentBtnClickBlock = ^(UIButton *commentBtn, NSInteger footerSection, int modelId) {
            //评论
            isReply = YES;
            [weakSelf showXHInputViewWithStyle:InputViewStyleLarge];//显示样式二
            
        };
        footerView.LikeBtnClickBlock = ^(UIButton *likeBtn, NSInteger footerSection, int modelId) {
            //点赞
            [CommonRequest setCommentLikeWithParams:@{@"eId":@(self.model.ID),@"uId":[USER_DEFAULT objectForKey:USERIDKEY]}  block:^(BOOL success) {
                //刷新数据，like+1
//                footerView.likeBtn.selected = YES;
            }];
        };
        return footerView;
    }
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
        [_tableView registerClass:NSClassFromString(@"XWCommentHeaderView") forHeaderFooterViewReuseIdentifier:@"XWCommentHeaderView"];
        [_tableView registerClass:NSClassFromString(@"XWCommentFooterView") forHeaderFooterViewReuseIdentifier:@"XWCommentFooterView"];
//        [_tableView registerClass:NSClassFromString(@"XWCommentViewCell") forHeaderFooterViewReuseIdentifier:@"XWCommentViewCell"];
    }
    return _tableView;
}
- (UIButton *)publishBtn{
    if (!_publishBtn) {
        _publishBtn = [[UIButton alloc] init];
        [_publishBtn setBackgroundColor:[UIColor whiteColor]];
        [_publishBtn setTitle:@"发布话题" forState:UIControlStateNormal];
        [_publishBtn setImage:[UIImage imageNamed:@"write_icon"] forState:UIControlStateNormal];
        [_publishBtn setTitleColor:[UIColor textBlackColor] forState:UIControlStateNormal];
        [_publishBtn.titleLabel setFont:[UIFont rw_regularFontSize:15.0]];
        [_publishBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//        [self.view addSubview:_publishBtn];
        [_publishBtn addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
//        [_publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view);
//            make.right.equalTo(self.view);
//            make.bottom.equalTo(self.view);
//            make.height.mas_equalTo(90*kScaleH);
//        }];
        CALayer *topLayer = [CALayer layer];
        topLayer.backgroundColor = [UIColor colorWithHex:@"e2e2e2"].CGColor;
        topLayer.frame = CGRectMake(0, 0, ScreenWidth, 0.5);
        [_publishBtn.layer addSublayer:topLayer];
    }
    return _publishBtn;
}
#pragma mark - 发布话题
- (void)publishAction{
//    [MBProgressHUD alertInfo:@"功能正在开发，敬请期待"];
    isReply = NO;
    [self showXHInputViewWithStyle:InputViewStyleLarge];//显示样式二
}
-(void)showXHInputViewWithStyle:(InputViewStyle)style{
    
    [XHInputView showWithStyle:style configurationBlock:^(XHInputView *inputView) {
        /** 请在此block中设置inputView属性 */
        
        /** 代理 */
        inputView.delegate = self;
        
        /** 占位符文字 */
        inputView.placeholder = @"请输入...";
        /** 设置最大输入字数 */
        inputView.maxCount = 100;
        /** 输入框颜色 */
        inputView.textViewBackgroundColor = [UIColor groupTableViewBackgroundColor];
        
        /** 更多属性设置,详见XHInputView.h文件 */
        
    } sendBlock:^BOOL(NSString *text) {
        if(text.length){
            NSLog(@"输入的信息为:%@",text);
            if (isReply) {
                [CommonRequest publishEvaluate:text withParams:@{@"uId":APPDELEGATE.user.uId,@"sId":@(self.model.ID),@"eContent":text} block:^(BOOL success) {
                    if (success) {
                        [MBProgressHUD alertInfo:@"发布成功"];
                    }else{
                        [MBProgressHUD alertInfo:@"发布失败"];
                    }
                }];
            }else{
                [CommonRequest publishReply:text withParams:@{@"uId":APPDELEGATE.user.uId,@"eId":@(currentModel.ID),@"rContent":text} block:^(BOOL success) {
                    if (success) {
                        [MBProgressHUD alertInfo:@"发布成功"];
                    }else{
                        [MBProgressHUD alertInfo:@"发布失败"];
                    }
                }];
            }
            
            return YES;//return YES,收起键盘
        }else{
            NSLog(@"显示提示框-请输入要评论的的内容");
            return NO;//return NO,不收键盘
        }
    }];
}

#pragma mark - XHInputViewDelagete
/** XHInputView 将要显示 */
-(void)xhInputViewWillShow:(XHInputView *)inputView{
    
    /** 如果你工程中有配置IQKeyboardManager,并对XHInputView造成影响,请在XHInputView将要显示时将其关闭 */
    
    //[IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    //[IQKeyboardManager sharedManager].enable = NO;
    
}

/** XHInputView 将要影藏 */
-(void)xhInputViewWillHide:(XHInputView *)inputView{
    
    /** 如果你工程中有配置IQKeyboardManager,并对XHInputView造成影响,请在XHInputView将要影藏时将其打开 */
    
    //[IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    //[IQKeyboardManager sharedManager].enable = YES;
}
#pragma mark - 收藏
- (void)didClickCollectButton{
    
    if (![UserModel isLogin]) {
//        [MBProgressHUD alertInfo:@"请先登录"];
        [self showLogin];
        return;
    }
    if (self.model) {
        [CommonRequest collectDataWithParams:@{@"sId":@(self.model.ID),@"uId":[USER_DEFAULT objectForKey:USERIDKEY]} block:^(BOOL success) {
            if (success) {
                
            }
        }];
    }
}
#pragma mark - 机构点赞
- (void)didClickLikeButton{
    if (![UserModel isLogin]) {
//        [MBProgressHUD alertInfo:@"请先登录"];
        [self showLogin];
        return;
    }
    if (self.model) {
        if (self.cmodel.isLiked) {
            [MBProgressHUD alertInfo:@"已经赞过了哦～"];
            return;
        }
        WS(weakSelf);
        [CommonRequest setServiceLikeWithParams:@{@"sId":@(self.model.ID),@"uId":[USER_DEFAULT objectForKey:USERIDKEY]}  block:^(BOOL success) {
            //刷新数据，like+1
            weakSelf.cmodel.isLiked = YES;
            weakSelf.cmodel.like += 1;
            [weakSelf.tableView reloadData];
        }];
    }
}
#pragma mark - 获取机构详情
- (void)getOrgDetail {
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"sId":@(self.model.ID),
                                             @"indexPage":@(0),
                                             @"endPage":@(10)
                                             }];
    
    [manager POSTRequestUrlStr:kGetOrgService parms:params success:^(id responseData) {
        NSLog(@"获取机构详情数据  %@",responseData);
//        if ([responseData isKindOfClass:[NSArray class]]) {
//
//        }
        self.cmodel = [XWServiceModel mj_objectWithKeyValues:responseData[0]];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}
#pragma mark - 获取评价详情
- (void)getCommentDetail {
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"sId":@(self.model.ID)
                                             }];
    
    [manager POSTRequestUrlStr:kGetEvaluateInfo parms:params success:^(id responseData) {
        NSLog(@"获取评价详情数据  %@",responseData);
        NSMutableArray *dataArray = [NSMutableArray array];
        if ([responseData isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseData];
            if (array.count > 0) {
                dataArray = [XWCommentModel mj_objectArrayWithKeyValuesArray:array];
            }
        }
//        if (dataArray.count < 10) {
//            self.tableView.tableFooterView.hidden = NO;
//            self.tableView.mj_footer.hidden = YES;
//        }else{
//            self.tableView.tableFooterView.hidden = YES;
//            self.tableView.mj_footer.hidden = NO;
//        }
//        if (_indexPage == 0) {
            self.dataSource = [NSMutableArray arrayWithArray:dataArray];
//        }else{
//            [self.dataSource addObjectsFromArray:dataArray];
//        }
        [self getCommentInfoDetailWith:self.dataSource];
        [self.tableView reloadData];
        
    } fail:^(NSError *error) {
        
    }];
}
#pragma mark - 获取评价中的回复
- (void)getCommentInfoDetailWith:(NSArray *)commentArray {
    if (commentArray.count == 0) {
        return;
    }
    
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    for (XWCommentModel *model in commentArray) {
        [params setValuesForKeysWithDictionary:@{@"eId":@(model.ID)
                                                 }];
        
        [manager POSTRequestUrlStr:kGetEvaluateReply parms:params success:^(id responseData) {
            NSLog(@"获取评价中的回复数据  %@",responseData);
            if ([responseData isKindOfClass:[NSArray class]]) {
                //可能是数组
                model.replyArray = [XWCommentInfoModel mj_objectArrayWithKeyValuesArray:responseData];
            }
            
        } fail:^(NSError *error) {
            
        }];
    }
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
