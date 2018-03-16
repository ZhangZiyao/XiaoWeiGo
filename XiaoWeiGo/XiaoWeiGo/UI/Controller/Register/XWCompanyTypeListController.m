//
//  XWCompanyTypeListController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/16.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWCompanyTypeListController.h"

@interface XWCompanyTypeListController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation XWCompanyTypeListController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"行业类别";
    [self showBackItem];
    self.dataSource = [NSMutableArray array];
    [self getCompanyTypeList];
    [self layoutSubview];
}

- (void)layoutSubview{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneList"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"oneList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont rw_regularFontSize:15];
        cell.textLabel.textColor = UIColorFromRGB16(0x666666);
    }
    
    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"typeName"];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0*kScaleH;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataSource.count > 0) {
        self.selectCompanyBlock([[self.dataSource[indexPath.row] objectForKey:@"ID"] intValue], [self.dataSource[indexPath.row] objectForKey:@"typeName"]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
    }
    return _tableView;
}

#pragma mark -  获取行业类别
- (void)getCompanyTypeList{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    [manager POSTRequestUrlStr:kGetCompanyInfo parms:nil success:^(id responseData) {
        
        NSLog(@"  %@",responseData);
        //        NSString *message = responseData[0];
        //        companyId =
        //        companyTypeName = ;
        //        if (companyId) {
        //            [self commitRegisterInfo];
        //        }
        self.dataSource = [NSMutableArray arrayWithArray:responseData];
        [self.tableView reloadData];
        
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
