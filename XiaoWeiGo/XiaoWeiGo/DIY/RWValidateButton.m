//
//  RWValidateButton.m
//  ucupay
//
//  Created by dingxin on 2017/8/10.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "RWValidateButton.h"
#import "TYTimer.h"

@interface RWValidateButton ()<TYTimerProtocol>
/**
 *  倒计时 定时器
 */
@property (nonatomic,strong) TYTimer *timer;

/**
 *  倒计时长度
 */
@property (nonatomic,assign)NSInteger timeCount;

@end
@implementation RWValidateButton

/**
 *  初始化视图
 *
 *  @param frame      frame
 *  @param timerCount 倒计时长度
 *
 *  @return 视图
 */
- (instancetype)initWithFrame:(CGRect)frame timerCount:(NSInteger)timerCount{
    self = [super initWithFrame:frame];
    if (self) {
        self.timeCount = timerCount;
        
        [self initView:frame];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initView:CGRectMake(0, 0, 0, 0)];
    }
    return self;
}
/**
 *  初始化视图
 */
- (void)initView:(CGRect)frame{
    self.frame = frame;
    self.enabled = YES;
    [self setBackgroundColor:[UIColor orangeColor]];
    [self setTitle:@"点击获取" forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont rw_regularFontSize:15]];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
//    [self setBackgroundColor:UIColorFromRGB16(0xd0d0d0)];
//    self.enabled = NO;
    
//    [self addTarget:self action:@selector(getValidateCode) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  获取 验证码
 */
- (void)getValidateCode{
    [self start];
    [self canGetYzm:NO];
}

/**
 *  开始倒计时
 */
//- (void)start{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
//    if ([_delegate respondsToSelector:@selector(startTimeCount)]) {
//        [_delegate startTimeCount];
//    }
//}

/**
 *  倒计时60s
 *
 *  @param timers
 */
//- (void)timerFireMethod:(NSTimer*)timers {
//    self.timeCount -- ;
//    [self canGetYzm:NO];
//    NSString *string = [NSString stringWithFormat:@"(%0.0ld)",(long)self.timeCount];
//    [self setTitle:string forState:UIControlStateNormal];
//    if (self.timeCount == 0) {
//        [self reset];
//    }
//}
- (void)start
{
    self.timer = [[TYTimer alloc] initWithIdentifier:NSStringFromClass([self class]) totalTime:60];
    self.timer.delegate = self;
}

- (void)currenDownTime:(NSInteger)remainTime
{
    NSString *string = [NSString stringWithFormat:@"(%lds)",(long)remainTime];
    [self setTitle:string forState:UIControlStateNormal];
    [self setBackgroundColor:UIColorFromRGB16(0xd0d0d0)];
    if (remainTime == 0) {
        self.enabled = YES;
        [self setBackgroundColor:[UIColor orangeColor]];
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
    }
}

/**
 *  获取验证码按钮是否可以点击
 *
 *  @param isCan YES: 可以点击   NO:不可以点击
 */
- (void)canGetYzm:(BOOL)isCan{
    if (isCan) {
        // 按钮可以点击
//        self.imageView.image = [UIImage imageWithColor:[UIColor rw_greenColor]];
//        self.imageView.userInteractionEnabled = YES;
//        self.timeLabel.userInteractionEnabled = YES;
//        self.timeLabel.text = @"点击获取";
        
        [self setBackgroundColor:[UIColor orangeColor]];
        [self setTitle:@"点击获取" forState:UIControlStateNormal];
        self.enabled = YES;
    }
    else{
        // 按钮不可以点击
//        self.imageView.image = [UIImage imageWithColor:UIColorFromRGB16(0xd0d0d0)];
//        self.imageView.userInteractionEnabled = NO;
//        self.timeLabel.userInteractionEnabled = NO;
        
            [self setBackgroundColor:UIColorFromRGB16(0xd0d0d0)];
            self.enabled = NO;
    }
}
/**
 *  还原验证控件
 */
-(void)reset{
    [self canGetYzm:YES];
//    self.timeCount = self.timeCount2;
//    self.timeLabel.text = @"点击获取";
    [self.timer invalidTime];
    self.timer = nil;
    if ([_delegate respondsToSelector:@selector(endTimeCount)]) {
        [_delegate endTimeCount];
    }
}

@end
