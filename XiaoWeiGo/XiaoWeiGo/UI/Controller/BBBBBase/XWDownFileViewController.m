//
//  XWDownFileViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWDownFileViewController.h"
#import "XWAttachmentModel.h"
#import "XWReadDocViewController.h"
#import "XWServiceModel.h"
#import "RWEnvironmentManager.h"

@interface XWDownFileViewController ()<UITableViewDelegate,UITableViewDataSource>
{
//    XWAttachmentModel *model;
//    NSString *urlString;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation XWDownFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附件下载";
    [self showBackItem];
    
    [self getAttachment];
}
- (void)layoutSubviews{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataSource.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"downCell"];
        cell.textLabel.textColor = [UIColor textBlackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0) {
//        @[@"def_icon_download",@"附件下载"]
        cell.imageView.image = [UIImage imageNamed:@"def_icon_download"];
        cell.textLabel.text = @"附件下载";
    }else{
        XWAttachmentModel *model = self.dataSource[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"loan_icon_word"];
        cell.textLabel.text = model.attName;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
    }else {
        //        if (model) {
        //            if (IsStrEmpty(model.attUrl)) {
        //                //   例获取到的attUrl为20170809.doc,完整路径应为http://我们的网址/xc/attUrl
        //            }
        //        }else{
        //            [MBProgressHUD alertInfo:@"获取附件地址失败,请稍后重试"];
        //        }
        XWAttachmentModel *model = self.dataSource[indexPath.row];
        if (!IsStrEmpty(model.attUrl)) {
            XWReadDocViewController *readVc = [[XWReadDocViewController alloc] init];
            NSString *urlString = [NSString stringWithFormat:@"%@/xc/%@",[RWEnvironmentManager host],model.attUrl];
            readVc.urlString = urlString;
            readVc.model = model;
            [self.navigationController pushViewController:readVc animated:YES];
        }else{
            [MBProgressHUD alertInfo:@"没有获取到附件，请稍后再试"];
        }
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*kScaleH;
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

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)getAttachment{
    if (![UserModel isLogin]) {
//        [MBProgressHUD alertInfo:@"请先登录"];
        [self showLogin];
        return;
    }
    RequestManager *request = [[RequestManager alloc] init];
    request.isShowLoading = NO;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"sId":@(self.model.ID)//机构表ID
                                             }];
    
    [request POSTRequestUrlStr:kGetAttachmentList parms:params success:^(id responseData) {
        NSLog(@"获取数据  %@",responseData);
        if (responseData) {
//            [MBProgressHUD alertInfo:@"获取附件成功"];
            self.dataSource = [XWAttachmentModel mj_objectArrayWithKeyValuesArray:responseData];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD alertInfo:@"获取附件失败"];
        }
    } fail:^(NSError *error) {
        
    }];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
