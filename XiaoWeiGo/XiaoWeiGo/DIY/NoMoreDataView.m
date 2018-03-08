//
//  NoMoreDataView.m
//  ucupay
//
//  Created by dingxin on 2017/9/17.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "NoMoreDataView.h"

@implementation NoMoreDataView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initView:CGRectMake(0, 0, ScreenWidth, 40)];
    }
    return self;
}

- (void)initView:(CGRect)frame{
    self.frame = frame;
    UIView *footerView = [[UIView alloc] initWithFrame:self.frame];
    UILabel *label = [RWFactionUI createLabelWith:footerView.bounds text:@"没有更多数据了" textColor:[UIColor colorWithHex:@"666666"] textFont:[UIFont rw_regularFontSize:14] textAlignment:NSTextAlignmentCenter];
    [footerView addSubview:label];
    [self addSubview:footerView];
}

@end
