//
//  BonusHeaderView.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BonusTabViewDelegate <NSObject>

@optional
-(void)didClickButton:(UIButton *)button tag:(int)tag;

@end
@interface BonusHeaderView : UIView

@property(nonatomic,weak) id<BonusTabViewDelegate> delegate;

@property (nonatomic, strong) NSArray *dataArray;

+ (CGFloat)height;

@end
