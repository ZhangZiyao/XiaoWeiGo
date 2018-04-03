//
//  DemandViewCell.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/4/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseCell.h"
@class CommandModel;

@interface DemandViewCell : XWBaseCell

@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UILabel *detailLabel;
@property (nonatomic, strong) CommandModel *model;

@end
