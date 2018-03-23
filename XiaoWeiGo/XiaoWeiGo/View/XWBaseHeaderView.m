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
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupView{
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = mainColor;
    [self addSubview:line];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = mainColor;
    label.text = self.title;
    label.font = [UIFont rw_regularFontSize:15.0];
    [self addSubview:label];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(30*kScaleW);
        make.height.mas_equalTo(30*kScaleH);
        make.width.mas_equalTo(1.5);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(line.mas_right).offset(30*kScaleW);
        make.right.equalTo(self).offset(-30*kScaleW);
    }];
    
    if (_showSearchBtn) {
        UIButton *searchBtn = [UIButton new];
        [searchBtn setImage:[UIImage imageNamed:@"home_icon_search"] forState:UIControlStateNormal];
        [self addSubview:searchBtn];
        searchBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30*kScaleW, 30*kScaleH));
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-30*kScaleW);
        }];
    }
}

- (void)searchAction{
    NSLog(@"搜索");
    !_rightItemClickBlock ? : _rightItemClickBlock();
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
    
//    UIButton *searchBtn = [UIButton new];
//    [searchBtn setImage:[UIImage imageNamed:@"home_icon_search"] forState:UIControlStateNormal];
//    [headerView addSubview:searchBtn];
//    searchBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
//    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(60*kScaleW, 60*kScaleH));
//        make.centerY.equalTo(headerView);
//        make.right.equalTo(headerView).offset(-30*kScaleW);
//    }];
    
    return headerView;
}

@end
