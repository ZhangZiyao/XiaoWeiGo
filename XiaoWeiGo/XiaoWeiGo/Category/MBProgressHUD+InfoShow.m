//
//  MBProgressHUD+InfoShow.m
//  ucupay
//
//  Created by dingxin on 2017/7/11.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "MBProgressHUD+InfoShow.h"

@implementation MBProgressHUD (InfoShow)
+ (void)showLoading
{
    MBProgressHUD *requestLoadingHud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    requestLoadingHud.label.text = @"加载中...";
    requestLoadingHud.label.numberOfLines = 0;
    requestLoadingHud.backgroundColor = [UIColor clearColor];
//    requestLoadingHud.backgroundView.backgroundColor = [UIColor clearColor];
    requestLoadingHud.userInteractionEnabled = NO;
    [requestLoadingHud showAnimated:YES];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showAlert:(NSString *)message
{
    return [self showAlert:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showAlert:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.attributedText = [message attrtbutedStringWithLineSpace:3 font:[UIFont systemFontOfSize:15] color:UIColorFromRGB16(0x333333)];
    hud.label.numberOfLines = 0;
    hud.label.textAlignment = NSTextAlignmentCenter;
    [hud.label sizeToFit];
    hud.userInteractionEnabled = YES;
    [hud hideAnimated:YES afterDelay:1.0f];
//    hud.labelText = message;
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    return hud;
}
+ (void)alertInfo:(NSString *)info
{
    [self hide];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = info;
    hud.label.attributedText = [info attrtbutedStringWithLineSpace:3 font:[UIFont systemFontOfSize:15] color:UIColorFromRGB16(0x333333)];
    hud.label.numberOfLines = 0;
    hud.label.textAlignment = NSTextAlignmentCenter;
    [hud.label sizeToFit];
    [hud hideAnimated:YES afterDelay:1.0f];
}

+ (void)alertInfo:(NSString *)info afterTime:(NSTimeInterval)interval
{
    [self hide];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.attributedText = [info attrtbutedStringWithLineSpace:3 font:[UIFont systemFontOfSize:16] color:UIColorFromRGB16(0x333333)];
    hud.label.numberOfLines = 0;
    hud.label.textAlignment = NSTextAlignmentCenter;
    [hud.label sizeToFit];
    [hud hideAnimated:YES afterDelay:interval];
}

+ (MBProgressHUD *)alertBarDeterminate
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = @"上传进度: 0%";
    return hud;
}

- (void)currentProgress:(CGFloat)progress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progress = progress;
        self.label.text = [NSString stringWithFormat:@"上传进度: %.0f%@", progress * 100,@"%"];
        if (progress == 1.0) {
            [self hideAnimated:YES];
        }
    });
    
}
- (void)uploadFail
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideAnimated:YES];
    });
}
+ (void)hide{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.backgroundColor = [UIColor redColor];
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}
@end
