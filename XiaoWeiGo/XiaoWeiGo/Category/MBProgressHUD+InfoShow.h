//
//  MBProgressHUD+InfoShow.h
//  ucupay
//
//  Created by dingxin on 2017/7/11.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (InfoShow)

+ (void)showLoading;

+ (void)alertInfo:(NSString *)info;

+ (void)alertInfo:(NSString *)info afterTime:(NSTimeInterval)interval;

+ (MBProgressHUD *)showAlert:(NSString *)message;

+ (MBProgressHUD *)showAlert:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *)alertBarDeterminate;

- (void)currentProgress:(CGFloat)progress ;
- (void)uploadFail;

+ (void)hide;

//+ (MBProgressHUD *)showMessage:(NSString *)message;
//+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
