//
//  RWFactionUI.h
//  ucupay
//
//  Created by dingxin on 2017/7/29.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWFactionUI : UIView
+(UIView *)createViewWith:(CGRect)frame backgroundColor:(UIColor *)color;

+(UILabel *)createLabelWith:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)textFont textAlignment:(NSInteger)textAlignment;

+(UIButton *)createButtonWith:(CGRect)frame title:(NSString *)title backgroundImage  :(UIImage *)backImage textColor:(UIColor *)textColor target:(id)target selector:(SEL)selector;

+(UITextField *)createTextFieldWith:(CGRect)frame placeholder:(NSString *)text textFont:(UIFont *)textFont textFieldMode:(NSInteger)textFieldMode;
@end
