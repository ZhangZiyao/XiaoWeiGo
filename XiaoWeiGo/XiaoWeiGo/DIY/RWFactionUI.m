//
//  RWFactionUI.m
//  ucupay
//
//  Created by dingxin on 2017/7/29.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "RWFactionUI.h"

@implementation RWFactionUI
+(UILabel *)createLabelWith:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)textFont textAlignment:(NSInteger)textAlignment{
    
    UILabel *label=[[UILabel alloc] init];
    label.frame=frame;
    label.text=text;
    label.textColor = textColor;
    label.font=textFont;
    label.textAlignment = textAlignment;
    
    return label;
}
+(UIView *)createViewWith:(CGRect)frame backgroundColor:(UIColor *)color{
    
    UIView *view=[[UIView alloc] init];
    view.frame=frame;
    view.backgroundColor = color;
    
    return view;
}
+(UIButton *)createButtonWith:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backImage textColor:(UIColor *)textColor target:(id)target selector:(SEL)selector{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setImage:backImage forState:UIControlStateNormal];
//    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UITextField *)createTextFieldWith:(CGRect)frame placeholder:(NSString *)text textFont:(UIFont *)textFont textFieldMode:(NSInteger)textFieldMode{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.frame=frame;
    textField.placeholder=text;
//    textField.textColor=UIColorFromRGB16(0x666666);
//    textField.tintColor = UIColorFromRGB16(0x666666);
//    textField.placeHolderColor=UIColorFromRGB16(0x999999);
    textField.font=textFont;
    textField.clearButtonMode = textFieldMode;
    textField.clearsOnBeginEditing = NO;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    return textField;
}
@end
