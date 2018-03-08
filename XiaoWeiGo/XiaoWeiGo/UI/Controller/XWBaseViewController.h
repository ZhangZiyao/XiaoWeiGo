//
//  XWBaseViewController.h
//  XiaoWei
//
//  Created by dingxin on 2018/1/26.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWBaseViewController : UIViewController

- (void)layoutSubviews;

- (void)showLeftItemWithItemImage:(NSString *)itemImage;

- (void)showRightItemWithItemImage:(NSString *)itemImage;

- (void)showBackItem;

- (void)navLeftItemClick;

- (void)navRightItemClick;

- (void)showLogin;

@end
