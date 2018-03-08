//
//  BonusHeaderView.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "BonusHeaderView.h"
#import "FSCustomButton.h"

@interface BonusHeaderView()

@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation BonusHeaderView

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
    float width = (ScreenWidth-100*kScaleW)/4.0;
    float height = 160*kScaleH;
    
//    float padding = (ScreenWidth-120*kScaleW*4)/4.0;
    //    HomeTabView *sview = [[HomeTabView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height*2+60*kScaleH)];
    self.backgroundColor = [UIColor whiteColor];
    NSArray *array = @[@[@"icon_central1",@"中央政府"],@[@"icon_province2",@"浙江省级"],@[@"icon_city3",@"宁波市级"],@[@"icon_area4",@"奉化区级"]];
    
    for (int i = 0; i < array.count; i++) {
        FSCustomButton *button = [[FSCustomButton alloc] init];
        button.backgroundColor = [UIColor whiteColor];
        button.adjustsTitleTintColorAutomatically = YES;
        [button setTitleColor:[UIColor colorWithHex:@"666666"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:@"1aa4ec"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont rw_regularFontSize:13];
        [button setTitle:array[i][1] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:array[i][0]] forState:UIControlStateNormal];
        button.buttonImagePosition = FSCustomButtonImagePositionTop;
        button.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
        [self addSubview:button];
        button.tag = i+1008600;
        [button addTarget:self action:@selector(didClickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(50*kScaleW+width*(i%4));
            make.centerY.equalTo(self);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        if (i == 0) {
            button.selected = YES;
            _selectedBtn = button;
        }
    }
}
- (void)didClickButtonAction:(UIButton *)sender{
    if (_selectedBtn != sender) {
        _selectedBtn.selected = NO;
        sender.selected = YES;
        _selectedBtn = sender;
    }
    
    [self.delegate didClickButton:sender tag:(int)sender.tag];
}

@end
