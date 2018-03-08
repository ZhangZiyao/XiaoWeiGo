//
//  XWBaseHeaderView.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseHeaderView.h"

@implementation XWBaseHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
+ (XWBaseHeaderView *)createHeaderViewWithTitle:(NSString *)title{
    XWBaseHeaderView *headerView = [[XWBaseHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90*kScaleH)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = mainColor;
    [headerView addSubview:line];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = mainColor;
    label.text = title;
    label.font = [UIFont rw_regularFontSize:15.0];
    [headerView addSubview:label];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).offset(30*kScaleW);
        make.height.mas_equalTo(30*kScaleH);
        make.width.mas_equalTo(1.5);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(line.mas_right).offset(30*kScaleW);
        make.right.equalTo(headerView).offset(-30*kScaleW);
    }];
    return headerView;
}

@end
