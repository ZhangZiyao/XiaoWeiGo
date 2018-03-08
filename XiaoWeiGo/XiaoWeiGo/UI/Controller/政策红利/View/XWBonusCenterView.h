//
//  XWBonusCenterView.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/12.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BonusCenterViewDelegate <NSObject>

@optional
-(void)didClickCenterButton:(UIButton *)button tag:(int)tag;

@end
@interface XWBonusCenterView : UIView

@property(nonatomic,weak) id<BonusCenterViewDelegate> delegate;

- (void)resetDataWithRegion:(int)region;

@end
