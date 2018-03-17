//
//  HomeTabView.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "HomeTabView.h"
#import "FSCustomButton.h"

@implementation HomeTabView
+ (CGFloat)height{
    return (ScreenWidth-60*kScaleW)/5.0f*1.2*2+60*kScaleH;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
- (void)createView{
    float width = (ScreenWidth-60*kScaleW)/5.0f;
    float height = width*1.2;
//    HomeTabView *sview = [[HomeTabView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height*2+60*kScaleH)];
    self.backgroundColor = [UIColor whiteColor];
    NSArray *array;
    if ([NSString ifOutOfDateTime:[NSString ymdhDateToDateString:[NSDate date]] andEndDate:kCheckDate]) {
        array = @[@[@"",@"我有需求"],@[@"",@"创业创新"],@[@"",@"知识产权"],@[@"",@"共享会计"],@[@"",@"法律服务"],@[@"",@"优惠政策"],@[@"",@"ISO认证"],@[@"",@"展会服务"],@[@"",@"工商注册"],@[@"",@"其它服务"]];
    }else{
        array = @[@[@"",@"我要贷款"],@[@"",@"创业创新"],@[@"",@"知识产权"],@[@"",@"共享会计"],@[@"",@"法律服务"],@[@"",@"优惠政策"],@[@"",@"ISO认证"],@[@"",@"展会服务"],@[@"",@"工商注册"],@[@"",@"其它服务"]];
        
    }
    
    for (int i = 0; i < array.count; i++) {
        FSCustomButton *button = [[FSCustomButton alloc] init];
        button.backgroundColor = [UIColor whiteColor];
        button.adjustsTitleTintColorAutomatically = YES;
        [button setTintColor:[UIColor textBlackColor]];
        button.titleLabel.font = [UIFont rw_regularFontSize:13];
        [button setTitle:array[i][1] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_icon_nav%d",i+1]] forState:UIControlStateNormal];
        button.buttonImagePosition = FSCustomButtonImagePositionTop;
        button.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
        [self addSubview:button];
        button.tag = i+1008600;
        [button addTarget:self action:@selector(didClickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30*kScaleW+width*(i%5));
            make.top.equalTo(self).offset(30*kScaleH+height*(i/5));
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
    }
}

- (void)didClickButtonAction:(UIButton *)sender{
    [self.delegate didClickButton:sender tag:(int)sender.tag];
}

@end
