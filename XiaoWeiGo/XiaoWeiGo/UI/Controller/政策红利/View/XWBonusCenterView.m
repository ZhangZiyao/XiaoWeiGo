//
//  XWBonusCenterView.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/12.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBonusCenterView.h"

@interface XWBonusCenterView ()

@property (nonatomic, assign) int regionTag;

@property (nonatomic, strong) UIButton *centerBtn1;
@property (nonatomic, strong) UIButton *centerBtn2;
@property (nonatomic, strong) UIButton *centerBtn3;
@property (nonatomic, strong) UIButton *centerSelectedBtn;

@end
@implementation XWBonusCenterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createView];
    }
    return self;
}

- (void)resetDataWithRegion:(int)region{
    NSArray *array = @[@[@"国务院文件",@"法律法规",@"部门文件"],@[@"省各部门文件",@"省地方法规",@"省政府文件"],@[@"市政府文件",@"市政府各部门文件",@"市级地方性法规"],@[@"区政府文件",@"区政府各部门文件"]];
    
    _regionTag = region;
    
    [self centerViewBtnClick:self.centerBtn1];
    
    switch (region) {
        case 1:
        {
            self.centerBtn3.hidden = NO;
            [self.centerBtn1 setTitle:array[0][0] forState:UIControlStateNormal];
            [self.centerBtn2 setTitle:array[0][1] forState:UIControlStateNormal];
            [self.centerBtn3 setTitle:array[0][2] forState:UIControlStateNormal];
            [self resetConstraintWithNum:3];
        }
            break;
        case 2:
        {
            self.centerBtn3.hidden = NO;
            [self.centerBtn1 setTitle:array[1][0] forState:UIControlStateNormal];
            [self.centerBtn2 setTitle:array[1][1] forState:UIControlStateNormal];
            [self.centerBtn3 setTitle:array[1][2] forState:UIControlStateNormal];
            [self resetConstraintWithNum:3];
        }
            break;
        case 3:
        {
            self.centerBtn3.hidden = NO;
            [self.centerBtn1 setTitle:array[2][0] forState:UIControlStateNormal];
            [self.centerBtn2 setTitle:array[2][1] forState:UIControlStateNormal];
            [self.centerBtn3 setTitle:array[2][2] forState:UIControlStateNormal];
            [self resetConstraintWithNum:3];
        }
            break;
        case 4:
        {
            [self.centerBtn1 setTitle:array[3][0] forState:UIControlStateNormal];
            [self.centerBtn2 setTitle:array[3][1] forState:UIControlStateNormal];
            self.centerBtn3.hidden = YES;
            [self resetConstraintWithNum:2];
        }
            break;
            
        default:
            break;
    }
}
- (void)resetConstraintWithNum:(int)num{
    
    if (num == 2) {
        CGFloat width = 200*kScaleW;
        CGFloat padding = (ScreenWidth-2*width)/8.0;
        [self.centerBtn1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(padding*3);
            make.size.mas_equalTo(CGSizeMake(width, 40*kScaleH));
            make.centerY.equalTo(self);
        }];
        [self.centerBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-padding*3);
            make.size.mas_equalTo(CGSizeMake(width, 40*kScaleH));
            make.centerY.equalTo(self);
        }];
    }else{
        CGFloat width = 200*kScaleW;
        CGFloat padding = (ScreenWidth-3*width)/5.0;
        [self.centerBtn1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(padding*2);
            make.size.mas_equalTo(CGSizeMake(width, 40*kScaleH));
            make.centerY.equalTo(self);
        }];
        [self.centerBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, 40*kScaleH));
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
        }];
        [self.centerBtn3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-padding*2);
            make.size.mas_equalTo(CGSizeMake(width, 40*kScaleH));
            make.centerY.equalTo(self);
        }];
    }
}
- (void)centerViewBtnClick:(UIButton *)sender{
    int tag;
    NSArray *array = @[@[@1,@2,@3],@[@4,@5,@6],@[@7,@8,@9],@[@10,@11]];
    
    tag = [array[_regionTag-1][sender.tag] intValue];
    
    [self.delegate didClickCenterButton:sender tag:tag];
    if (sender  != _centerSelectedBtn) {
        _centerSelectedBtn.selected = NO;
        sender.selected = YES;
        _centerSelectedBtn = sender;
    }
}
- (void)createView{
//    NSArray *array = @[@[@"国务院文件",@"法律法规",@"部门文件"],@[@"省各部门文件",@"省地方法规",@"省政府文件"],@[@"市政府文件",@"市政府各部门文件",@"市级地方性法规"],@[@"区政府文件",@"区政府各部门文件"]];
    CGFloat width = 140*kScaleW;
    //    CGFloat height = 40*kScaleH;
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        btn.adjustsImageWhenHighlighted = NO;
//        [btn setTitle:array[region][i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont rw_regularFontSize:12]];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB16(0x1aa4ec)] forState:UIControlStateSelected];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(centerViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(135*kScaleW+(width+60*kScaleW)*i);
            make.size.mas_equalTo(CGSizeMake(width, 40*kScaleH));
            make.centerY.equalTo(self);
        }];
        if (i == 0) {
            btn.selected = YES;
            _centerSelectedBtn = btn;
            self.centerBtn1 = btn;
        }else if (i == 1){
            self.centerBtn2 = btn;
        }else{
            self.centerBtn3 = btn;
        }
    }
//    [self addSubview:self.centerBtn1];
//    [self addSubview:self.centerBtn2];
//    [self addSubview:self.centerBtn3];
}
//- (UIButton *)centerBtn1{
//    if (!_centerBtn1) {
//        UIButton *btn = [[UIButton alloc] init];
//        btn.tag = 10;
//        btn.adjustsImageWhenHighlighted = NO;
//        //        [btn setTitle:array[region][i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [btn.titleLabel setFont:[UIFont rw_regularFontSize:12]];
//        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB16(0x1aa4ec)] forState:UIControlStateSelected];
//        btn.layer.cornerRadius = 3;
//        btn.layer.masksToBounds = YES;
//        _centerBtn1 = btn;
//    }
//    return _centerBtn1;
//}
//- (UIButton *)centerBtn2{
//    if (!_centerBtn2) {
//        UIButton *btn = [[UIButton alloc] init];
//        btn.tag = 20;
//        btn.adjustsImageWhenHighlighted = NO;
//        //        [btn setTitle:array[region][i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [btn.titleLabel setFont:[UIFont rw_regularFontSize:12]];
//        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB16(0x1aa4ec)] forState:UIControlStateSelected];
//        btn.layer.cornerRadius = 3;
//        btn.layer.masksToBounds = YES;
//        _centerBtn1 = btn;
//    }
//    return _centerBtn2;
//}
//- (UIButton *)centerBtn3{
//    if (!_centerBtn3) {
//        UIButton *btn = [[UIButton alloc] init];
//        btn.tag = 30;
//        btn.adjustsImageWhenHighlighted = NO;
//        //        [btn setTitle:array[region][i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [btn.titleLabel setFont:[UIFont rw_regularFontSize:12]];
//        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB16(0x1aa4ec)] forState:UIControlStateSelected];
//        btn.layer.cornerRadius = 3;
//        btn.layer.masksToBounds = YES;
//        _centerBtn3 = btn;
//    }
//    return _centerBtn3;
//}
@end
