//
//  HomeTabBaseViewController.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseViewController.h"
#import "HomeCustomView.h"
#import "FSCustomButton.h"
#import "XWServiceModel.h"
#import "CommandModel.h"
#import "XWListViewCell.h"


@interface HomeTabBaseViewController : XWBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger tagIndex;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *servicesDataSource;

@property (nonatomic, strong) NSMutableArray *demandDataSource;

@property (nonatomic, strong) UIImage *topImage;

@property (nonatomic, assign) int categoryType;

/** 加载数据 刷新UI */
- (void)loadHeadView:(id)data;


/**
 通过type区分 展示不同的cell
 
 @param data 数据
 @param type 展示类型
 */
- (void)loadTableViewWithData:(id)data type:(HHShowTableCellType)type;

- (void)getDataListRequestWith:(int)category;

- (void)centerAction1;

- (void)centerAction2;

- (void)centerAction3;

- (void)topClickAction;

- (void)centerClickAction:(int)index;

@end
