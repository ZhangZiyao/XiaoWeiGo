//
//  RWTextField.h
//  ucupay
//
//  Created by dingxin on 2017/7/11.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWTextField : UITextField<UITextFieldDelegate>

@property (nonatomic, copy) NSString *tagString;
@property (nonatomic) NSNumber *textFieldMaxNumberOfCharacters;


+ (RWTextField *)initTextFieldWithPlaceHolder:(NSString *)placeHolder font:(UIFont *)font textColor:(UIColor *)color keyboardType:(UIKeyboardType)keyboardType;

+ (RWTextField *)initTextFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType;

+ (RWTextField *)initTextFieldWithPlaceHolder:(NSString *)placeHolder;

@end
