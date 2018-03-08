//
//  HomeTabView.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeTabViewDelegate <NSObject>

@optional
-(void)didClickButton:(UIButton *)button tag:(int)tag;

@end

@interface HomeTabView : UIView
@property(nonatomic,weak) id<HomeTabViewDelegate> delegate;
//+ (HomeTabView *)createView;
+ (CGFloat)height;
@end
