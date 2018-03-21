//
//  XWSearchToolView.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/21.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWSearchToolView.h"

@interface XWSearchToolView ()

/* 左边Item */
@property (strong , nonatomic)UIButton *leftItemButton;
/* 右边Item */
//@property (strong , nonatomic)UIButton *rightItemButton;
@end
@implementation XWSearchToolView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        //        [self acceptanceNote];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = UIColorFromRGB16(0xf4f4f4);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(30*kScaleW, 20*kScaleH, ScreenWidth-60*kScaleW, self.frame.size.height-40*kScaleH)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = (self.frame.size.height-40*kScaleH)/2.0f;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = UIColorFromRGB16(0xe2e2e2).CGColor;
    [self addSubview:bgView];
    
//    UIImageView *line0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
//    line0.backgroundColor = LineColor;
//    [self addSubview:line0];
//    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, ScreenWidth, 0.5)];
//    line1.backgroundColor = LineColor;
//    [self addSubview:line1];
    
//    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self);
//        make.left.equalTo(self);
//        make.right.equalTo(self);
//        make.height.mas_equalTo(0.5);
//    }];
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self);
//        make.left.equalTo(self);
//        make.right.equalTo(self);
//        make.height.mas_equalTo(0.5);
//    }];
    
    UIImageView *searchImageView = [[UIImageView alloc] init];
    searchImageView.image = [UIImage imageNamed:@"home_icon_search"];
    searchImageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:searchImageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请输入内容...";
    label.font = [UIFont rw_regularFontSize:14];
    label.textColor = UIColorFromRGB16(0x999999);
    [bgView addSubview:label];
    
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.left.equalTo(bgView).offset(20*kScaleW);
        make.size.mas_equalTo(CGSizeMake(30*kScaleW, 30*kScaleH));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchImageView);
        make.left.equalTo(searchImageView.mas_right).offset(10*kScaleW);
        make.right.equalTo(bgView).offset(-30*kScaleW);
    }];
    
    _leftItemButton = ({
        UIButton * button = [UIButton new];
        button.backgroundColor = [UIColor clearColor];
//        [button setTitle:@"搜索" forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor colorWithHex:@"666666"] forState:UIControlStateNormal];
//        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
//        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
//        [button setImage:[UIImage imageNamed:@"order_ss"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
//    _rightItemButton = ({
//        UIButton * button = [UIButton new];
//        [button setTitle:@"筛选" forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor colorWithHex:@"666666"] forState:UIControlStateNormal];
//        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
//        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
//        [button setContentMode:UIViewContentModeScaleAspectFit];
//        [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
//        [button setImage:[UIImage imageNamed:@"order_sx"] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
//        button;
//    });
//    [bgView addSubview:_rightItemButton];
    [self addSubview:_leftItemButton];
    
    [_leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(60*kScaleW);
        make.right.equalTo(self).offset(-60*kScaleW);
    }];
    
//    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self);
//        make.bottom.equalTo(self);
//        make.right.equalTo(self);
//        make.width.mas_equalTo(ScreenWidth/3);
//    }];
    
    
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
#pragma 自定义右边导航Item点击
//- (void)rightButtonItemClick {
//    !_rightItemClickBlock ? : _rightItemClickBlock();
//}

#pragma 自定义左边导航Item点击
- (void)leftButtonItemClick {
    
    !_leftItemClickBlock ? : _leftItemClickBlock();
}

@end
