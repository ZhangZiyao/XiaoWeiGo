//
//  DemandReleaseViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "DemandReleaseViewController.h"
#import "EditTextViewController.h"
#import "WSDatePickerView.h"
#import "CommandModel.h"
#import "BRPickerView.h"

#define kTitle @"kTitle"
#define kService @"kService"
#define kContent @"kContent"
#define kEndTime @"kEndTime"
#define kSaveDemand @"kSaveDemand"

@interface DemandReleaseViewController ()<UITableViewDelegate,UITableViewDataSource,WSDatePickerDelegate>
{
    int selectIndex;
    NSString *seleceName;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) WSDatePickerView *datePicker;
@property (nonatomic, strong) NSDate *selDate;
@property (nonatomic, strong) CommandModel *demand;
@property (nonatomic, strong) NSMutableDictionary *mutableDict;
@end

@implementation DemandReleaseViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布需求";
    [self showBackItem];
    _demand = [[CommandModel alloc] init];
    
    _demand.serviceName = @"银企对接";
    seleceName = @"银企对接";
    selectIndex = 1;
//    if ([USER_DEFAULT objectForKey:kSaveDemand]) {
//        _demand = [CommandModel modelOfDictionary:[USER_DEFAULT objectForKey:kSaveDemand]];
//        [self.tableView reloadData];
//    }
    
    RegisterNotify(XWDemandInputNotification, @selector(receiveDemandInputNotify:));
}
- (void)receiveDemandInputNotify:(NSNotification *)notification{
    NSLog(@"DemandInput  %@",notification.object);
    if (notification.object) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:notification.object];
        if (dic) {
            if ([[dic objectForKey:@"type"] intValue] == 0) {
                _demand.dTitle = [dic objectForKey:@"text"];
                [self.mutableDict setObject:_demand.dTitle forKey:@"dTitle"];
            }else if ([[dic objectForKey:@"type"] intValue] == 1){
                _demand.serviceName = [dic objectForKey:@"text"];
                [self.mutableDict setObject:_demand.serviceName forKey:@"serviceName"];
            }else{
                _demand.dContent = [dic objectForKey:@"text"];
                [self.mutableDict setObject:_demand.dContent forKey:@"content"];
            }
            [self.tableView reloadData];
        }
    }
}
- (void)layoutSubviews{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    NSArray *array = @[@[@"发布",@"demand_icon_release1"]];
    for (int i = 0; i < array.count; i++) {
        
        UIButton *saveBtn = [[UIButton alloc] init];
        saveBtn.tag = i;
        [saveBtn setBackgroundColor:[UIColor whiteColor]];
        [saveBtn setTitle:array[i][0] forState:UIControlStateNormal];
        [saveBtn setImage:[UIImage imageNamed:array[i][1]] forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor textBlackColor] forState:UIControlStateNormal];
        [saveBtn.titleLabel setFont:[UIFont rw_regularFontSize:15.0]];
        [saveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [self.view addSubview:saveBtn];
        [saveBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset((ScreenWidth/2+0.5)*i);
            make.bottom.equalTo(self.view);
            make.height.mas_equalTo(90*kScaleH);
            make.width.mas_equalTo(ScreenWidth);
        }];
        CALayer *topLayer = [CALayer layer];
        topLayer.backgroundColor = [UIColor OCRMainColor].CGColor;
        topLayer.frame = CGRectMake(0, 0, ScreenWidth, 0.5);
        [saveBtn.layer addSublayer:topLayer];
//        if (i == 0) {
//            CALayer *rightLayer = [CALayer layer];
//            rightLayer.backgroundColor = [UIColor OCRMainColor].CGColor;
//            rightLayer.frame = CGRectMake(ScreenWidth/2, 0, 0.5, 90*kScaleH);
//            [saveBtn.layer addSublayer:rightLayer];
//        }
        saveBtn.layer.masksToBounds = YES;
    }
}
#pragma mark -
- (void)bottomBtnClick:(UIButton *)sender{
//    if (sender.tag == 0) {
//        if (self.mutableDict.allValues.count > 0 ) {
//            [USER_DEFAULT setObject:self.mutableDict forKey:kSaveDemand];
//        }
//    }else{
    
//    }
    
    if (self.model) {
        [self republish];
    }else{
        [self publishNewD];
    }
    
    
}
- (void)publishNewD{
    if (IsStrEmpty(_demand.dTitle)) {
        [MBProgressHUD alertInfo:@"请填写需求标题"];
        return;
    }
    if (IsStrEmpty(_demand.serviceName)) {
        [MBProgressHUD alertInfo:@"请填写需求领域"];
        return;
    }
    if (IsStrEmpty(_demand.dContent)) {
        [MBProgressHUD alertInfo:@"请填写需求内容"];
        return;
    }
    if (IsStrEmpty(_demand.endTime)) {
        [MBProgressHUD alertInfo:@"请选择截止时间"];
        return;
    }
    
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"uId":[USER_DEFAULT objectForKey:USERIDKEY],
                                             @"title":_demand.dTitle,
                                             @"content":_demand.dContent,
                                             @"starTime":[NSString nowDateString],//datetime
                                             @"endTime":_demand.endTime,
                                             @"category":@(selectIndex)
                                             }];
    
    [manager POSTRequestUrlStr:kPublishDemand parms:params success:^(id responseData) {
        NSLog(@"发布需求  %@",responseData);
        
        NSString *message = responseData[0];
        if ([message isEqualToString:@"success"]) {
            [MBProgressHUD alertInfo:@"发布需求成功"];
            [self.navigationController popViewControllerAnimated:YES];
            [USER_DEFAULT removeObjectForKey:kSaveDemand];
            SendNotify(@"reloadDD", nil);
        }else if ([message isEqualToString:@"danger"]){
            [MBProgressHUD alertInfo:@"提交的内容中有注入字符串,失败"];
        }else{
            [MBProgressHUD alertInfo:message];
        }
        
    } fail:^(NSError *error) {
        
    }];
}
- (void)republish{
    if (IsStrEmpty(_demand.dTitle)) {
        [MBProgressHUD alertInfo:@"请填写需求标题"];
        return;
    }
    if (IsStrEmpty(_demand.serviceName)) {
        [MBProgressHUD alertInfo:@"请填写需求领域"];
        return;
    }
    if (IsStrEmpty(_demand.dContent)) {
        [MBProgressHUD alertInfo:@"请填写需求内容"];
        return;
    }
    if (IsStrEmpty(_demand.endTime)) {
        [MBProgressHUD alertInfo:@"请选择截止时间"];
        return;
    }
    
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValuesForKeysWithDictionary:@{@"uId":[USER_DEFAULT objectForKey:USERIDKEY],
                                             @"id":@(self.model.ID),
                                             @"rePublishOrRecall":@2,
                                             @"title":_demand.dTitle,
                                             @"content":_demand.dContent,
                                             @"starTime":[NSString nowDateString],//datetime
                                             @"endTime":_demand.endTime,
                                             @"category":@([NSString getCategoryIDWithCategoryName:_demand.serviceName])
                                             }];
    [manager POSTRequestUrlStr:kChangeDemandStatus parms:params success:^(id responseData) {
        NSLog(@"设置需求状态  %@",responseData);
        NSString *message = responseData[0];
        if ([message isEqualToString:@"success"]) {
            [MBProgressHUD alertInfo:@"发布需求成功"];
            [self.navigationController popViewControllerAnimated:YES];
            [USER_DEFAULT removeObjectForKey:kSaveDemand];
            SendNotify(@"reloadDD", nil);
        }else if ([message isEqualToString:@"danger"]){
            [MBProgressHUD alertInfo:@"提交的内容中有注入字符串,失败"];
        }else{
            [MBProgressHUD alertInfo:message];
        }
    } fail:^(NSError *error) {
        
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demandCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"demandCell"];
        cell.textLabel.textColor = [UIColor textBlackColor];
        cell.detailTextLabel.textColor = [UIColor textGrayColor];
        cell.detailTextLabel.font = [UIFont rw_regularFontSize:14.0];
    }
    cell.textLabel.text = self.dataSource[indexPath.row][0];
    cell.detailTextLabel.text = self.dataSource[indexPath.row][1];
    switch (indexPath.row) {
        case 0:
            if (!IsStrEmpty(_demand.dTitle)) {
                cell.detailTextLabel.text = _demand.dTitle;
            }
            break;
        case 1:
            if (!IsStrEmpty(_demand.serviceName)) {
                cell.detailTextLabel.text = _demand.serviceName;
            }
            break;
        case 2:
            if (!IsStrEmpty(_demand.dContent)) {
                cell.detailTextLabel.text = _demand.dContent;
            }
            break;
        case 3:
            if (!IsStrEmpty(_demand.endTime)) {
                cell.detailTextLabel.text = _demand.endTime;
            }
            break;
            
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
        [self datepickerShow];
    }else if (indexPath.row == 1) {
        //选择需求领域
        WS(weakSelf);
        NSArray *typeArray = @[@"银企对接",@"创业创新",@"知识产权",@"共享会计",@"法律服务",@"优惠政策",@"ISO认证",@"展会服务",@"登记注册",@"其他服务"];
        [BRStringPickerView showStringPickerWithTitle:@"" dataSource:typeArray defaultSelValue:seleceName isAutoSelect:NO resultBlock:^(id selectValue) {
            weakSelf.demand.serviceName = selectValue;
            selectIndex = (int)[typeArray indexOfObject:selectValue]+1;
            seleceName = selectValue;
            [weakSelf.tableView reloadData];
        }];
    }else{
        EditTextViewController *editvc = [[EditTextViewController alloc] init];
        editvc.type = indexPath.row;
        editvc.title = self.dataSource[indexPath.row][0];
        editvc.placeholderStr = self.dataSource[indexPath.row][1];
        [self.navigationController pushViewController:editvc animated:YES];
    }
}
- (void)datepickerShow{
    WS(weakSelf);
    //年-月-日-时-分
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:_selDate CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        NSLog(@"选择的日期：%@",dateString);
        weakSelf.demand.endTime = dateString;
        weakSelf.selDate = selectDate;
        [weakSelf.mutableDict setObject:dateString forKey:@"endTime"];
        [weakSelf.tableView reloadData];
    }];
    datepicker.minLimitDate = [NSDate date];
    datepicker.dateLabelColor = mainColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = mainColor;//确定按钮的颜色
    [datepicker show];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*kScaleH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@[@"需求标题",@"请填写需求标题"],@[@"需求领域",@"请填写主要需求领域"],@[@"需求内容",@"请详细填写主要内容"],@[@"截止时间",@"请选择截止时间"]]];
    }
    return _dataSource;
}
- (NSMutableDictionary *)mutableDict{
    if (!_mutableDict) {
        _mutableDict = [NSMutableDictionary dictionary];
    }
    return _mutableDict;
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
